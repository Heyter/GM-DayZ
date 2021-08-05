local INVENTORY = ix.meta.inventory

function INVENTORY:Add(uniqueID, quantity, data, x, y, noReplication, split)
	quantity = quantity or 1

	if (quantity < 1) then
		return false, "noOwner"
	end

	if (!isnumber(uniqueID) and quantity > 1) then
		for _ = 1, quantity do
			local bSuccess, error = self:Add(uniqueID, 1, data)

			if (!bSuccess) then
				return false, error
			end
		end

		return true
	end

	local client = self.GetOwner and self:GetOwner() or nil
	local item = isnumber(uniqueID) and ix.item.instances[uniqueID] or ix.item.list[uniqueID]
	local targetInv = self
	local bagInv

	if (!item) then
		return false, "invalidItem"
	end

	local isStackable = !split and item.isStackable

	if (isStackable) then
		local copyItem = item

		if (!isnumber(uniqueID) and data) then
			copyItem = setmetatable({id = uniqueID, data = data}, {
				__index = item,
				__eq = item.__eq,
				__tostring = item.__tostring
			})

			copyItem.resetData = true
		end

		local remainingQuantity = copyItem:GetData('quantity', quantity)
		local targetAssignments = {}

		if (remainingQuantity < (copyItem.maxQuantity or 16)) then
			local items = targetInv:GetItemsByUniqueID(copyItem.uniqueID, true)

			if (items) then
				for _, targetItem in pairs(items) do
					if (remainingQuantity == 0) then
						break 
					end

					if (copyItem.CanStack and copyItem:CanStack(targetItem) == false) then continue end
					local freeSpace = targetItem.maxQuantity - targetItem:GetData('quantity', 1)

					if (freeSpace > 0) then
						local filler = freeSpace - remainingQuantity

						if (filler > 0) then
							targetAssignments[targetItem] = remainingQuantity	
							remainingQuantity = 0
						else
							targetAssignments[targetItem] = freeSpace		
							remainingQuantity = math.abs(filler)
						end
					end
				end

				if (remainingQuantity == 0) then
					for targetItem, assignedQuantity in pairs(targetAssignments) do
						targetItem:SetData("quantity", targetItem:GetData('quantity', 1) + assignedQuantity, true)
					end

					if (copyItem.resetData) then
						copyItem = nil
					end

					return true, "stack"
				end
			end
		end

		if (copyItem.resetData) then
			copyItem = nil
		end

		if (!x and !y) then
			x, y = self:FindEmptySlot(item.width, item.height, true)
		else
			if (self:GetItemAt(x, y)) then
				x, y = nil, nil
				x, y = self:FindEmptySlot(item.width, item.height, true)
			end
		end

		if (!x and !y or self:GetItemAt(x, y)) then
			return false, 'noFit'
		end
	end

	if (isnumber(uniqueID)) then
		local oldInvID = item.invID

		if (!x and !y) then
			x, y, bagInv = self:FindEmptySlot(item.width, item.height)
		end

		if (bagInv) then
			targetInv = bagInv
		end

		-- we need to check for owner since the item instance already exists
		if (!item.bAllowMultiCharacterInteraction and IsValid(client) and client:GetCharacter() and
			item:GetPlayerID() == client:SteamID64() and item:GetCharacterID() != client:GetCharacter():GetID()) then
			return false, "itemOwned"
		end

		if (hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInv) == false) then
			return false, "notAllowed"
		end

		if (x and y) then
			targetInv.slots[x] = targetInv.slots[x] or {}
			targetInv.slots[x][y] = true

			item.gridX = x
			item.gridY = y
			item.invID = targetInv:GetID()

			for x2 = 0, item.width - 1 do
				local index = x + x2

				for y2 = 0, item.height - 1 do
					targetInv.slots[index] = targetInv.slots[index] or {}
					targetInv.slots[index][y + y2] = item
				end
			end

			if (!noReplication) then
				targetInv:SendSlot(x, y, item)
			end

			if (!self.noSave) then
				local query = mysql:Update("ix_items")
					query:Update("inventory_id", targetInv:GetID())
					query:Update("x", x)
					query:Update("y", y)
					query:Where("item_id", item.id)
				query:Execute()
			end

			hook.Run("InventoryItemAdded", ix.item.inventories[oldInvID], targetInv, item, split)

			return x, y, targetInv:GetID()
		else
			return false, "noFit"
		end
	else
		if (!x and !y) then
			x, y, bagInv = self:FindEmptySlot(item.width, item.height)
		end

		if (bagInv) then
			targetInv = bagInv
		end

		if (hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInv) == false) then
			return false, "notAllowed"
		end

		if (x and y) then
			for x2 = 0, item.width - 1 do
				local index = x + x2

				for y2 = 0, item.height - 1 do
					targetInv.slots[index] = targetInv.slots[index] or {}
					targetInv.slots[index][y + y2] = true
				end
			end

			local characterID
			local playerID

			if (self.owner) then
				local character = ix.char.loaded[self.owner]

				if (character) then
					characterID = character.id
					playerID = character.steamID
				end
			end

			ix.item.Instance(targetInv:GetID(), uniqueID, data, x, y, function(newItem)
				newItem.gridX = x
				newItem.gridY = y

				for x2 = 0, newItem.width - 1 do
					local index = x + x2

					for y2 = 0, newItem.height - 1 do
						targetInv.slots[index] = targetInv.slots[index] or {}
						targetInv.slots[index][y + y2] = newItem
					end
				end

				if (!noReplication) then
					targetInv:SendSlot(x, y, newItem)
				end

				hook.Run("InventoryItemAdded", nil, targetInv, newItem, split)
			end, characterID, playerID)

			return x, y, targetInv:GetID()
		else
			return false, "noFit"
		end
	end
end