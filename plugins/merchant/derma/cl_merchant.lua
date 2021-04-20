local PLUGIN = PLUGIN

local PANEL = {}
PANEL.itemSize = 92

function PANEL:Init()
	self:SetSize(self.itemSize, self.itemSize * 1.4)

	self.stack = 1
end

function PANEL:IncStack(key)
	self.stack = self.stack + 1
end

function PANEL:DecStack()
	self.stack = math.max(0, self.stack - 1)

	if (IsValid(ix.gui.merchant)) then
		if (self.stack <= 0) then
			self:Remove()
			return true
		else
			ix.gui.merchant:GetStackKey(self.itemTable.uniqueID)
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
	self.price:SetExpensiveShadow(1, Color(0, 0, 0, 200))

	self.name = self:Add("DLabel")
	self.name:Dock(TOP)
	self.name:SetText(itemTable.GetName and itemTable:GetName() or L(itemTable.name))
	self.name:SetContentAlignment(5)
	self.name:SetTextColor(color_white)
	self.name:SetFont("ixSmallFont")
	self.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))
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
		if (PLUGIN.virtual_items[self.key]) then
			ix.hud.PopulateItemTooltip(tooltip, PLUGIN.virtual_items[self.key])
		end
	end)
	self.icon.DoClick = function(this)
		if (isnumber(self.calc_price) and !LocalPlayer():GetCharacter():HasMoney(self.calc_price)) then
			return LocalPlayer():NotifyLocalized("canNotAfford")
		end

		if ((this.nextClick or 0) < CurTime()) then
			this.nextClick = CurTime() + 0.5
		else
			return
		end

		net.Start("ixMerchantTrade")
			net.WriteUInt(self.key, 32)
			net.WriteBool(false)
		net.SendToServer()
	end
	self.icon.PaintOver = function(t, w, h)
		if (self.stack > 1 and table.IsEmpty(itemTable.data)) then
			draw.SimpleText("x" .. self.stack, "ixMerchant.Num", w, h - 10, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black)
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

vgui.Register("ixMerchantItem", PANEL, "DPanel")

DEFINE_BASECLASS("Panel")
PANEL = {}

PANEL.cCategoryRect = Color(38, 38, 38, 255)
PANEL.cCategoryBorder = Color(204, 204, 204, 100)

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
	self.invMoney = ix.gui.inv1:Add("ixTradeMoney")
	self.invMoney.giveButton:Remove()
	self.invMoney.takeButton:Remove()
	self.invMoney.amountEntry:Remove()
	self.invMoney:SetTall(24)
	self.invMoney.moneyLabel:Dock(FILL)
	self.invMoney:SetVisible(false)

	-- Merchant
	self.invMerchant = self:Add("DFrame")
	self.invMerchant:SetTitle(L'merchant_title')
	self.invMerchant:SetSize(ScrW() / 3, ScrH() / 1.25)
	self.invMerchant:ShowCloseButton(true)
	self.invMerchant:SetDraggable(true)
	self.invMerchant:SetSizable(false)
	self.invMerchant.bNoBackgroundBlur = true
	self.invMerchant.Close = function(t)
		self:Remove()
	end

	self.categories = self.invMerchant:Add("DScrollPanel")
	self.categories:Dock(FILL)
	self.categories:DockMargin(0, 2, 4, 0)
	self.categories:SetPaintBackground(true)

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
	self.entityItems[key] = nil
	PLUGIN.virtual_items[key] = nil

	local text = key

	if (table.IsEmpty(item.data)) then
		text = item.uniqueID
	end

	if (IsValid(self.items[text]) and self.items[text]:DecStack()) then
		self.items[text] = nil
	end
end

function PANEL:GetStackKey(uniqueID)
	if (uniqueID and IsValid(self.items[uniqueID])) then
		for k, v in pairs(self.entityItems) do
			if (v.uniqueID == uniqueID and table.IsEmpty(v.data)) then
				self.items[uniqueID].key = k
				break
			end
		end
	end
end

function PANEL:AddItem(key, itemTable)
	local item = PLUGIN:MakeVirtualItem(itemTable.uniqueID, key)
	item.data = itemTable.data or {}
	item.price = itemTable.price or nil

	self:AddCategory(item)

	local text = key

	if (table.IsEmpty(item.data)) then
		text = item.uniqueID
	end

	if (!IsValid(self.items[text])) then
		local itemSlot = self.categoryPanels[item.category][1]:Add("ixMerchantItem")
		itemSlot:SetItem(item)
		itemSlot.key = key

		self.items[text] = itemSlot
	else
		self.items[text]:IncStack()
	end
end

function PANEL:AddCategory(item)
	if (item and !self.categoryPanels[item.category]) then
		local cat = vgui.Create('DCollapsibleCategory', self.categories)
		cat.Paint = function() end
		cat.Header:SetFont("ixToolTipText")
		cat.Header.Paint = function(t, w, h)
			surface.SetDrawColor(self.cCategoryRect)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(self.cCategoryBorder)
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