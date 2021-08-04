local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(client)
	local character = client:GetCharacter()
	if (!character) then return end

	local replication
	local charInventory = character:GetInventory()

	-- loot inventory
	local inventory = ix.inventory.Create(charInventory.w, charInventory.h, os.time() + client:EntIndex())
	inventory.noSave = true
	inventory.isGrave = true

	for _, slot in pairs(charInventory.slots) do
		for _, item in pairs(slot) do
			item.bAllowMultiCharacterInteraction = true
			replication = replication or true

			if (item:GetData("equip")) then
				client:RemoveEquippableItem(item)

				if (item:GetData("equip")) then
					item:SetData("equip", nil, false)
				end
			end

			item:Transfer(inventory:GetID(), item.gridX, item.gridY)
		end
	end

	if (replication) then
		charInventory.slots = {}
		charInventory:HalfSync(client) // TODO: вынести в мету HalfSync
	end

	local money = character:GetMoney()

	if (money > 0) then
		character:SetMoney(0)
		replication = true
	end

	if (!replication) then
		ix.item.inventories[inventory:GetID()] = nil
		inventory = nil
		return
	end

	hook.Run("OnPlayerGraveCreate", client, money, inventory:GetID())
end

function PLUGIN:InventoryItemAdded(_, newInv, item)
	if (newInv and newInv.isGrave) then
		local query = mysql:Update("ix_items")
			query:Update("inventory_id", 0)
			query:Where("item_id", item.id)
		query:Execute()
	end
end

local v1 = Vector(0, 0, 5000)
function PLUGIN:OnPlayerGraveCreate(client, money, inventoryID)
	local pos = client:GetPos()
	local trace = util.TraceLine({
		start = pos,
		endpos = pos - v1
	})

	local entity = ents.Create("gmodz_grave")
	entity:Spawn()
	entity:SetPos(trace.HitPos - trace.HitNormal * entity:OBBMins().z)
	entity:SetAngles(client:GetAngles())
	entity:SetStoredName(client:Nick())
	entity:SetStoredID(client:SteamID64())
	entity:SetReputation(client:GetReputationLevel())

	if (money > 0) then
		entity:SetMoney(money)
	end

	entity:SetID(inventoryID)

	trace = nil
end