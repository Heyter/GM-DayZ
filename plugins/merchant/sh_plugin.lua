local PLUGIN = PLUGIN

PLUGIN.name = "Merchant"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Adds a merchant of things."

-- Go away, asshole.

ix.config.Add("merchantSellPerc", 0.7, "Множитель процента продажи/покупки предмета", nil, {
	data = {min = 0, max = 1, decimals = 1},
	category = PLUGIN.name
})

ix.config.Add("merchantInterval", 120, "Интервал обновлений ассортимента торговца (в минутах)", 
	function(_, newValue)
		if (SERVER) then
			if (timer.Exists("ixMerchantInterval")) then
				timer.Adjust("ixMerchantInterval", newValue * 60, 0, PLUGIN.MerchantInterval)
			else
				timer.Create("ixMerchantInterval", newValue * 60, 0, PLUGIN.MerchantInterval)
			end
		end
	end, {
	data = {min = 1, max = 1440},
	category = PLUGIN.name
})

function PLUGIN:CalculatePrice(item, isSellingToVendor, client)
	local stockItem = ix.item.list[item.uniqueID]
	if (!stockItem) then return 999999 end

	local price = stockItem.price or 0
	if (price > 0) then -- пропустить бесплатные предметы
		local scale = ix.config.Get("merchantSellPerc", 0.7)

		if (isSellingToVendor) then
			if (item.GetSellPrice) then
				price = item:GetSellPrice(price, scale)
			else
				price = price * scale
			end
		else
			local newPrice = hook.Run("MerchantItemBuyPrice", item, stockItem, price)
			local durability = (item.data or {}).durability

			if (newPrice) then
				price = price + (newPrice * scale)
			else
				price = price + (price / scale)
			end
		end

		if (client) then
			price = hook.Run("PlayerMerchantCalcPrice", client, price, scale, isSellingToVendor) or price
		end

		if (CLIENT) then
			if (input.IsShiftDown()) then
				if (!self.nextRecalcPrice) then
					local quantity = item.data.quantity or 1

					if (quantity > 1) then
						local diff = quantity - (stockItem.maxQuantity or 16)

						if (diff > 0) then
							quantity = quantity - diff
						end
					end

					price = price * quantity
				end
			elseif (self.nextRecalcPrice) then
				self.nextRecalcPrice = nil
			end
		end
	end

	return math.max(0, math.Round(price))
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

	function PLUGIN:Think()
		if (IsValid(ix.gui.merchant)) then
			if (IsValid(ix.gui.menu) or !LocalPlayer():Alive() or !LocalPlayer():GetCharacter()) then
				ix.gui.merchant:Remove()
			end
		end
	end

	-- Left mouse button + SHIFT
	function PLUGIN:ItemPressedLeftShift(icon, item)
		if (IsValid(ix.gui.merchant) and item) then
			if (item.CanSell and item:CanSell() == false) then
				return
			end

			net.Start("ixMerchantTrade")
				net.WriteUInt(item:GetID(), 32)
				net.WriteBool(true)
				net.WriteBool(true)
			net.SendToServer()
		end
	end

	function PLUGIN:CreateItemInteractionMenu(_, menu, item)
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
					net.WriteBool(false)
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
			local text

			if (!price or price < 1) then
				text = L"free":utf8upper()
			else
				text = ix.currency.Get(price)
			end
			if (!text) then return end

			local panel = tooltip:AddRowAfter("name", "merchant_price")
			panel:SetImportant()
			panel:SetText(Format("%s: %s", L"price", text))
			panel.lastText = panel:GetText()
			panel.lastPrice = price or 0
			panel:SetBackgroundColor(color_white)
			panel:SizeToContents()

			if (panel.lastPrice > 0) then
				panel.Think = function(t)
					if (input.IsShiftDown()) then
						if (!t.nextRecalcPrice) then
							t.nextRecalcPrice = true

							local price = PLUGIN:CalculatePrice(item, item.invID and true or false, LocalPlayer())
							local text

							if (!price or price < 1) then
								text = L"free":utf8upper()
							else
								text = ix.currency.Get(price)
							end

							if (text and t.lastPrice != price) then
								t:SetText(Format("%s: %s", L"price", text))
								t:SizeToContents()
								tooltip:SizeToContents()
							end
						end
					elseif (t.nextRecalcPrice) then
						t.nextRecalcPrice = nil
						t:SetText(t.lastText)
						t:SizeToContents()
						tooltip:SizeToContents()
					end
				end
			end
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
				ix.gui.merchant:TakeItem(id, item, data.data and data.data.quantity or 0)
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

-- Предметы без мета-таблицы расчет цены по data.
function PLUGIN:MerchantItemBuyPrice(item, stockItem, price)
	if (item.data and item.data.durability) then
		return (price + price) * (item.data.durability / (stockItem.defDurability or 100))
	end
end