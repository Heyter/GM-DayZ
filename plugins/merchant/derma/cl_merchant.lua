local PLUGIN = PLUGIN

local PANEL = {}
PANEL.itemSize = 92

function PANEL:Init()
	self:SetSize(self.itemSize, self.itemSize * 1.4)

	self.stack = 1
	self.stack_keys = {}
end

function PANEL:IncStack(key)
	self.stack = self.stack + 1
	self.stack_keys[key] = true
end

function PANEL:DecStack(key)
	self.stack = math.max(0, self.stack - 1)
	self.stack_keys[key] = nil

	if (IsValid(ix.gui.merchant)) then
		if (self.stack <= 0) then
			self:Remove()
			return true
		else
			ix.gui.merchant:GetStackKey(self.idxPanel, self.stack_keys)
		end
	end

	return false
end

function PANEL:SetItem(itemTable)
	self.calc_price = PLUGIN:CalculatePrice(itemTable, false, LocalPlayer())
	self.itemTable = itemTable
	self.key = 0

	self.price = self:Add("DLabel")
	self.price:Dock(BOTTOM)

	if (!self.calc_price or self.calc_price <= 0) then
		self.price:SetText(L"free":utf8upper())
	else
		self.price:SetText(ix.currency.Get(self.calc_price))
	end

	self.price:SetContentAlignment(5)
	self.price:SetTextColor(color_white)
	self.price:SetFont("ixSmallFont")
	self.price:SetExpensiveShadow(1, ColorAlpha(color_black, 200))

	self.name = self:Add("DLabel")
	self.name:Dock(TOP)
	self.name:SetText(itemTable.GetName and itemTable:GetName() or L(itemTable.name))
	self.name:SetContentAlignment(5)
	self.name:SetTextColor(color_white)
	self.name:SetFont("ixSmallFont")
	self.name:SetExpensiveShadow(1, ColorAlpha(color_black, 200))
	self.name.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 75)
		surface.DrawRect(0, 0, w, h)
	end

	self.icon = self:Add("SpawnIcon")
	self.icon:SetZPos(1)
	self.icon:SetSize(self:GetWide(), self:GetWide())
	self.icon:Dock(FILL)
	self.icon:DockMargin(5, 5, 5, 10)
	self.icon:InvalidateLayout(true)
	self.icon:SetModel(itemTable:GetModel(), itemTable:GetSkin())
	self.icon:SetHelixTooltip(function(tooltip)
		ix.hud.PopulateItemTooltip(tooltip, self.itemTable)
	end)
	self.icon.DoClick = function(this)
		if ((LocalPlayer().next_merchant_click or 0) < CurTime()) then
			LocalPlayer().next_merchant_click = CurTime() + 0.5
		else
			return
		end

		if (isnumber(self.calc_price) and !LocalPlayer():GetCharacter():HasMoney(self.calc_price)) then
			return LocalPlayer():NotifyLocalized("canNotAfford")
		end

		if (!IsValid(ix.gui.inv1)) then return end

		local inventory = LocalPlayer():GetCharacter():GetInventory()

		if (!inventory:CanItemFitStack(self.itemTable, true)) then
			local w, h = self.itemTable.width, self.itemTable.height
			local invW, invH = ix.gui.inv1.gridW, ix.gui.inv1.gridH
			local x2, y2

			for x = 1, invW do
				for y = 1, invH do
					if (ix.gui.inv1:IsAllEmpty(x, y, w, h)) then
						x2 = x
						y2 = y
					end
				end
			end

			if !(x2 and y2) then
				LocalPlayer():NotifyLocalized("noFit")
				return
			end
		end

		net.Start("ixMerchantTrade")
			net.WriteUInt(self.key, 32)
			net.WriteBool(false)
		net.SendToServer()
	end

	self.icon.Paint = function(t, w, h)

	end

	self.icon.PaintOver = function(t, w, h)
		if (self.stack > 1) then
			draw.SimpleTextOutlined("x" .. self.stack, "DermaDefault", w, h - 10, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black)
		end

		if (itemTable and itemTable.PaintOver) then
			w, h = t:GetSize()

			itemTable.PaintOver(t, itemTable, w, h)
		end
	end

	if ((itemTable.iconCam and !ICON_RENDER_QUEUE[itemTable.uniqueID]) or itemTable.forceRender) then
		local iconCam = itemTable.iconCam
		iconCam = {
			cam_pos = iconCam.pos,
			cam_fov = iconCam.fov,
			cam_ang = iconCam.ang,
		}
		ICON_RENDER_QUEUE[itemTable.uniqueID] = true

		self.icon:RebuildSpawnIconEx(
			iconCam
		)
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(40, 40, 40, 255)
	surface.DrawRect(0, 0, w, h)

	local hovered = Color(60, 60, 60, 255) // todo: вынести в SKIN

	if (self:IsHovered() or self.icon:IsHovered()) then
		hovered = ix.config.Get("color")
	end

	if (GLOBAL_TOOLTIP and IsValid(GLOBAL_TOOLTIP[1]) 
		and self.itemTable and GLOBAL_TOOLTIP[2].uniqueID != self.itemTable.uniqueID 
		and GLOBAL_TOOLTIP[2].CanTooltip 
		and GLOBAL_TOOLTIP[2]:CanTooltip(self.itemTable)) then

		surface.SetDrawColor(Color(125, 125, 125, 30))
		surface.DrawRect(2, 2, w - 4, h - 4)

		hovered = ix.config.Get("color")
	end

	surface.SetDrawColor(hovered)
	surface.DrawOutlinedRect(0, 0, w, h, 1)
