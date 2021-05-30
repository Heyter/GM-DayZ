ITEM.base = "base_ammo"
ITEM.maxStacks = 180

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("rounds", item.ammoAmount), "ixMerchant.Num", 1, 5, Color("light_green"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
	end

	function ITEM:CanStack(combineItem)
		return combineItem:GetData("rounds", combineItem.ammoAmount) == self:GetData("rounds", self.ammoAmount)
	end
end

ITEM.functions.combine = {
	OnRun = function(itemSelf, data)
        local combineItem = ix.item.instances[data[1]]
        if (itemSelf.uniqueID != combineItem.uniqueID) then return false end

		ix.arccw_support.StackAmmo(itemSelf, combineItem)
		return false
	end,

	OnCanRun = function(itemSelf, data)
		if (CLIENT) then
			if (istable(data) and data[1]) then
				local combineItem = ix.item.instances[data[1]]

				if (itemSelf.uniqueID != combineItem.uniqueID or 
					combineItem:GetData("rounds", combineItem.ammoAmount) >= itemSelf.maxStacks or
					itemSelf:GetData("rounds", itemSelf.ammoAmount) >= itemSelf.maxStacks) then 
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