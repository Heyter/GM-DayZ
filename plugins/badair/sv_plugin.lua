resource.AddFile("sound/gasmaskon.wav")
resource.AddFile("sound/gasmaskoff.wav")
resource.AddFile("sound/gmsk_in.wav")
resource.AddFile("sound/gmsk_out.wav")
resource.AddFile("materials/gasmask_fnl.vmt")
resource.AddFile("materials/gasmask3.vtf")
resource.AddFile("materials/gasmask3_n.vtf")
resource.AddFile("materials/shtr_01.vmt")
resource.AddFile("materials/shtr.vtf")
resource.AddFile("materials/shtr_n.vtf")

util.AddNetworkString("ixMskAdd")
util.AddNetworkString("ixMaskOff")
util.AddNetworkString("ixMaskOn")

local PLUGIN = PLUGIN

function PLUGIN:PlayerTick(client)
	if (!IsValid(client) or !client:Alive()) then return end
	
	local faction = ix.faction.Get(client:Team())

	if (faction and faction.noGas) then
		return
	end
	
	local area = ix.area.stored[client:GetArea()]
	
	if ((!client.gasTick or client.gasTick <= CurTime()) and client.ixInArea) then
		if (area["type"] == "gas") then
			local item = client:GetGasMask()
			local bool
			
			if (item and item.isGasMask) then
				if (item:GetHealth() <= 0) then
					bool = false
				else
					if (item:GetFilter() <= 0) then
						bool = false
					else
						bool = true
					end
				end
			else
				bool = false
			end

			if (bool) then
				item:DamageFilter(ix.config.Get("gasmask_damage", 1))
			else
				client:TakeDamage(ix.config.Get("gasDamage", 3))
				client:ScreenFade(1, ColorAlpha(color_white, 150), .5, 0)
			end

			if (bool) then
				client.gasTick = CurTime() + ix.config.Get("gasDelay", 2)
			else
				client.gasTick = CurTime() + ix.config.Get("gasDelayBad", 1.3)
			end
		end
	end
end

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
function PLUGIN:EntityTakeDamage(client, dmgInfo)
	if (client and client:IsPlayer()) then
		local item = client:GetGasMask()

		if (item and item.isGasMask) then
			local damage = dmgInfo:GetDamage() * .5
			item:DamageHealth(damage)

			local crackNums = math.Round((1 - item:GetHealth()/ix.config.Get("gasmask_health", 100))*6)

			if (item.curCracks and item.curCracks < crackNums) then
				net.Start("ixMskAdd")
				net.Send(client)
			end

			item.curCracks = crackNums
		end
	end
end