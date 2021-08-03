local SKIN = derma.GetNamedSkin("helix")

SKIN.matInvSlot = ix.util.GetMaterial('gmodz/gui/concrete/tile.png')

SKIN.Colours.Outline = Color(60, 60, 60, 255)
SKIN.Colours.ButtonRect = Color(40, 40, 40, 255)
SKIN.Colours.GlobalTooltip = Color(125, 125, 125, 30)
SKIN.Colours.FrameBG = Color(24, 24, 24, 255)

SKIN.Colours.Window.TitleActive = color_white
SKIN.Colours.Window.TitleInactive = Color(167, 167, 167)

function SKIN:PaintBaseFrame(panel, w, h)
	surface.SetDrawColor(self.Colours.FrameBG)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(ix.config.Get("color"))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function SKIN:PaintFrame2(panel, w, h)
	surface.SetDrawColor(self.Colours.FrameBG)
	surface.DrawRect(0, 0, w, h)

	-- Title
	surface.SetDrawColor(self.Colours.Outline)
	surface.DrawRect(0, 0, w, 24)
end

function SKIN:PaintInventorySlot(panel, w, h)
	surface.SetDrawColor(200, 200, 200, 255)
	surface.SetMaterial(self.matInvSlot)
	surface.DrawTexturedRect(0, 0, w, h)
end

function SKIN:PaintButton2(panel, w, h, hovered)
	surface.SetDrawColor(self.Colours.ButtonRect)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(hovered or self.Colours.Outline)
	surface.DrawOutlinedRect(0, 0, w, h, 1)
end

function SKIN:PaintMerchantSlot(panel, w, h)
	surface.SetDrawColor(self.Colours.ButtonRect)
	surface.DrawRect(0, 0, w, h)

	local hovered = self.Colours.Outline

	if (panel:IsHovered() or panel.icon and panel.icon:IsHovered()) then
		hovered = ix.config.Get("color")
	end

	if (GLOBAL_TOOLTIP and IsValid(GLOBAL_TOOLTIP[1]) 
		and panel.itemTable and GLOBAL_TOOLTIP[2].uniqueID != panel.itemTable.uniqueID 
		and GLOBAL_TOOLTIP[2].CanTooltip 
		and GLOBAL_TOOLTIP[2]:CanTooltip(panel.itemTable)) then

		surface.SetDrawColor(self.Colours.GlobalTooltip)
		surface.DrawRect(2, 2, w - 4, h - 4)

		hovered = ix.config.Get("color")
	end

	surface.SetDrawColor(hovered)
	surface.DrawOutlinedRect(0, 0, w, h, 1)
end

function SKIN:PaintButtonFilled(panel, w, h)
	local hovered = ix.config.Get("color")

	if (!panel:IsEnabled()) then
		hovered = ix.config.Get("color")
	elseif (panel.Depressed) then
		hovered = ix.color.Darken(hovered, 35)
	elseif (panel.Hovered) then
		hovered = ix.color.Darken(hovered, 25)
	end

	surface.SetDrawColor(hovered)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(180, 180, 180, 2)
	surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
end

function SKIN:PaintComboBox(panel, w, h)
	surface.SetDrawColor(self.Colours.Outline)
	surface.DrawRect(0, 0, w, h)
end

derma.DefineSkin("helix", "The base skin for the Helix framework.", SKIN)
derma.RefreshSkins()