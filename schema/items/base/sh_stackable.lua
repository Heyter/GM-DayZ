ITEM.name = "Stackable Items Base"
ITEM.description = "Stackable Item"
ITEM.category = "Stackable"
ITEM.model = Model('models/props_c17/TrapPropeller_Lever.mdl')
ITEM.maxQuantity = 16
ITEM.isStackable = true

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", 1)

		if (quantity > 1) then
			draw.SimpleTextOutlined("x" .. quantity, "ixMerchant.Num", w, h - 10, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	function ITEM:CanStack(combineItem)
		return true--combineItem:GetData("quantity", 1) == self:GetData("quantity", 1)
	end
end

function ITEM:CanSell()
	return true
end

ITEM.functions.combine = {
	OnRun = function(itemSelf, data)
		itemSelf:CombineStack(ix.item.instances[data[1]])
		return false
	end,
	OnCanRun = function(itemSelf, data)
		if (CLIENT) then
			if (istable(data) and data[1]) then
				local combineItem = ix.item.instances[data[1]]

				if (!combineItem or itemSelf.uniqueID != combineItem.uniqueID or 
					combineItem:GetData("quantity", 1) >= itemSelf.maxQuantity or
					itemSelf:GetData("quantity", 1) >= itemSelf.maxQuantity) then 
					return false
				else
					return true
				end
			else
				return false
			end
		end

		return istable(data) and data[1]
	end
}