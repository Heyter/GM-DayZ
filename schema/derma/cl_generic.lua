local strAllowedNumericCharacters = "1234567890.-"

DEFINE_BASECLASS("Panel")
--local baseEntry = baseclass.Get( "DTextEntry" )
local PANEL = {}

AccessorFunc(PANEL, "bDeleteSelf", "DeleteSelf", FORCE_BOOL)
AccessorFunc(PANEL, "m_characters", "Characters", FORCE_STRING)

PANEL.outlineRect = Color(204, 204, 204, 100)

function PANEL:Init()
	surface.SetFont("ixMenuButtonFont")
	local width, height = surface.GetTextSize("999999")

	self.m_bIsMenuComponent = true
	self.bDeleteSelf = true

	self.realHeight = 200
	self.height = 200
	self:SetSize(width + 50, height)
	self:DockPadding(4, 4, 4, 4)

	self:SetCharacters(strAllowedNumericCharacters)

	self.textEntry = self:Add("ixTextEntry")
	self.textEntry:SetNumeric(true)
	self.textEntry:SetAllowNonAsciiCharacters(false)
	self.textEntry:SetFont("ixMenuButtonFont")
	self.textEntry:SetCursorColor(color_white)
	self.textEntry:Dock(FILL)
	self.textEntry:RequestFocus()
	self.textEntry.OnEnter = function()
		self:Remove(true)
	end
	self.textEntry.Paint = function(t, w, h)
		surface.SetDrawColor(90, 90, 90, 255)
		surface.DrawRect(0, 0, w, h)

		t:DrawTextEntryText(color_white, ix.config.Get("color"), color_white)
	end
	self.textEntry.CheckNumeric = function(t, strValue)
		if ( !t:GetNumeric() ) then return false end
		if ( !string.find( self.m_characters, strValue, 1, true ) ) then
			return true
		end

		return false
	end

	self.textButton = self:Add("DButton")
	self.textButton:SetFont("ixMenuButtonFont")
	self.textButton:SetText("OK")
	self.textButton:Dock(RIGHT)
	self.textButton:SizeToContents()
	self.textButton.Paint = function(t, w, h)
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(self.outlineRect)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self.textButton.DoClick = function()
		self:Remove(true)
	end

	self:MakePopup()
	RegisterDermaMenuForClose(self)
end

function PANEL:SetValue(value, bInitial)
	value = tostring(value)
	self.textEntry:SetValue(value)

	if (bInitial) then
		self.textEntry:SetCaretPos(value:utf8len())
	end
end

function PANEL:GetValue()
	return tonumber(self.textEntry:GetValue()) or 0
end

function PANEL:Attach(panel)
	self.attached = panel
end

function PANEL:Think()
	local panel = self.attached

	if (IsValid(panel)) then
		local width, height = self:GetSize()
		local x, y = panel:LocalToScreen(0, 0)

		self:SetPos(
			math.Clamp(x + panel:GetWide() - width, 0, ScrW() - width),
			math.Clamp(y + panel:GetTall(), 0, ScrH() - height)
		)
	end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(derma.GetColor("DarkerBackground", self))
	surface.DrawRect(0, 0, width, height)
end

function PANEL:OnValueChanged()
end

function PANEL:Remove(valueChanged)
	if (self.bClosing) then
		return
	end

	if (valueChanged) then self:OnValueChanged() end

	-- @todo open/close animations
	self.bClosing = true
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	BaseClass.Remove(self)
end

vgui.Register("ixRowNumberEntry", PANEL, "EditablePanel")