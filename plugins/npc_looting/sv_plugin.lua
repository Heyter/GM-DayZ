ix.allowedHoldableClasses["gmodz_npc_loot"] = true

local v2 = Vector(0, 0, 32)

function PLUGIN:OnNPCKilled(npc, attacker, weapon)
	local config_rep = ix.config.Get("reputationSavior", 10)

	if (attacker:IsPlayer()) then
		net.Start("ixUpdateRep", true)
			net.WriteBool(false) -- положительная репутация
			net.WriteUInt(config_rep, 16)
		net.Send(attacker)

		attacker:AddReputation(config_rep)
	end

	-- generate loot
	local replication
	local inventory = ix.inventory.Create(ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), os.time() + npc:EntIndex())
	inventory.noSave = true
	inventory.isLoot = true

	local maxItems = math.random(0, 3)
	local has_item = nil
	local money = math.random(2, config_rep)

	if ((npc.KillReward or 0) > 0) then
		replication = true
		money = npc.KillReward * math.max(1, maxItems)
	elseif (money <= math.random(config_rep) * math.max(1, maxItems)) then
		replication = true
	else
		money = 0
	end

	if (maxItems > 0) then
		if (math.random() < 0.2) then -- шанс удваивания денег 20%
			money = money * 2
		end

		for i = 1, maxItems do
			local itemID = Schema.GetRandomWeightedItem(3)
			if (!itemID) then continue end

			inventory:Add(itemID, 1, nil, nil, nil, true)
			has_item = true
		end

		replication = true
	end

	if (!replication) then
		ix.item.inventories[inventory:GetID()] = nil
		inventory = nil
		return
	end

	local pos = npc:GetPos() + v2

	if (!has_item and money > 0) then
		ix.item.inventories[inventory:GetID()] = nil
		inventory = nil

		local entity = ents.Create("ix_money")
		entity:Spawn()
		entity:SetPos(pos + Vector(0, 0, -entity:OBBMins().z))
		entity:SetAmount(money)
		entity:SetAngles(angle_zero)
		entity:Activate()
	else
		-- entity loot
		local entity = ents.Create("gmodz_npc_loot")
		entity:Spawn()
		entity:SetPos(pos + Vector(0, 0, -entity:OBBMins().z))
		entity:SetAngles(angle_zero)

		if (money > 0) then
			entity:SetMoney(money)
		end

		entity:SetID(inventory:GetID())
	end
end