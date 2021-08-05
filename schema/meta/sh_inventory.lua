local INVENTORY = ix.meta.inventory

function INVENTORY:GetItemCount(uniqueID, onlyMain)
	local i = 0
	local quantity

	for _, v in pairs(self:GetItems(onlyMain)) do
		if (v.uniqueID == uniqueID) then
			quantity = (v.data or {}).quantity or nil

			if (quantity and quantity >= 2) then
				i = i + quantity
			else
				i = i + 1
			end
		end
	end

	return i
end

function INVENTORY:ItemFitStacks(item, onlyMain)
	local targetAssignments = {}
	local remainingQuantity

	if (item and item.isStackable) then
		local items = self:GetItemsByUniqueID(item.uniqueID, onlyMain)

		if (items) then
			remainingQuantity = item:GetData('quantity', 1)
			local maxQuantity = item.maxQuantity

			for _, targetItem in pairs(items) do
				if (targetItem:GetData("quantity", 1) >= maxQuantity) then continue end
				if (item.CanStack and item:CanStack(targetItem) == false) then continue end

				local freeSpace = maxQuantity - targetItem:GetData('quantity', 1)
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
		end
	end

	return targetAssignments, remainingQuantity
end

function INVENTORY:CanItemFitStack(item, onlyMain, useFiller, quantity)
	local result, remainingQuantity

	if (item and item.isStackable and item:GetData("quantity", 1) < item.maxQuantity) then
		local items = self:GetItemsByUniqueID(item.uniqueID, onlyMain)

		if (items) then
			if (useFiller) then
				remainingQuantity = quantity or item:GetData('quantity', 1)
			end

			local maxQuantity = item.maxQuantity

			for _, targetItem in pairs(items) do
				if (targetItem:GetData("quantity", 1) >= maxQuantity) then continue end
				if (item.CanStack and item:CanStack(targetItem) == false) then continue end

				local freeSpace = maxQuantity - targetItem:GetData('quantity', 1)
				if (freeSpace > 0) then
					if (!useFiller) then
						result = targetItem

						break
					else
						local filler = freeSpace - remainingQuantity
						if (filler > 0) then
							result = targetItem

							break
						end
					end
				end
			end
		end
	end

	return result
end