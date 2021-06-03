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
	end,
}

--[[ ITEM.functions.Split = {
	name = "Split",
	icon = "icon16/arrow_divide.png",
	OnClick = function(itemSelf)
		local inventory = ix.inventory.Get(itemSelf.invID)
		if (!inventory) then return false end

		if (!inventory:CanItemFitStack(itemSelf, true)) then
			local panel = ix.gui["inv" .. inventory:GetID()]
			local invW, invH = inventory:GetSize()
			local x2, y2

			for x = 1, invW do
				for y = 1, invH do
					if (!IsValid(panel)) then break end
					if (panel:IsAllEmpty(x, y, itemSelf.width, itemSelf.height)) then
						x2 = x
						y2 = y
					end
				end
			end

			if !(x2 and y2) then
				LocalPlayer():NotifyLocalized("noFit")
				return false
			end
		end

		local rounds = itemSelf:GetData("rounds", itemSelf.ammoAmount)
		local quantity = itemSelf:GetData("quantity", 1)

		if (quantity >= 2) then
			rounds = quantity
		end

		Derma_NumericRequest(L"Split", L"split_enter_quantity", math.ceil(rounds / 2), function(text)
			local amount = math.max(0, math.Round(tonumber(text) or 0))

			if (amount != 0) then
				if (quantity >= 2) then
					if (amount == quantity) then return end
				else
					if (amount == rounds) then return end
				end

				net.Start("ixArcCWAmmoSplit")
					net.WriteUInt(itemSelf.id, 32)
					net.WriteUInt(amount, 32)
				net.SendToServer()
			end
		end)

		return false
	end,
	OnCanRun = function(itemSelf)
		return !IsValid(itemSelf.entity) and itemSelf:GetData("rounds", itemSelf.ammoAmount) > 1
	end
} ]]

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