end

vgui.Register("ixMerchantItem", PANEL, "DPanel")

DEFINE_BASECLASS("Panel")
PANEL = {}

AccessorFunc(PANEL, "fadeTime", "FadeTime", FORCE_NUMBER)
AccessorFunc(PANEL, "frameMargin", "FrameMargin", FORCE_NUMBER)

function PANEL:Init()
	if (IsValid(ix.gui.merchant)) then
		ix.gui.merchant:Remove()
	end

	ix.gui.merchant = self

	self.character = LocalPlayer():GetCharacter()

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:SetFadeTime(0.25)
	self:SetFrameMargin(4)

	-- Player inventory
	ix.gui.inv1 = self:Add("ixInventory")
	ix.gui.inv1.bNoBackgroundBlur = true
	ix.gui.inv1:ShowCloseButton(true)
	ix.gui.inv1.Close = function(t)
		self:Remove()
	end

	-- Inventory label -> money
	self.invMoney = ix.gui.inv1:Add("ixStashMoney")
	self.invMoney.moneyBtn.OnMousePressed = nil
	self.invMoney:SetVisible(false)

	-- Merchant
	self.invMerchant = self:Add("DFrame")
	self.invMerchant:SetTitle(L'merchant_title')
	self.invMerchant:SetSize(ScrW() / 3, ScrH() / 1.25)
	self.invMerchant:ShowCloseButton(true)
	self.invMerchant:SetDraggable(true)
	self.invMerchant:SetSizable(false)
	self.invMerchant.bNoBackgroundBlur = true
	self.invMerchant.Paint = function(_, w, h)
		surface.SetDrawColor(24, 24, 24, 255)
		surface.DrawRect(0, 0, w, h)

		-- Title
		surface.SetDrawColor(60, 60, 60, 255)
		surface.DrawRect(0, 0, w, 24)
	end
	self.invMerchant.Close = function(t)
		self:Remove()
	end

	self.categories = self.invMerchant:Add("DScrollPanel")
	self.categories:Dock(FILL)
	self.categories:DockMargin(0, 2, 4, 0)
	self.categories:SetPaintBackground(true)
	self.categories:Receiver("ixInventoryItem", function(this, panels, dropped)
		if (dropped and panels[1]) then
			local item = panels[1].itemTable

			if (item) then
				if (item.CanSell and item:CanSell() == false) then
					return
				end

				net.Start("ixMerchantTrade")
					net.WriteUInt(item:GetID(), 32)
					net.WriteBool(true)
				net.SendToServer()
			end
		end
	end)

	self.categoryPanels = {}
	self.items = {}

	self:SetAlpha(0)
	self:AlphaTo(255, self:GetFadeTime())

	self.invMerchant:MakePopup()
	ix.gui.inv1:MakePopup()
end

function PANEL:SetLocalInventory(inventory, money)
	if (IsValid(ix.gui.inv1) and !IsValid(ix.gui.menu)) then
		ix.gui.inv1:SetInventory(inventory)
		ix.gui.inv1:SetPos(self:GetWide() / 2 - ix.gui.inv1:GetWide() - 2, self:GetTall() / 2 - ix.gui.inv1:GetTall() / 2)
	end

	if (!self.invMoney:IsVisible()) then
		self.invMoney:SetVisible(true)
		ix.gui.inv1:SetTall(ix.gui.inv1:GetTall() + self.invMoney:GetTall() + 2)
	end

	self.invMoney:SetMoney(money)
end

