local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "money", "Money", FORCE_NUMBER)

function PANEL:Init()
	self:DockPadding(1, 1, 1, 1)
	self:SetTall(24)
	self:Dock(BOTTOM)

	self.moneyBtn = self:Add("DButton")
	self.moneyBtn:Dock(FILL)
	self.moneyBtn:SetFont("ixGenericFont")
	self.moneyBtn:SetText("")
	self.moneyBtn:SetIcon("icon16/money_dollar.png")
	self.moneyBtn:SetTextInset(2, 0)
	self.moneyBtn:SizeToContents()
	self.moneyBtn.Paint = function(panel, width, height)
		panel.set_color = ix.config.Get("color")

		if (panel:GetDisabled()) then
			panel.set_color = ix.config.Get("color")
		elseif (panel.Depressed) then
			panel.set_color = ix.color.Darken(panel.set_color, 35)
		elseif (panel.Hovered) then
			panel.set_color = ix.color.Darken(panel.set_color, 25)
		end

		surface.SetDrawColor(panel.set_color)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, width, height)

		surface.SetDrawColor(180, 180, 180, 2)
		surface.DrawOutlinedRect(1, 1, width - 2, height - 2)
	end

	self.moneyBtn.OnMousePressed = function(t, code)
		if (code == MOUSE_LEFT) then
			surface.PlaySound("ui/buttonclick.wav")

			Derma_NumericRequest("", L"stash_enter_money", self.money, function(text)
				local amount = math.max(0, math.Round(tonumber(text) or 0))

				if (amount != 0) then
					self:OnTransfer(amount)
				end
			end)
		elseif (code == MOUSE_RIGHT) then
			surface.PlaySound("ui/buttonclick.wav")

			self:OnTransfer(0, MOUSE_RIGHT)
		end
	end

	self.bNoBackgroundBlur = true
end

function PANEL:SetMoney(money)
	self.money = math.max(math.Round(tonumber(money) or 0), 0)
	self.moneyBtn:SetText(ix.currency.Get(money))
end

function PANEL:OnTransfer(amount, code)
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintBaseFrame", self, width, height)
end

vgui.Register("ixStashMoney", PANEL, "EditablePanel")

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

	if (IsValid(ix.gui.stash)) then
		if (self.stack <= 0) then
			self:Remove()
			return true
		else
			ix.gui.stash:GetStackKey(self.idxPanel, self.stack_keys)
		end
	end

	return false
end

function PANEL:SetItem(itemTable)
	self.itemTable = itemTable
	self.key = 0
	self.isStackable = itemTable.isStackable

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
	--self.icon:Droppable("ixStashItem")
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
		if ((LocalPlayer().next_stash_click or 0) < CurTime()) then
			LocalPlayer().next_stash_click = CurTime() + 1.25
		else
			return
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

		local allStack = input.IsShiftDown()
		net.Start("ixStashWithdrawItem")
			net.WriteUInt(self.key, 32)
			net.WriteBool(allStack)
		net.SendToServer()

		if (IsValid(ix.gui.stash)) then
			local quantity = 1

			if (allStack and self.isStackable) then
				quantity = self.itemTable:GetData("quantity", 1)
				local diff = quantity - (self.itemTable.maxQuantity or 16)

				if (diff > 0) then
					quantity = quantity - diff
				end
			end

			ix.gui.stash:TakeItem(self.key, self.itemTable, quantity)
		end
	end
	self.icon.PaintOver = function(t, w, h)
		if (self.stack > 1 and !self.isStackable) then
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

vgui.Register("ixStashItem", PANEL, "DPanel")

DEFINE_BASECLASS("Panel")
PANEL = {}

PANEL.cCategoryRect = Color(38, 38, 38, 255)
PANEL.cCategoryBorder = Color(204, 204, 204, 100)

AccessorFunc(PANEL, "fadeTime", "FadeTime", FORCE_NUMBER)
AccessorFunc(PANEL, "frameMargin", "FrameMargin", FORCE_NUMBER)

