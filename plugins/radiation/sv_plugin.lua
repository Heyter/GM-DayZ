local PLUGIN = PLUGIN
local CurTime, math, allPlayers = CurTime, math, player.GetAll

util.AddNetworkString("ixSetRadiation")
util.AddNetworkString('ixClearRadiation')

timer.Create("ixRadiation", 1, 0, function()
	local radLevel, radDamage

	for _, client in ipairs(allPlayers()) do
		if (client:GetCharacter() and client:Alive()) then
			local radiation = client:GetRadiationTotal()

			if ((client.next_tick_rad or 0) < CurTime()) then
				radLevel = math.min(PLUGIN.radLevel, math.floor(radiation / PLUGIN.radsScale))
				radDamage = PLUGIN.rad_damage[radLevel] or {2, 3}

				client.next_tick_rad = CurTime() + radDamage[2]

				if (radLevel >= 1) then
					local newHealth = client:Health() - radDamage[1]

					if (newHealth <= 0) then
						client:KillFeed("radiation")
					else
						client:SetHealth(newHealth)
					end
				end
			end

			if (client.ixInArea) then
				local area = ix.area.stored[client:GetArea()]

				if (area and area["type"] == "gas") then
					client.radiation = client.radiation or {real = 0}
					client.radiation.addictive = client.radiation.addictive or radiation

					local radiationResistance = 0
					local radsIncrease = math.random(4, 20)

					local hasMask = client:GetGasMask()

					if (hasMask and hasMask:GetHealth() > 0 and hasMask:GetFilter() > 0) then
						hasMask:DamageFilter(0.25 * ix.config.Get("gasmask_damage", 1) * radsIncrease)

						-- Set 50% of radiation resistance
						radiationResistance = math.Clamp((hasMask:GetHealth() / ix.config.Get("gasmask_health", 100)) * 0.5, 0, 0.5)
					end

					radiationResistance = 1 - radiationResistance

					-- TODO: сделать hook через который считать резисты в бафах
					--local buff_radx = client:HasBuff("radx")
					--if (buff_radx and buff_radx.time > CurTime()) then
					if (client:HasBuff("radx")) then
						-- 0.6 = 1 - Rad-X Radiation Protection (40% resistance)
						radiationResistance = radiationResistance * 0.6
					end

					if (1 - client:GetHungerPercent() >= 0.9 and 1 - client:GetThirstPercent() >= 0.9) then -- well fed
						-- Set 20% of radiation resistance
						radiationResistance = radiationResistance * 0.8
					end

					local newRadiation = math.ceil(math.min(PLUGIN.maxRads, client.radiation.addictive + (radsIncrease * math.max(0, radiationResistance))))

					if (newRadiation >= PLUGIN.maxRads) then
						client:KillFeed("radiation")
					elseif (newRadiation > 0) then
						client.radiation.addictive = newRadiation
						client:SetRadiation(newRadiation, false)
					end
				end
			elseif (!client.ixInArea and client.radiation and client.radiation.addictive) then
				client:SetRadiation(client.radiation.addictive, true)
				client.radiation.addictive = nil
			end
		end
	end
end)

function PLUGIN:PlayerDeath(client)
	client.resetRadiation = true
end

function PLUGIN:PlayerSpawn(client)
	if (client.resetRadiation) then
		client:ClearRadiation()
		client.resetRadiation = nil
	end
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	if (client.resetRadiation and !client:Alive()) then return end

	local rad = client:GetRadiationTotal()

	if (rad < 10) then
		rad = nil
	end

	character:SetData("radiation", rad, true)
end

function PLUGIN:OnCharacterDisconnect(client, character)
	if (!client:Alive()) then
		character:SetData("radiation", nil, true)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	local rad = character:GetData("radiation")

	if (rad) then
		client:SetRadiation(rad, true)
	else
		client:ClearRadiation()
	end
end

do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:SetRadiation(amount, bReal)
		self.radiation = self.radiation or {real = 0}

		if (!bReal) then
			self.radiation.fake = amount
		else
			amount = CurTime() + amount

			self.radiation.real = amount
			self.radiation.fake = nil
		end

		net.Start("ixSetRadiation")
			net.WriteUInt(amount, 32)
			net.WriteBool(bReal)
		net.Send(self)
	end

	-- Отрицательные значения выводят радиацию
	function playerMeta:AddRadiation(amount)
		if (!isnumber(amount)) then return end
		self.radiation = self.radiation or {real = 0}

		if (self.radiation.addictive) then
			self.radiation.addictive = math.max(0, self.radiation.addictive + amount)
			return
		end

		local newRadiation = self:GetRadiationTotal() + amount

		if (newRadiation < 1) then
			self:ClearRadiation()
		else
			self:SetRadiation(newRadiation, true)
		end
	end

	function playerMeta:ClearRadiation()
		self.radiation = {real = 0}

		net.Start("ixClearRadiation")
		net.Send(self)
	end
end