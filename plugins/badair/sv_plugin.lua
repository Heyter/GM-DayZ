resource.AddFile("sound/gmodz/player/gasmask_wear.wav")
resource.AddFile("gmodz/player/gasmask_inhale.wav")
resource.AddFile("gmodz/player/gasmask_exhale.wav")
resource.AddFile("materials/gmdz/gasmask.vmt")
resource.AddFile("materials/gmdz/gasmask.vtf")
resource.AddFile("materials/gmdz/gasmask_n.vtf")
resource.AddFile("materials/gmdz/shtr.vmt")
resource.AddFile("materials/gmdz/shtr.vtf")
resource.AddFile("materials/gmdz/shtr_n.vtf")

util.AddNetworkString("ixMskAdd")
util.AddNetworkString("ixMaskOff")
util.AddNetworkString("ixMaskOn")

local PLUGIN = PLUGIN

--- plugins\radiation\sv_plugin.lua
-- local white = ColorAlpha(color_white, 150)

-- function PLUGIN:PlayerTick(client)
	-- if (!IsValid(client) or !client:Alive()) then return end
	
	-- local faction = ix.faction.Get(client:Team())

	-- if (faction and faction.noGas) then
		-- return
	-- end

	-- local area = ix.area.stored[client:GetArea()]

	-- if ((!client.gasTick or client.gasTick <= CurTime()) and client.ixInArea) then
		-- if (area and area["type"] == "gas") then
			-- local item = client:GetGasMask()
			-- local bool

			-- if (item and item.isGasMask) then
				-- if (item:GetHealth() <= 0) then
					-- bool = nil
				-- else
					-- if (item:GetFilter() <= 0) then
						-- bool = nil
					-- else
						-- bool = true
					-- end
				-- end
			-- else
				-- bool = nil
			-- end

			-- if (bool) then
				-- item:DamageFilter(ix.config.Get("gasmask_damage", 1))
			-- else
				-- client:TakeDamage(ix.config.Get("gasDamage", 3))
				-- client:ScreenFade(1, white, .5, 0)
			-- end

			-- if (bool) then
				-- client.gasTick = CurTime() + ix.config.Get("gasDelay", 2)
			-- else
				-- client.gasTick = CurTime() + ix.config.Get("gasDelayBad", 1.3)
			-- end
		-- end
	-- end
-- end

function PLUGIN:PlayerLoadedCharacter(client, curChar)
	if (curChar) then
		local inv = curChar:GetInventory()
		local gasItem 

		for _, v in pairs(inv:GetItems()) do
			if (v.isGasMask and v:GetData("equip")) then
				gasItem = v

				break
			end
		end

		if (gasItem) then
			client.ixGasMaskItem = gasItem

			net.Start("ixMaskOn")
				net.WriteUInt(gasItem:GetID(), 32)
				net.WriteUInt(gasItem:GetHealth(), 16)
			net.Send(client)
		else
			client.ixGasMaskItem = nil

			net.Start("ixMaskOff")
			net.Send(client)
		end
	end
end

function PLUGIN:PlayerDeath(client)
	local item = client:GetGasMask()

	if (item and item.isGasMask and item:GetData("equip")) then
		item:Unequip(client)
	end
end

-- This hook simulates the damage of the Gas Mask.
function PLUGIN:PostPlayerTakeDamage(client, dmgInfo)
	local item = client:GetGasMask()

	if (item and item.isGasMask) then
		local damage = dmgInfo:GetDamage() * .5
		item:DamageHealth(damage)

		if (client:GetHealth() - damage <= 0) then
			return
		end

		local crackNums = math.Round((1 - item:GetHealth() / ix.config.Get("gasmask_health", 100)) * 6)

		if (item.curCracks and item.curCracks < crackNums) then
			net.Start("ixMskAdd")
			net.Send(client)
		end

		item.curCracks = crackNums
	end
end