function PANEL:Init()
	if (IsValid(ix.gui.stash)) then
		ix.gui.stash:Remove()
	end

	ix.gui.stash = self

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

	-- TODO: Позже прикрутить и PaintDragPreview
--[[ 	ix.gui.inv1:Receiver("ixStashItem", function(this, panels, dropped)
		if (dropped and panels[1]) then
			local hoveredPanel = vgui.GetHoveredPanel()
			local itemPanel = panels[1]:GetParent()

			if (IsValid(hoveredPanel) and hoveredPanel != itemPanel) then
				net.Start("ixStashWithdrawItem")
					net.WriteUInt(itemPanel.key, 32)
				net.SendToServer()

				ix.gui.stash:TakeItem(itemPanel.key, itemPanel.itemTable)
			end
		end
	end) ]]

	-- Inventory label -> money
	self.invMoney = ix.gui.inv1:Add("ixStashMoney")
	self.invMoney.OnTransfer = function(_, amount, keyCode)
		if (self.character:GetMoney() <= 0) then
			return
		end

		if (keyCode == MOUSE_RIGHT) then
			amount = self.character:GetMoney()
		end

		net.Start("ixStashDepositMoney")
			net.WriteUInt(amount, 32)
		net.SendToServer()
	end
	self.invMoney:SetVisible(false)

	-- Stash
	self.invStash = self:Add("DFrame")
	self.invStash:SetTitle(L'stash_title')
	self.invStash:SetSize(ScrW() / 3, ScrH() / 1.25)
	self.invStash:ShowCloseButton(true)
	self.invStash:SetDraggable(true)
	self.invStash:SetSizable(false)
	self.invStash.bNoBackgroundBlur = true
	self.invStash.Paint = function(_, w, h)
		surface.SetDrawColor(24, 24, 24, 255)
		surface.DrawRect(0, 0, w, h)

		-- Title
		surface.SetDrawColor(60, 60, 60, 255)
		surface.DrawRect(0, 0, w, 24)
	end
	self.invStash.Close = function(t)
		self:Remove()
	end

	self.invStash.lblTitle.UpdateColours = function(label)
		return label:SetTextStyleColor(color_white)
	end

	self.invStashMoney = self.invStash:Add("ixStashMoney")
	self.invStashMoney.OnTransfer = function(_, amount, keyCode)
		if (self.character:GetStashMoney() <= 0) then
			return
		end

		if (keyCode == MOUSE_RIGHT) then
			amount = self.character:GetStashMoney()
		end

		net.Start("ixStashWithdrawMoney")
			net.WriteUInt(amount, 32)
		net.SendToServer()
	end
	self.invStashMoney:SetVisible(false)

	self.categories = self.invStash:Add("DScrollPanel")
	self.categories:Dock(FILL)
	self.categories:DockMargin(0, 2, 4, 0)
	self.categories:SetPaintBackground(true)

	self.categories:Receiver("ixInventoryItem", function(this, panels, dropped)
		if (dropped and panels[1]) then
			PLUGIN:DepositItem(self.character, panels[1], panels[1].itemTable)
		end
	end)

	self.categoryPanels = {}
	self.items = {}

	self:SetAlpha(0)
	self:AlphaTo(255, self:GetFadeTime())

	self.invStash:MakePopup()
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

function PANEL:TakeItem(key, item, amt)
	local panel

	if (!item.isStackable) then
		local idxPanel = self:CanStackItem(item, key)
		panel = self.items[idxPanel]

		self.entityItems[key] = nil
		PLUGIN.virtual_items[key] = nil

		if (IsValid(panel) and panel:DecStack(key)) then
			self.items[idxPanel] = nil
			panel = nil
		end
	else
		panel = self.items[key]

		if (IsValid(panel)) then
			panel.stack = math.max(0, panel.stack - (amt or 1))
			PLUGIN.virtual_items[key]:SetData("quantity", panel.stack)

			if (panel.stack <= 0) then
				self.entityItems[key] = nil
				PLUGIN.virtual_items[key] = nil
				self.items[key] = nil

				panel:Remove()
				panel = nil
			end
		end
	end
