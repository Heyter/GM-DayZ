local matTile = ix.util.GetMaterial('gmodz/gui/concrete/tile.png')
local matSelected = ix.util.GetMaterial('gmodz/gui/concrete/borderselected.png')

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

local PANEL = vgui.GetControlTable("ixInventory")

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

function PANEL:Paint(width, height)
	draw_tile(width, height)

	if (self:IsHovered()) then
		draw_selected(width, height, ColorAlpha(derma.GetColor("Success", self, Color(200, 0, 0)), 35))
	end

	surface.SetDrawColor(0, 0, 0, 85)
	surface.DrawRect(2, 2, width - 4, height - 4)

	self:ExtraPaint(width, height)
end

derma.DefineControl("ixItemIcon", "", PANEL, "SpawnIcon")