ITEM.base = "base_ammo"
ITEM.maxRounds = 30 -- макс. патронов помещаемых в одну коробку (авто.)
ITEM.maxQuantity = 16 -- макс. кол-во стакнутых коробок патронов

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", 1)
		local rounds = item:GetData("rounds", item.ammoAmount)
		local color = quantity <= 1 and ix.util.LerpColorHSV(nil, nil, item.maxRounds, rounds, 1) or Color("green")

		draw.SimpleTextOutlined(
			quantity <= 1 and rounds or Format("%d (x%d)", rounds, quantity), 
			"ixMerchant.Num", 1, 5, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black
		)
	end

	function ITEM:CanStack(combineItem)
		return combineItem:GetData("rounds", combineItem.ammoAmount) == self:GetData("rounds", self.ammoAmount) and
			combineItem:GetData("quantity", 1) == self:GetData("quantity", 1)
	end
end

ITEM.functions.use = {
	name = "Load",
	tip = "useTip",
	icon = "icon16/add.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", 1) - 1
		local rounds = item:GetData("rounds", item.ammoAmount)

		item.player:GiveAmmo(rounds, item.ammo)
		item.player:EmitSound(item.useSound, 110)

		if (quantity < 1) then
			return true
		end

		item:SetData("quantity", quantity)
		return false
	end,
}

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
					combineItem:GetData("quantity", 1) >= itemSelf.maxQuantity or
					itemSelf:GetData("quantity", 1) >= itemSelf.maxQuantity or
					combineItem:GetData("rounds", combineItem.ammoAmount) >= itemSelf.maxRounds or
					itemSelf:GetData("rounds", itemSelf.ammoAmount) >= itemSelf.maxRounds) then 
					return false
				else
					return combineItem:GetData("rounds", combineItem.ammoAmount) == rounds
				end
			else
				return false
			end
		end

		return istable(data) and data[1]
	end
}