local ITEM = ix.meta.item

function ITEM:UseStackItem(bMaxQuantity)
	local quantity = self:GetData("quantity", 1)
	local newQuantity = quantity - (bMaxQuantity and quantity or 1)

	if (newQuantity < 1) then
		return true, quantity
	end

	self:SetData("quantity", newQuantity)

	return false, quantity
end

function ITEM:CombineStack(combineItem)
	if (!combineItem) then return end
	if (self.uniqueID != combineItem.uniqueID) then return end

	local maxQuantity = self.maxQuantity
	local quantity = self:GetData("quantity", 1)
	local combineQuantity = combineItem:GetData("quantity", 1)

	if (combineQuantity >= maxQuantity or quantity >= maxQuantity) then return end
	local totalQuantity = combineQuantity + quantity

	if (totalQuantity > maxQuantity) then
		self:SetData("quantity", maxQuantity)
		combineItem:SetData("quantity", totalQuantity - maxQuantity)
	else
		combineItem:Remove()
		self:SetData("quantity", quantity + combineQuantity)
	end

	maxQuantity, quantity, combineQuantity, totalQuantity = nil, nil, nil, nil
end