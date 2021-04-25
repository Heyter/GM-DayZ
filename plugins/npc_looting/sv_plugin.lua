function PLUGIN:OnNPCKilled(npc, entity, weapon)
	if (!entity:IsPlayer()) then return end -- если убийца не игрок

	-- репутация
	local rep = ix.config.Get("reputationSavior", 10)

	net.Start("ixUpdateRep")
		net.WriteBool(false) -- положительная репутация
		net.WriteUInt(rep, 16)
	net.Send(entity)
	entity:AddReputation(rep)

	-- generate loot
	local replication

	local money = math.random(100)
	if (money <= math.random(100)) then
		replication = true
	end

	if (!replication) then return end

	-- create inventory
	local inventory = ix.inventory.Create(ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), os.time() + npc:EntIndex())
	inventory.noSave = true
	inventory.isLoot = true

	-- цикл по предметам
	-- todo: сделать рандом
	--inventory:Add(uniqueID, quantity, data, nil, nil, true)

	-- entity loot
	local entity = ents.Create("prop_ragdoll")
	entity:SetPos(npc:GetPos())
	entity:SetAngles(npc:EyeAngles())
	entity:SetModel(npc:GetModel())
	entity:SetSkin(npc:GetSkin())

	for i = 0, (npc:GetNumBodyGroups() - 1) do
		entity:SetBodygroup(i, npc:GetBodygroup(i))
	end

	entity:Spawn()
	entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	entity:Activate()

	local velocity = npc:GetVelocity()

	for i = 0, entity:GetPhysicsObjectCount() - 1 do
		local physObj = entity:GetPhysicsObjectNum(i)

		if (IsValid(physObj)) then
			physObj:SetVelocity(velocity)

			local index = entity:TranslatePhysBoneToBone(i)

			if (index) then
				local position, angles = npc:GetBonePosition(index)

				physObj:SetPos(position)
				physObj:SetAngles(angles)
			end
		end
	end

	local uniqueID = "ixNPCCorpseDecay" .. entity:EntIndex()
	local decayTime = ix.config.Get("corpseDecayTime", 60)

	entity:RemoveCallOnRemove("fixer")
	entity:CallOnRemove("ixNPCCorpse", function(ragdoll)
		if (ragdoll.ixInventory) then
			ix.storage.Close(ragdoll.ixInventory)
			ix.item.inventories[ragdoll.ixInventory:GetID()] = nil
		end

		if (timer.Exists(uniqueID)) then
			timer.Remove(uniqueID)
		end

		ragdoll = nil
	end)

	function entity:SetMoney(amount)
		self.money = math.max(0, math.Round(tonumber(amount) or 0))
	end

	function entity:GetMoney()
		return self.money or 0
	end

	function entity:GetInventory()
		return ix.item.inventories[self.ixInventory:GetID()]
	end

	entity:SetMoney(money)

	if (decayTime > 0) then
		entity.ixCorpseDecayTime = CurTime() + decayTime

		timer.Create(uniqueID, 1, 0, function()
			if (IsValid(entity)) then
				if (entity.ixCorpseDecayTime < CurTime()) then
					entity:Remove()
					timer.Remove(uniqueID)
					return
				end

				local bItems = table.IsEmpty(inventory:GetItems(true))
				local bMoney = entity:GetMoney() < 1

				if (!bItems or !bMoney) then
					return
				end

				entity:Remove()
			end

			timer.Remove(uniqueID)
		end)
	end

	entity.ixInventory = inventory
end

function PLUGIN:PlayerUse(client, entity)
	if (entity:GetClass() == "prop_ragdoll" and entity.ixInventory and !ix.storage.InUse(entity.ixInventory)) then
		ix.storage.Open(client, entity.ixInventory, {
			entity = entity,
			name = "Corpse",
			searchText = "@searchingCorpse",
			searchTime = 0.5,
			data = {money = entity:GetMoney()}
		})

		return false
	end
end