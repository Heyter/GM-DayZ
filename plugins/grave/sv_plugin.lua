local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(client)
	local replication

	-- create inventory
	local character = client:GetCharacter()
	local charInventory = character:GetInventory()
	local width, height = charInventory:GetSize()

	local inventory = ix.inventory.Create(width, height, os.time() + client:EntIndex())
	inventory.noSave = true
	inventory.isGrave = true

	for _, slot in pairs(charInventory.slots) do
		for _, item in pairs(slot) do
			if (item:GetData("equip")) then
				client:RemoveEquippableItem(item)
			end

			if (item.OnTransferred and item.isBag) then
				item:OnTransferred(charInventory, inventory)
			end

			item.invID = inventory:GetID()
		end
	end

	inventory.slots = table.Copy(charInventory.slots)

	if (!table.IsEmpty(inventory.slots)) then
		replication = true

		local query = mysql:Update("ix_items")
			query:Update("inventory_id", 0)
			query:Where("inventory_id", charInventory:GetID())
		query:Execute()

		charInventory.slots = {}
		charInventory:Sync(client)
	end

	local money = character:GetMoney()

	if (money > 0) then
		character:SetMoney(0)
		replication = true
	end

	if (!replication) then
		ix.item.inventories[inventory:GetID()] = nil
		return
	end

	hook.Run("OnPlayerGraveCreated", client, money, inventory:GetID())
end

function PLUGIN:InventoryItemAdded(_, newInv, item)
	if (newInv and newInv.isGrave) then
		local query = mysql:Update("ix_items")
			query:Update("inventory_id", 0)
			query:Where("item_id", item.id)
		query:Execute()
	end
end

function PLUGIN:OnPlayerGraveCreated(client, money, inventoryID)
	local pos = client:GetPos()

	local trace = {}
	trace.start = pos
	trace.endpos = pos - Vector(0, 0, 5000)
	local hitPos = util.TraceLine(trace).HitPos

	local entity = ents.Create("gmodz_grave")
	entity:Spawn()
	entity:SetPos(pos + Vector(0, 0, 16))
	-- entity:SetPos(position + (entity:GetPos() - entity:NearestPoint(position - (normal * 512))));
	entity:SetAngles(client:GetAngles())
	entity:SetStoredName(client:Nick())
	entity:SetStoredID(client:SteamID64())
	entity:SetReputation(client:GetReputationLevel())
	entity.MinZ = entity:OBBMins().z

	if (money > 0) then
		entity:SetMoney(money)
	end

	entity:SetID(inventoryID)

	hook.Add("Tick", entity, function(this)
		local dist = hitPos:Distance(this:GetPos())
		local speed = dist / 30

		if (dist <= (this.MinZ * -1)) then
			hook.Remove("Tick", this)
		else
			this:SetPos(this:GetPos() - Vector(0, 0, 1 * speed))
		end
	end)
end