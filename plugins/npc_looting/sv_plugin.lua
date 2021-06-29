ix.allowedHoldableClasses["gmodz_npc_loot"] = true

local v1 = Vector(0, 0, 5000)
local v2 = Vector(0, 0, 32)

function PLUGIN:OnNPCKilled(npc, attacker, weapon)
	if (!attacker:IsPlayer()) then return end

	local config_rep = ix.config.Get("reputationSavior", 10)

	net.Start("ixUpdateRep")
		net.WriteBool(false) -- положительная репутация
		net.WriteUInt(config_rep, 16)
	net.Send(attacker)

	attacker:AddReputation(config_rep)

	-- generate loot
	local replication
	local inventory = ix.inventory.Create(ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), os.time() + npc:EntIndex())
	inventory.noSave = true
	inventory.isLoot = true

	local maxItems = 0
	if (math.random() < 0.4) then -- 40% percent
		maxItems = math.random(0, 3)
	end

	local money = math.random(100)
	if (money <= math.random(100) * math.max(1, maxItems)) then
		replication = true
	else
		money = 0
	end

	if (maxItems > 0) then
		local itemID = nil

		for i = 1, maxItems do
			if (math.random() < 0.05) then -- 5% percent to drop rare item
				itemID = Schema.dropItems.rare[ math.random( #Schema.dropItems.rare ) ]
			else
				itemID = Schema.dropItems.common[ math.random( #Schema.dropItems.common ) ]

				if (money > 0) then
					money = money * 2
				end
			end

			inventory:Add(itemID, 1, nil, nil, nil, true)
		end

		replication = true
	end

	if (!replication) then
		ix.item.inventories[inventory:GetID()] = nil
		inventory = nil
		return
	end

	local pos = npc:GetPos() + v2
	local trace = util.TraceLine({
		start = pos,
		endpos = pos - v1
	})

	if (maxItems == 0 and money > 0) then
		ix.item.inventories[inventory:GetID()] = nil
		inventory = nil

		local entity = ents.Create("ix_money")
		entity:Spawn()
		entity:SetPos(trace.HitPos - trace.HitNormal * entity:OBBMins().z)
		entity:SetAmount(money)
		entity:SetAngles(angle_zero)
		entity:Activate()
	else
		-- entity loot
		local entity = ents.Create("gmodz_npc_loot")
		entity:Spawn()
		entity:SetPos(trace.HitPos - trace.HitNormal * entity:OBBMins().z)
		entity:SetAngles(angle_zero)

		if (money > 0) then
			entity:SetMoney(money)
		end

		entity:SetID(inventory:GetID())
	end
end