local PLUGIN = PLUGIN

PLUGIN.name = "Merchant"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Adds a merchant of things."

-- Go away, asshole.

ix.config.Add("merchantSellPerc", 0.7, "Множитель процента продажи/покупки предмета", nil, {
	data = {min = 0, max = 1, decimals = 1},
	category = PLUGIN.name
})

function PLUGIN:CalculatePrice(item, isSellingToVendor, client)
	local price = ix.item.list[item.uniqueID].price or 0
	local scale = ix.config.Get("merchantSellPerc", 0.7)

	if (isSellingToVendor) then
		if (item.GetSellPrice) then
			price = item:GetSellPrice(price, scale)
		else
			price = price * scale
		end
	else
		price = (item.price or price) / scale / scale
	end

	price = hook.Run("MerchantCalculatePrice", client, price, scale, isSellingToVendor) or price

	return math.max(0, math.floor(price))
end

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	PLUGIN.virtual_items = PLUGIN.virtual_items or {}

	function PLUGIN:MakeVirtualItem(uniqueID, id)
		if (self.virtual_items[id] and self.virtual_items[id].uniqueID == uniqueID) then
			return self.virtual_items[id]
		end

		local stockItem = ix.item.list[uniqueID]

		if (stockItem) then
			local item = setmetatable({id = id, data = {}}, {
				__index = stockItem,
				__eq = stockItem.__eq,
				__tostring = stockItem.__tostring
			})

			self.virtual_items[id] = item

			return item
		end
	end

	function PLUGIN:LoadFonts(font, genericFont)
		surface.CreateFont("ixMerchant.Num", {
			font = font,
			size = math.max(ScreenScale(8), 20),
			weight = 500,
			extended = true
		})

		surface.CreateFont("ixMerchant.NumLarge", {
			font = font,
			size = math.max(ScreenScale(12), 46),
			weight = 500,
			extended = true
		})
	end

	function PLUGIN:Think()
		if (IsValid(ix.gui.merchant)) then
			if (IsValid(ix.gui.menu) or !LocalPlayer():Alive() or !LocalPlayer():GetCharacter()) then
				ix.gui.merchant:Remove()
			end
		end
	end

	function PLUGIN:CreateItemInteractionMenu(itemPanel, menu, item)
		if (IsValid(ix.gui.merchant) and item) then
			if (item.CanSell and item:CanSell() == false) then
				return
			end

			local price = PLUGIN:CalculatePrice(item, true, LocalPlayer())

			if (!price or price < 1) then
				price = ""
			else
				price = ix.currency.Get(price)
			end

			menu:AddOption(Format("%s %s", L"sell", price), function()
				net.Start("ixMerchantTrade")
					net.WriteUInt(item:GetID(), 32)
					net.WriteBool(true)
				net.SendToServer()
			end):SetImage("icon16/basket_put.png")
		end
	end

	function PLUGIN:PopulateItemTooltip(tooltip, item)
		if (IsValid(ix.gui.merchant) and !IsValid(item.entity)) then
			if (item.invID and item.CanSell and item:CanSell() == false) then
				return
			end

			local price = PLUGIN:CalculatePrice(item, item.invID and true or false, LocalPlayer())

			if (!price or price < 1) then
				price = L"free":utf8upper()
			else
				price = ix.currency.Get(price)
			end

			local panel = tooltip:AddRowAfter("name", "merchant_price")
			panel:SetImportant()
			panel:SetText(Format("%s: %s", L"price", price))
			panel:SetBackgroundColor(color_white)
			panel:SizeToContents()
		end
	end

	net.Receive("ixMerchantSync", function()
		local id = net.ReadUInt(32)
		local isSelling = net.ReadBool()
		local data = net.ReadTable()

		if (!IsValid(ix.gui.merchant)) then return end

		if (!isSelling) then
			local item = PLUGIN.virtual_items[id]

			if (item) then
				ix.gui.merchant:TakeItem(id, item)
			end
		else
			ix.gui.merchant:AddItem(id, data)
			ix.gui.merchant.entityItems[id] = data
		end
	end)

	net.Receive("ixMerchantOpen", function()
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then
			return
		end

		local items = net.ReadTable()
		local panel = vgui.Create("ixMerchant")
		local character = LocalPlayer():GetCharacter()

		-- Local Player --
		panel:SetLocalInventory(character:GetInventory(), character:GetMoney())

		-- Merchant
		panel:SetupMerchant(items, entity)
	end)
end