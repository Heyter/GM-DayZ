local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() * 0.6, ScrH())
	self:Center()
	self:SetBackgroundBlur(false)
	self:SetDeleteOnClose(true)
	self:MakePopup()

	self.categoryPanels = {}
	self.itemList = {}
end

function PANEL:Setup(item, index)
	self:SetTitle("Редактирование: "..item.title)

	self.title = self:Add("DPanel")
	self.title:Dock(TOP)
	self.title:SetHeight(30)
	self.title:DockMargin(10, 10, 10, 10)

	self.delay = self:Add("DPanel")
	self.delay:Dock(TOP)
	self.delay:SetHeight(30)
	self.delay:DockMargin(10, 10, 10, 10)

	self.chance = self:Add("DPanel")
	self.chance:Dock(TOP)
	self.chance:SetHeight(30)
	self.chance:DockMargin(10, 10, 10, 10)

	self.force = self:Add("DPanel")
	self.force:Dock(TOP)
	self.force:SetHeight(30)
	self.force:DockMargin(10, 10, 10, 10)

	self.items = self:Add("DPanel")
	self.items:Dock(FILL)
	self.items:DockMargin(0, 4, 0, 0)

	self.save = self:Add("DPanel")
	self.save:Dock(BOTTOM)

	self.title.label = self.title:Add("DLabel")
	self.title.label:DockMargin(5, 0, 0, 0)
	self.title.label:SetText(L"name")
	self.title.label:Dock(LEFT)
	self.title.label:SetFont("ixSmallFont")
	self.title.label:SetContentAlignment(5)

	self.title.input = self.title:Add("DTextEntry")
	self.title.input:SetCursorColor(color_white)
	self.title.input:SetText(item.title)
	self.title.input:SetFont("ixMediumFont")
	self.title.input:Dock(FILL)

	self.delay.label = self.delay:Add("DLabel")
	self.delay.label:DockMargin(5, 0, 0, 0)
	self.delay.label:SetText("Задержка")
	self.delay.label:Dock(LEFT)
	self.delay.label:SetFont("ixSmallFont")
	self.delay.label:SetContentAlignment(5)

	self.delay.input = self.delay:Add("ixTextEntry")
	self.delay.input:SetNumeric(true)
	self.delay.input:SetAllowNonAsciiCharacters(false)
	self.delay.input:SetFont("ixMenuButtonFont")
	self.delay.input:SetSkin("Default")
	self.delay.input:SetCursorColor(color_white)
	self.delay.input:SetText(item.delay)
	self.delay.input:SetFont("ixMediumFont")
	self.delay.input:Dock(FILL)
	self.delay.input.Paint = function(t, w, h)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, w, h)

		t:DrawTextEntryText(color_black, ix.config.Get("color"), color_black)
	end

	self.force.label = self.force:Add("DLabel")
	self.force.label:DockMargin(5, 0, 0, 0)
	self.force.label:SetText("Сила рандома")
	self.force.label:Dock(LEFT)
	self.force.label:SetFont("ixSmallFont")
	self.force.label:SetContentAlignment(5)

	self.force.input = self.force:Add("ixTextEntry")
	self.force.input:SetNumeric(true)
	self.force.input:SetAllowNonAsciiCharacters(false)
	self.force.input:SetFont("ixMenuButtonFont")
	self.force.input:SetSkin("Default")
	self.force.input:SetCursorColor(color_white)
	self.force.input:SetText(item.scale or 1)
	self.force.input:SetFont("ixMediumFont")
	self.force.input:Dock(FILL)
	self.force.input.Paint = function(t, w, h)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, w, h)

		t:DrawTextEntryText(color_black, ix.config.Get("color"), color_black)
	end

	self.chance.label = self.chance:Add("DLabel")
	self.chance.label:SetWide(80)
	self.chance.label:DockMargin(5, 0, 0, 0)
	self.chance.label:SetText("Рандом")
	self.chance.label:Dock(LEFT)
	self.chance.label:SetFont("ixSmallFont")

	self.chance.box = self.chance:Add("DComboBox")
	self.chance.box:Dock(FILL)
	self.chance.box:SetFont("ixMenuButtonFont")
	self.chance.box:SetTextColor(color_white)
	self.chance.box.OnSelect = function(t, index, _, data)
		t:SizeToContents()
		t:SetWide(t:GetWide() + 12)
	end

	self.chance.box:AddChoice("Вещественный", "weighted")
	self.chance.box:AddChoice("Линейный", "linear")
	self.chance.box:AddChoice("Обычный", "default")

	if (item.chance_type) then
		if (item.chance_type == 1) then
			self.chance.box:ChooseOptionID(1)
		elseif (item.chance_type == 2) then
			self.chance.box:ChooseOptionID(2)
		else
			self.chance.box:ChooseOptionID(3)
		end
	else
		self.chance.box:ChooseOptionID(3)
	end

	self.categories = self.items:Add("DScrollPanel")
	self.categories:Dock(FILL)
	self.categories:DockMargin(0, 2, 4, 0)
	self.categories:SetPaintBackground(true)

	if (!table.IsEmpty(self.categoryPanels)) then
		for _, panels in pairs(self.categoryPanels) do
			panels[2]:Clear()
			panels[2]:InvalidateLayout(true)
		end
	end

	for _, v in pairs(ix.item.list) do
		self:AddCategory(v)

		local itemSlot = self.categoryPanels[v.category][1]:Add("ixItemSpawnerItem")
		itemSlot:SetItem(v, self)

		if (istable(item.items)) then
			for _, v2 in ipairs(item.items) do
				local id = istable(v2) and v2.id or v2

				if (id == v.uniqueID) then
					itemSlot.selected = true

					if (item.chance_type == 1 and istable(v2)) then
						if (v2.real_w) then
							itemSlot.chance = v2.real_w
						else
							itemSlot.chance = math.Round(1 + v2.weight * 100, 0)
						end
					elseif (item.chance_type == 3) then
						itemSlot.chance = v.rarity.weight
					else
						itemSlot.chance = nil
					end

					self.itemList[v.uniqueID] = itemSlot.chance or true
					break
				end
			end
		end
	end

	self.save.button = self.save:Add("DButton")
	self.save.button:SetText("Save Changes")
	self.save.button:Dock(FILL)
	self.save.button.Paint = function(t, w, h)
		derma.SkinFunc("PaintButtonFilled", t, w, h)
	end

	self.save.button.DoClick = function()
		local _, type = self.chance.box:GetSelected()

		if (!type or #type == 0) then
			self.itemList = {}
		else
			if (type == "weighted" or type == "default") then
				local total_weight = 0

				for k, v in pairs(self.itemList) do
					if (isnumber(v) and type == "weighted") then
						total_weight = total_weight + v
					elseif (type == "default") then
						local item = ix.item.list[k]

						if (item and istable(item.rarity) and item.rarity.weight) then
							total_weight = total_weight + ix.item.list[k].rarity.weight
						else
							self.itemList[k] = nil
						end
					end
				end

				local copy_items = table.Copy(self.itemList or {})
				self.itemList = {}

				for k, v in pairs(copy_items) do
					if (isnumber(v)) then
						if (type == "weighted") then
							table.insert(self.itemList, {weight = v / total_weight, id = k, real_w = v})
						else
							table.insert(self.itemList, {weight = v / total_weight, id = k})
						end
					end
				end

				copy_items = nil
			elseif (type == "linear") then
				local copy_items = table.Copy(self.itemList or {})
				self.itemList = {}

				for k, v in pairs(copy_items) do
					table.insert(self.itemList, k)
				end

				copy_items = nil
			else
				self.itemList = {}
			end
		end

		if (!table.IsEmpty(self.itemList)) then
			table.shuffle(self.itemList)
		else
			type = "default"
		end

		net.Start("ixItemSpawnerChanges")
		net.WriteTable({
			index,
			self.title.input:GetValue(),
			self.delay.input:GetValue(),
			type,
			self.itemList,
			self.force.input:GetValue()
		})
		net.SendToServer()

		self:Remove()
	end

	for _, v in ipairs( {self.force.label, self.delay.label, self.title.label} ) do
		surface.SetFont("ixSmallFont")
		local tw = surface.GetTextSize(v:GetText())

		v:SetWide(tw + 8)
	end
end

function PANEL:AddCategory(item)
	if (item and !self.categoryPanels[item.category]) then
		local cat = vgui.Create('DCollapsibleCategory', self.categories)
		cat.Paint = function() end
		cat.Header:SetFont("ixSmallFont")
		cat.Header:SetContentAlignment(5)
		cat.Header.Paint = function(t, w, h)
			derma.SkinFunc("PaintButton2", t, w, h, t:IsHovered() and ix.config.Get("color"))
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

function PANEL:Paint(w, h)
	derma.SkinFunc("PaintFrame2", self, w, h)
end

vgui.Register("ixItemSpawnerEditor", PANEL, "DFrame")

local border = 4
local border_w = 5
local matHover = Material( "gui/sm_hover.png", "nocull" )
local boxHover = GWEN.CreateTextureBorder( border, border, 64 - border * 2, 64 - border * 2, border_w, border_w, border_w, border_w, matHover )

local PANEL = {}
PANEL.itemSize = 92

function PANEL:Init()
	self:SetSize(self.itemSize, self.itemSize * 1.4)
	self.selected = false
end

function PANEL:SetItem(itemTable, panel)
	self.itemID = itemTable.uniqueID

	if (itemTable.rarity and itemTable.rarity.weight) then -- реальный шанс из ix.item.list
		self.weight = itemTable.rarity.weight
	end

	self.name = self:Add("DLabel")
	self.name:Dock(TOP)
	self.name:SetText(itemTable.GetName and itemTable:GetName() or L(itemTable.name))
	self.name:SetContentAlignment(5)
	self.name:SetTextColor(color_white)
	self.name:SetFont("ixSmallFont")
	self.name:SetExpensiveShadow(1, color_black)
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
		ix.hud.PopulateItemTooltip(tooltip, itemTable)
	end)
	self.icon.OnMousePressed = function(this, code)
		if (!IsValid(panel)) then return end

		local type = select(2, panel.chance.box:GetSelected())

		if (code == MOUSE_LEFT) then
			self.selected = !self.selected

			if (self.selected == true) then
				if (!panel.itemList[self.itemID]) then
					if ((type == "weighted" or type == "default") and self.weight) then
						panel.itemList[self.itemID] = self.weight
						self.chance = self.weight
					else
						panel.itemList[self.itemID] = true
					end
				end
			else
				panel.itemList[self.itemID] = nil
				self.chance = nil
			end
		elseif (code == MOUSE_RIGHT) then
			if (type == "weighted") then
				this.entry = vgui.Create("ixRowNumberEntry")
				this.entry:Attach(this)
				this.entry:SetCharacters("1234567890")
				this.entry:SetValue(self.chance or 0)
				this.entry.OnValueChanged = function(t)
					self.chance = math.Clamp(math.Round(t:GetValue(), 0), 0, 100)
					panel.itemList[self.itemID] = self.chance
					self.selected = true
				end
			else
				LocalPlayer():Notify("Установи рандом: вещественный")
			end
		end
	end

	self.icon.PaintOver = function(t, w, h)
		local type = select(2, panel.chance.box:GetSelected())

		if (type != "linear" and self.chance) then
			draw.SimpleTextOutlined(self.chance .. "%", "ixSubTitleFont", w * 0.5, h * 0.5, color_white, 1, 1, 1, color_black)
		end
	end

	self.icon.Paint = function(_, w, h)
		if (self.selected) then
			surface.SetDrawColor(ColorAlpha(Color("green"), 15))
			surface.DrawRect( 0, 0, w, h )
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
	local hovered

	if (self:IsHovered() or self.icon and self.icon:IsHovered()) then
		hovered = ix.config.Get("color")
	end

	derma.SkinFunc("PaintButton2", self, w, h, hovered)
end

vgui.Register("ixItemSpawnerItem", PANEL, "DPanel")