function PANEL:TakeItem(key, item)
	local idxPanel = self:CanStackItem(item, key)
	local panel = self.items[idxPanel]

	self.entityItems[key] = nil
	PLUGIN.virtual_items[key] = nil

	if (IsValid(panel) and panel:DecStack(key)) then
		self.items[idxPanel] = nil
		panel = nil
	end
end

function PANEL:GetStackKey(idxPanel, stack_keys)
	if (idxPanel and IsValid(self.items[idxPanel])) then
		self.items[idxPanel].key = select(2, table.Random(stack_keys))
	end
end

function PANEL:CanStackItem(item, default)
	local index = default or item.id

	for idx, panel in pairs(self.items) do
		if (!IsValid(panel) or panel.itemTable.uniqueID != item.uniqueID) then continue end

		if (item.CanStack and item:CanStack(panel.itemTable, true) and (item.price or 0) == (panel.itemTable.price or 0)
			or table.IsEmpty(item.data) and table.IsEmpty(panel.itemTable.data)) then
			index = idx
			break
		end
	end

	return index
end

function PANEL:AddItem(key, itemTable)
	local item = PLUGIN:MakeVirtualItem(itemTable.uniqueID, key)
	if (!item) then return end

	item.data = itemTable.data or {}
	item.price = itemTable.price or nil

	self:AddCategory(item)

	local index = self:CanStackItem(item)

	if (!IsValid(self.items[index])) then
		local itemSlot = self.categoryPanels[item.category][1]:Add("ixMerchantItem")
		itemSlot:SetItem(item)
		itemSlot.key = key
		itemSlot.idxPanel = index

		self.items[index] = itemSlot
	else
		self.items[index]:IncStack(key)
	end
end

function PANEL:AddCategory(item)
	if (item and !self.categoryPanels[item.category]) then
		local cat = vgui.Create('DCollapsibleCategory', self.categories)
		cat.Paint = function() end
		cat.Header:SetFont("ixSmallFont")
		cat.Header:SetContentAlignment(5)
		cat.Header.Paint = function(t, w, h)
			surface.SetDrawColor(40, 40, 40, 255)
			surface.DrawRect(0, 0, w, h)

			local hovered = Color(60, 60, 60, 255)

			if (t:IsHovered()) then
				hovered = ix.config.Get("color")
			end

			surface.SetDrawColor(hovered)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		cat:SetLabel(L(item.category))
		cat:Dock(TOP)
		cat.Think = function(t)
			if (#t.Contents:GetChildren() < 1) then
				t:Remove()
				self.categoryPanels[item.category] = nil
			end
		end

		local slot = vgui.Create('DIconLayout', cat)
		slot:SetSpaceX(5)
		slot:SetSpaceY(5)
		slot:SetBorder(5)
		slot:Dock(TOP)
		slot:InvalidateLayout(true)

		cat:SetContents(slot)

		self.categoryPanels[item.category] = {slot, cat}
	end
end

function PANEL:SetupMerchant(items, entity)
	self.invMerchant:SetPos(self:GetWide() / 2 + self:GetFrameMargin() / 2, self:GetTall() / 2 - self.invMerchant:GetTall() / 2)
	self.ixMerchant = entity

	if (!table.IsEmpty(self.categoryPanels)) then
		for _, panels in pairs(self.categoryPanels) do
			panels[2]:Clear()
			panels[2]:InvalidateLayout(true)
		end
	end

	for k in pairs(items) do
		items[k].id = k
	end

	self.entityItems = items

	-- init items
	for k, data in SortedPairs(items) do
		self:AddItem(k, data)
	end

	self.loaded = true
end

function PANEL:Paint(width, height)
	ix.util.DrawBlurAt(0, 0, width, height)

	for _, v in ipairs(self:GetChildren()) do
		v:PaintManual()
	end
end

function PANEL:Remove()
	self:SetAlpha(255)
	self:AlphaTo(0, self:GetFadeTime(), 0, function()
		table.Empty(PLUGIN.virtual_items)
		BaseClass.Remove(self)
	end)
end

function PANEL:OnRemove()
	net.Start("ixMerchantClose")
	net.SendToServer()
end

function PANEL:Think()
	if (self.loaded) then
		if (!IsValid(self.ixMerchant)) then
			self:Remove()
			return
		end

		if ((self.nextThink or 0) < CurTime()) then
			if (IsValid(LocalPlayer()) and self.character and self.invMoney.money != self.character:GetMoney()) then
				self.invMoney:SetMoney(self.character:GetMoney())
			end

			self.nextThink = CurTime() + 0.25
		end
	end
end

vgui.Register("ixMerchant", PANEL, "Panel")