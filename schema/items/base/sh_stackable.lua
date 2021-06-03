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

		local quantity = itemSelf:GetData("quantity", 1)

		Derma_NumericRequest(L"Split", L"split_enter_quantity", math.ceil(quantity / 2), function(text)
			local amount = math.max(0, math.Round(tonumber(text) or 0))

			if (amount != 0 and amount != quantity) then
				net.Start("ixItemSplit")
					net.WriteUInt(itemSelf.id, 32)
					net.WriteUInt(amount, 32)
				net.SendToServer()
			end
		end)

		return false
	end,
	OnCanRun = function(itemSelf)
		return !IsValid(itemSelf.entity) and itemSelf:GetData("quantity", 1) >= 2
	end
} ]]