local matTile = ix.util.GetMaterial('gmodz/gui/concrete/tile.png')
--local matSelected = ix.util.GetMaterial('gmodz/gui/concrete/borderselected.png')

local function draw_tile(w, h)
	surface.SetDrawColor(200, 200, 200, 255)
	surface.SetMaterial(matTile)
	surface.DrawTexturedRect(0, 0, w, h)
end

local function draw_selected(w, h, color)
	-- surface.SetDrawColor(51, 204, 51, 155)
	-- surface.SetMaterial(matSelected)
	-- surface.DrawTexturedRect(x, y, w, h)
	surface.SetDrawColor(color)
	surface.DrawRect(2, 2, w - 4, h - 4)
end

-- The queue for the rendered icons.
ICON_RENDER_QUEUE = ICON_RENDER_QUEUE or {}

-- To make making inventory variant, This must be followed up.
local function RenderNewIcon(panel, itemTable)
	local model = itemTable:GetModel()

	-- re-render icons
	if ((itemTable.iconCam and !ICON_RENDER_QUEUE[string.lower(model)]) or itemTable.forceRender) then
		local iconCam = itemTable.iconCam
		iconCam = {
			cam_pos = iconCam.pos,
			cam_ang = iconCam.ang,
			cam_fov = iconCam.fov,
		}
		ICON_RENDER_QUEUE[string.lower(model)] = true

		panel.Icon:RebuildSpawnIconEx(
			iconCam
		)
	end
end

local PANEL = vgui.GetControlTable("ixInventory")

