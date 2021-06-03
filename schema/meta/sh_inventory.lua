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

function INVENTORY:CanItemFitStack(item, onlyMain)
	local result

	if (item and item.isStackable) then
		local items = self:GetItemsByUniqueID(item.uniqueID, onlyMain)

		if (items) then
			local maxQuantity = item.maxQuantity

			for _, targetItem in pairs(items) do
				if (targetItem:GetData("quantity", 1) >= maxQuantity) then continue end
				if (item.CanStack and item:CanStack(targetItem) == false) then continue end

				result = targetItem
				break
			end
		end
	end

	return result
end