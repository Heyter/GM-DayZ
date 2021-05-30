ITEM.name = "Stackable Items Base"
ITEM.description = "Stackable Item"
ITEM.category = "Stackable"
ITEM.model = Model('models/props_c17/TrapPropeller_Lever.mdl')
ITEM.maxStacks = 16

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("stacks", 1), "ixMerchant.Num", w - 5, h - 5, Color("light_green"), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.combine = {
	OnRun = function(itemSelf, data)
        local combineItem = ix.item.instances[data[1]]
        if (itemSelf.uniqueID != combineItem.uniqueID) then return false end

		local maxStacks = itemSelf.maxStacks
		local stacks = itemSelf:GetData("stacks", 1)
		local combineStacks = combineItem:GetData("stacks", 1)

		if (combineStacks >= maxStacks or stacks >= maxStacks) then return end
		local totalStacks = combineStacks + stacks

		if (totalStacks > maxStacks) then
			itemSelf:SetData("stacks", maxStacks)
			combineItem:SetData("stacks", totalStacks - maxStacks)
		else
			combineItem:Remove()
			itemSelf:SetData("stacks", stacks + combineStacks)
		end

		stacks, combineStacks, totalStacks, maxStacks = nil, nil, nil, nil

		return false
	end,
	OnCanRun = function(itemSelf, data)
		if (CLIENT) then
			if (istable(data) and data[1]) then
				local combineItem = ix.item.instances[data[1]]

				if (itemSelf.uniqueID != combineItem.uniqueID or 
					combineItem:GetData("stacks", 1) >= itemSelf.maxStacks or
					itemSelf:GetData("stacks", 1) >= itemSelf.maxStacks) then 
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