function PANEL:AddIcon(model, x, y, w, h, skin)
	local iconSize = self.iconSize

	w = w or 1
	h = h or 1

	if (self.slots[x] and self.slots[x][y]) then
		local panel = self:Add("ixItemIcon")
		panel:SetSize(w * iconSize, h * iconSize)
		panel:SetZPos(999)
		panel:InvalidateLayout(true)
		panel:SetModel(model, skin)
		panel:SetPos(self.slots[x][y]:GetPos())
		panel.gridX = x
		panel.gridY = y
		panel.gridW = w
		panel.gridH = h

		local inventory = ix.item.inventories[self.invID]

		if (!inventory) then
			return
		end

		local itemTable = inventory:GetItemAt(panel.gridX, panel.gridY)

		panel:SetInventoryID(inventory:GetID())
		panel:SetItemTable(itemTable)

		if (self.panels[itemTable:GetID()]) then
			self.panels[itemTable:GetID()]:Remove()
		end

		if (itemTable.exRender) then
			panel.Icon:SetVisible(false)
			panel.ExtraPaint = function(this, panelX, panelY)
				local exIcon = ikon:GetIcon(itemTable.uniqueID)
				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, panelX, panelY)
				else
					ikon:renderIcon(
						itemTable.uniqueID,
						itemTable.width,
						itemTable.height,
						itemTable:GetModel(),
						itemTable.iconCam
					)
				end
			end
		elseif (itemTable.icon) then
			self.Icon:SetVisible(false)
			self.ExtraPaint = function(self, x, y)
				surface.SetDrawColor(color_white)
				surface.SetMaterial(itemTable.icon)
				surface.DrawTexturedRect(0, 0, x, y)
			end
		else
			-- yeah..
			RenderNewIcon(panel, itemTable)
		end

		panel.slots = {}

		for i = 0, w - 1 do
			for i2 = 0, h - 1 do
				local slot = self.slots[x + i] and self.slots[x + i][y + i2]

				if (IsValid(slot)) then
					slot.item = panel
					panel.slots[#panel.slots + 1] = slot
				else
					for _, v in ipairs(panel.slots) do
						v.item = nil
					end

					panel:Remove()

					return
				end
			end
		end

		return panel
	end
end

function PANEL:PaintDragPreview(width, height, mouseX, mouseY, itemPanel)
	local iconSize = self.iconSize
	local item = itemPanel:GetItemTable()

	if (item) then
		local inventory = ix.item.inventories[self.invID]
		local dropX = math.ceil((mouseX - 4 - (itemPanel.gridW - 1) * 32) / iconSize)
		local dropY = math.ceil((mouseY - self:GetPadding(2) - (itemPanel.gridH - 1) * 32) / iconSize)

		local hoveredPanel = vgui.GetHoveredPanel()

		if (IsValid(hoveredPanel) and hoveredPanel != itemPanel and hoveredPanel.GetItemTable) then
			local hoveredItem = hoveredPanel:GetItemTable()

			if (hoveredItem) then
				local info = hoveredItem.functions.combine

				if (info and info.OnCanRun) then
					local result = info.OnCanRun(hoveredItem, {item.id})

					surface.SetDrawColor(ColorAlpha(derma.GetColor(result == false and "Error" or "Info", self, Color(200, 0, 0)), 20))
					surface.DrawRect(
						hoveredPanel.x,
						hoveredPanel.y,
						hoveredPanel:GetWide(),
						hoveredPanel:GetTall()
					)

					self.combineItem = hoveredItem

					return
				end
			end
		end

		self.combineItem = nil

		-- don't draw grid if we're dragging it out of bounds
		if (inventory) then
			local invWidth, invHeight = inventory:GetSize()

			if (dropX < 1 or dropY < 1 or
				dropX + itemPanel.gridW - 1 > invWidth or
				dropY + itemPanel.gridH - 1 > invHeight) then
				return
			end
		end

		local bEmpty = true

		for x = 0, itemPanel.gridW - 1 do
			for y = 0, itemPanel.gridH - 1 do
				local x2 = dropX + x
				local y2 = dropY + y

				bEmpty = self:IsEmpty(x2, y2, itemPanel)

				if (!bEmpty) then
					-- no need to iterate further since we know something is blocking the hovered grid cells, break through both loops
					goto finish
				end
			end
		end

		::finish::
		local previewColor = ColorAlpha(derma.GetColor(bEmpty and "Success" or "Error", self, Color(200, 0, 0)), 20)

		surface.SetDrawColor(previewColor)
		surface.DrawRect(
			(dropX - 1) * iconSize + 4,
			(dropY - 1) * iconSize + self:GetPadding(2),
			itemPanel:GetWide(),
			itemPanel:GetTall()
		)
	end
end

function PANEL:BuildSlots()
	local iconSize = self.iconSize

	self.slots = self.slots or {}

	for _, v in ipairs(self.slots) do
		for _, v2 in ipairs(v) do
			v2:Remove()
		end
	end

	self.slots = {}

	for x = 1, self.gridW do
		self.slots[x] = {}

		for y = 1, self.gridH do
			local slot = self:Add("DPanel")
			slot:SetZPos(-999)
			slot.gridX = x
			slot.gridY = y
			slot:SetPos((x - 1) * iconSize + 4, (y - 1) * iconSize + self:GetPadding(2))
			slot:SetSize(iconSize, iconSize)
			slot.Paint = function(panel, width, height)
				draw_tile(width, height)
			end

			self.slots[x][y] = slot
		end
	end
end

derma.DefineControl("ixInventory", "", PANEL, "DFrame")

-- IX_ITEM_ICON
PANEL = vgui.GetControlTable("ixItemIcon")

PANEL.colors = {
	tile = Color(0, 0, 0, 85),
	tooltip = Color(125, 125, 125, 30)
}

function PANEL:OnMousePressed(code)
	if (code == MOUSE_LEFT and self:IsDraggable()) then
		if (!input.IsShiftDown()) then
			self:MouseCapture(true)
			self:DragMousePress(code)

			self.clickX, self.clickY = input.GetCursorPos()
		else
			local itemTable = self.itemTable
			local inventory = ix.item.inventories[self.inventoryID]

			if (itemTable and inventory) then
				hook.Run("ItemPressedLeftShift", self, itemTable, inventory)
			end
		end
	elseif (code == MOUSE_RIGHT and self.DoRightClick) then
		if (!input.IsShiftDown()) then
			self:DoRightClick()
		else
			self:DoRightShiftClick() -- quick use items
		end
	end
end

function PANEL:DoRightShiftClick()
	if (self.nextClickTime or 0) > CurTime() then return end
	self.nextClickTime = CurTime() + 0.5

	local itemTable = self.itemTable
	local invID = self.inventoryID
	local inventory = ix.item.inventories[invID]

	if (itemTable and inventory) then
		itemTable.player = LocalPlayer()

		local info, action = hook.Run("ItemPressedRightShift", self, itemTable, inventory)

		if !(info and action) then
			if (itemTable:GetData("equip")) then
				info = itemTable.functions.EquipUn
				action = "EquipUn"
			else
				info = itemTable.functions.Equip
				action = "Equip"
			end
		end

		if (info and info.OnCanRun and info.OnCanRun(itemTable) != false) then
			net.Start("ixInventoryAction")
				net.WriteString(action)
				net.WriteUInt(itemTable.id, 32)
				net.WriteUInt(invID, 32)
				net.WriteTable({})
			net.SendToServer()
		end

		itemTable.player = nil
	end
end

function PANEL:Paint(width, height)
	draw_tile(width, height)

	self.hovered_color = self.colors.tile

	if (GLOBAL_TOOLTIP and IsValid(GLOBAL_TOOLTIP[1]) 
		and self.itemTable and GLOBAL_TOOLTIP[2].uniqueID != self.itemTable.uniqueID 
		and GLOBAL_TOOLTIP[2].CanTooltip 
		and GLOBAL_TOOLTIP[2]:CanTooltip(self.itemTable)) then

		self.hovered_color = self.colors.tooltip
	elseif (self:IsHovered()) then
		draw_selected(width, height, ColorAlpha(derma.GetColor("Success", self, Color(200, 0, 0)), 35))
	end

	draw_selected(width, height, self.hovered_color)

	self:ExtraPaint(width, height)
end

derma.DefineControl("ixItemIcon", "", PANEL, "SpawnIcon")