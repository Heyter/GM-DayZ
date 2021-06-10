ITEM.base = "base_ammo"
ITEM.maxRounds = 30 -- макс. патронов помещаемых в одну коробку (авто.)
ITEM.maxQuantity = 16 -- макс. кол-во стакнутых коробок
ITEM.isStackable = true

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", 1)
		local rounds = item:GetData("rounds", item.ammoAmount)
		local color = ix.util.LerpColorHSV(nil, nil, item.maxRounds, rounds, 0)

		draw.SimpleTextOutlined(rounds, "ixMerchant.Num", 1, 5, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

		if (quantity > 1) then
			draw.SimpleTextOutlined("x" .. quantity, "ixMerchant.Num", w, h - 10, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	function ITEM:CanTooltip(targetItem)
		return targetItem.isWeapon and targetItem.ammo == self.ammo
	end
end

if (SERVER) then
	function ITEM:CanStack(combineItem)
		local rounds = self:GetData("rounds", self.ammoAmount)

		return combineItem:GetData("rounds", combineItem.ammoAmount) == rounds and rounds >= self.maxRounds
	end
else
	function ITEM:CanStack(combineItem, isVendor)
		local rounds = self:GetData("rounds", self.ammoAmount)
		local isEqual = combineItem:GetData("rounds", combineItem.ammoAmount) == rounds

		if (isVendor) then
			return isEqual
		end

		return isEqual and rounds >= self.maxRounds
	end
end

ITEM.functions.use = {
	name = "Load",
	tip = "useTip",
	icon = "icon16/add.png",
	OnRun = function(item)
		local rounds = item:GetData("rounds", item.ammoAmount)

		item.player:GiveAmmo(rounds, item.ammo)
		item.player:EmitSound(item.useSound, 110)

		return item:UseStackItem()
	end
}

ITEM.functions.combine = {
	OnRun = function(itemSelf, data)
        local combineItem = ix.item.instances[data[1]]
        if (!combineItem or itemSelf.uniqueID != combineItem.uniqueID) then return false end

		ix.arccw_support.StackAmmo(itemSelf, combineItem)
		return false
	end,

	OnCanRun = function(itemSelf, data)
		if (CLIENT) then
			if (istable(data) and data[1]) then
				local combineItem = ix.item.instances[data[1]]

				if (itemSelf.uniqueID != combineItem.uniqueID or 
					combineItem:GetData("quantity", 1) >= itemSelf.maxQuantity or
					itemSelf:GetData("quantity", 1) >= itemSelf.maxQuantity) then
					return false
				else
					return itemSelf:CanStack(combineItem)
				end
			else
				return false
			end
		end

		return istable(data) and data[1]
	end
}