end

function PANEL:GetStackKey(idxPanel, stack_keys)
	if (idxPanel and IsValid(self.items[idxPanel])) then
		self.items[idxPanel].key = select(2, table.Random(stack_keys))
	end
end

function PANEL:CanStackItem(item, default)
	local index = default or item.id

	if (!item.isStackable) then
		for idx, panel in pairs(self.items) do
			if (!IsValid(panel) or panel.itemTable.uniqueID != item.uniqueID) then continue end

			if (item.CanStack and item:CanStack(panel.itemTable, true) and (item.price or 0) == (panel.itemTable.price or 0)
				or table.IsEmpty(item.data) and table.IsEmpty(panel.itemTable.data)) then
				index = idx
				break
			end
		end
	end

	return index
end

function PANEL:AddItem(key, itemTable)
	local item = PLUGIN:MakeVirtualItem(itemTable.uniqueID, key)
	item.data = itemTable.data or {}

	self:AddCategory(item)

	local index = self:CanStackItem(item)

	if (!IsValid(self.items[index])) then
		local itemSlot = self.categoryPanels[item.category][1]:Add("ixStashItem")
		itemSlot:SetItem(item)
		itemSlot.key = key
		itemSlot.idxPanel = index

		if (item.isStackable) then
			itemSlot.stack = item.data.quantity
			PLUGIN.virtual_items[key]:SetData("quantity", item.data.quantity)
		end

		self.items[index] = itemSlot
	else
		if (item.isStackable) then
			self.items[index].stack = item.data.quantity
			PLUGIN.virtual_items[key]:SetData("quantity", item.data.quantity)
		else
			self.items[index]:IncStack(key)
		end
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

function PANEL:SetStash(items)
	self.invStash:SetPos(self:GetWide() / 2 + self:GetFrameMargin() / 2, self:GetTall() / 2 - self.invStash:GetTall() / 2)

	if (!table.IsEmpty(self.categoryPanels)) then
		for _, panels in pairs(self.categoryPanels) do
			panels[2]:Clear()
			panels[2]:InvalidateLayout(true)
		end
	end

	self.entityItems = items

	-- init items
	for k, data in SortedPairs(items) do
		if (k == 0) then continue end

		self:AddItem(k, data)
	end

	if (!self.invStashMoney:IsVisible()) then
		self.invStashMoney:SetVisible(true)
		self.invStash:SetTall(self.invStash:GetTall() + self.invStashMoney:GetTall() + 2)
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

		for _, v in ipairs(ents.FindInSphere(EyePos(), 256)) do
			if (v and v:GetClass() == "gmodz_stash") then
				v:EmitSound("items/ammocrate_close.wav")
				break
			end
		end

		BaseClass.Remove(self)
	end)
end

function PANEL:Think()
	if (self.loaded) then
		if ((self.nextThink or 0) < CurTime()) then
			if (self.character) then
				if (self.invMoney.money != self.character:GetMoney()) then
					self.invMoney:SetMoney(self.character:GetMoney())
				end

				if (self.invStashMoney.money != self.character:GetStashMoney()) then
					self.invStashMoney:SetMoney(self.character:GetStashMoney())
				end

				-- Resync
				local weight = self.character:GetStashWeight()
				if (table.IsEmpty(self.categoryPanels) and weight > 0) then
					self:SetStash(self.character:GetStash())
				end

				self.invStash:SetTitle(L("stash_title_count", weight, self.character:GetStashWeightMax()))
			end

			self.nextThink = CurTime() + 0.25
		end
	end
end

vgui.Register("ixStashView", PANEL, "Panel")