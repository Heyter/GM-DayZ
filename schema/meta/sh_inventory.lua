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