ix.allowedHoldableClasses["gmodz_npc_loot"] = true

local v2 = Vector(0, 0, 32)

function PLUGIN:OnNPCKilled(npc, attacker, weapon)
	if (attacker:IsPlayer()) then
		local config_rep = ix.config.Get("reputationSavior", 10)

		net.Start("ixUpdateRep")
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

	local maxItems = 0
	if (math.random() < 0.17) then -- 17% шанс дропа вещей
		maxItems = math.random(0, 3)
	end

	local money = math.random(100)

	if ((npc.KillReward or 0) > 0) then
		replication = true
		money = npc.KillReward * math.max(1, maxItems)
	elseif (money <= math.random(100) * math.max(1, maxItems)) then
		replication = true
	else
		money = 0
	end

	if (maxItems > 0) then
		for i = 1, maxItems do
			local itemID, isRare = Schema.GetRandomItem(0.05)
			if (!itemID) then continue end

			if (isRare) then
				money = money * 2
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

	if (maxItems == 0 and money > 0) then
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