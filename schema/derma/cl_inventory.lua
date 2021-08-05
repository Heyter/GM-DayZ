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

function PANEL:OnTransfer(oldX, oldY, x, y, oldInventory, noSend)
	local inventories = ix.item.inventories
	local inventory = inventories[oldInventory.invID]
	local inventory2 = inventories[self.invID]
	local item, stack

	if (inventory) then
		item = inventory:GetItemAt(oldX, oldY)

		if (!item) then
			return false
		end

		if (hook.Run("CanTransferItem", item, inventories[oldInventory.invID], inventories[self.invID]) == false) then
			return false, "notAllowed"
		end

		if (item.CanTransfer and
			item:CanTransfer(inventory, inventory != inventory2 and inventory2 or nil) == false) then
			return false
		end

		if (item.isStackable and inventory != inventory2 and inventory2) then
			local remainingQuantity = item:GetData('quantity', 1)
			local targetAssignments = {}

			if (remainingQuantity < (item.maxQuantity or 16)) then
				local items = inventory2:GetItemsByUniqueID(item.uniqueID, true)

				if (items) then
					for _, targetItem in pairs(items) do
						if (remainingQuantity == 0) then
							break 
						end

						if (item.CanStack and item:CanStack(targetItem) == false) then continue end
						local freeSpace = targetItem.maxQuantity - targetItem:GetData('quantity', 1)

						if (freeSpace > 0) then
							local filler = freeSpace - remainingQuantity

							if (filler > 0) then
								targetAssignments[targetItem] = remainingQuantity	
								remainingQuantity = 0
							else
								targetAssignments[targetItem] = freeSpace		
								remainingQuantity = math.abs(filler)
							end
						end
					end
				end

				if (remainingQuantity == 0) then
					for targetItem, assignedQuantity in pairs(targetAssignments) do
						targetItem:SetData("quantity", targetItem:GetData('quantity', 1) + assignedQuantity, true)
					end

					stack = "stack"
				end
			end

			if (!stack and inventory2:GetItemAt(x, y)) then
				x, y = nil, nil
				x, y = inventory2:FindEmptySlot(item.width, item.height, true) -- Если предмет больше 1x1, то он ошибается.
				-- self:IsAllEmpty -- тоже ошибается

				if (!x and !y or inventory2:GetItemAt(x, y)) then
					return false, "noFit"
				end
			end
		end
	end

	if (!noSend) then
		net.Start("ixInventoryMove")
			net.WriteUInt(oldX, 6)
			net.WriteUInt(oldY, 6)
			net.WriteUInt(x, 6)
			net.WriteUInt(y, 6)
			net.WriteUInt(oldInventory.invID, 32)
			net.WriteUInt(self != oldInventory and self.invID or oldInventory.invID, 32)
		net.SendToServer()
	end

	if (inventory) then
		inventory.slots[oldX][oldY] = nil
	end

	if (!stack and item and inventory2) then
		inventory2.slots[x] = inventory2.slots[x] or {}
		inventory2.slots[x][y] = item
	end

	return stack
end

derma.DefineControl("ixInventory", "", PANEL, "DFrame")

-- IX_ITEM_ICON
PANEL = vgui.GetControlTable("ixItemIcon")

PANEL.colors = {
	tile = Color(0, 0, 0, 85)
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

function PANEL:Move(newX, newY, givenInventory, bNoSend)
	local iconSize = givenInventory.iconSize
	local oldX, oldY = self.gridX, self.gridY
	local oldParent = self:GetParent()
	local result = givenInventory:OnTransfer(oldX, oldY, newX, newY, oldParent, bNoSend)

	if (result == "stack") then
		if (self.slots) then
			for _, v in ipairs(self.slots) do
				if (IsValid(v) and v.item == self) then
					v.item = nil
				end
			end
		end

		self:Remove()
		return
	elseif (result == false) then
		return
	end

	local x = (newX - 1) * iconSize + 4
	local y = (newY - 1) * iconSize + givenInventory:GetPadding(2)

	self.gridX = newX
	self.gridY = newY

	self:SetParent(givenInventory)
	self:SetPos(x, y)

	if (self.slots) then
		for _, v in ipairs(self.slots) do
			if (IsValid(v) and v.item == self) then
				v.item = nil
			end
		end
	end

	self.slots = {}

	for currentX = 1, self.gridW do
		for currentY = 1, self.gridH do
			local slot = givenInventory.slots[self.gridX + currentX - 1][self.gridY + currentY - 1]

			slot.item = self
			self.slots[#self.slots + 1] = slot
		end
	end
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintInventorySlot", self, width, height)

	self.hovered_color = self.colors.tile

	if (GLOBAL_TOOLTIP and IsValid(GLOBAL_TOOLTIP[1]) 
		and self.itemTable and GLOBAL_TOOLTIP[2].uniqueID != self.itemTable.uniqueID 
		and GLOBAL_TOOLTIP[2].CanTooltip 
		and GLOBAL_TOOLTIP[2]:CanTooltip(self.itemTable)) then

		self.hovered_color = derma.GetColor("GlobalTooltip", self, Color(125, 125, 125, 30))
	elseif (self:IsHovered()) then
		draw_selected(width, height, ColorAlpha(derma.GetColor("Success", self, Color(200, 0, 0)), 35))
	end

	draw_selected(width, height, self.hovered_color)

	self:ExtraPaint(width, height)
end

derma.DefineControl("ixItemIcon", "", PANEL, "SpawnIcon")