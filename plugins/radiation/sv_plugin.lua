local PLUGIN = PLUGIN

function PLUGIN:PlayerTick(client)
	if (client.ixInArea and client:Alive() and (!client.nextRadCheck or client.nextRadCheck <= CurTime())) then
		local area = ix.area.stored[client:GetArea()]

		if (area and area["type"] == "gas") then
			client.nextRadCheck = CurTime() + 1

			local oldRadiation = client:GetRadiationTotal()
			local radiationResistance = 0
			local radsIncrease = math.random(4, 20)

			local hasMask = client:GetGasMask()

			if (hasMask and hasMask:GetHealth() > 0 and hasMask:GetFilter() > 0) then
				hasMask:DamageFilter(0.25 * ix.config.Get("gasmask_damage", 1) * radsIncrease)

				-- Set 50% of radiation resistance
				radiationResistance = math.Clamp((hasMask:GetHealth() / ix.config.Get("gasmask_health", 100)) * 0.5, 0, 0.5)
			end

			radiationResistance = 1 - radiationResistance

			if ((client:HasBuff("radX") or 0) > CurTime()) then
				-- 0.6 = 1 - Rad-X Radiation Protection (40% resistance)
				radiationResistance = radiationResistance * 0.6
			end

			if (1 - client:GetHungerPercent() >= 0.9 and 1 - client:GetThirstPercent() >= 0.9) then -- well fed
				-- Set 20% of radiation resistance
				radiationResistance = radiationResistance * 0.8
			end

			local newRadiation = math.ceil(math.min(self.maxRads, oldRadiation + (radsIncrease * math.max(0, radiationResistance))))

			if (newRadiation >= self.maxRads) then
				client:Kill()
				client.nextRadCheck = CurTime() + 5
			elseif (newRadiation > 0) then
				newRadiation = CurTime() + newRadiation
				client:SetLocalVar("radiation", newRadiation)
			end
		end
	end
end

local nextTick = 0
function PLUGIN:Tick()
	if (nextTick > CurTime()) then return end

	local radLevel, radDamage

	for _, v in ipairs(player.GetAll()) do
		if (IsValid(v) and v:Alive() and (v.next_tick_rad or 0) < CurTime()) then
			radLevel = math.min(self.radLevel, v:GetRadiationLevel())
			radDamage = self.rad_damage[radLevel] or {1, 3}

			if (radLevel >= 1) then
				local newHealth = v:Health() - radDamage[1]

				if (newHealth <= 0) then
					v:Kill()
				else
					v:SetHealth(newHealth)
				end
			end

			v.next_tick_rad = CurTime() + radDamage[2]
		end
	end

	nextTick = CurTime() + 0.25
end

function PLUGIN:PlayerDeath(client)
	client.resetRadiation = true
end

function PLUGIN:PlayerSpawn(client)
	if (client.resetRadiation) then
		client:SetLocalVar("radiation", nil)
		client.resetRadiation = nil
	end
end

function PLUGIN:CharacterPreSave(character)
	character:SetData("radiation", character:GetPlayer():GetRadiationTotal())
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	local getRadiation = character:GetData("radiation")

	if (getRadiation) then
		getRadiation = CurTime() + getRadiation
	end

	client:SetLocalVar("radiation", getRadiation or nil)
end