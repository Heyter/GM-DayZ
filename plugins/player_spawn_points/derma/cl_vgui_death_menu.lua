local gray = Color(51,51,51,250)
local function paint_button(t, w, h)
	local clr = gray

	if (t:IsHovered()) then
		clr = ix.color.Lighten(gray, 15)
	end

	surface.SetDrawColor(clr)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color("orange"))
	surface.DrawRect(0, 0, w, 2)
end

surface.CreateFont("DeathMenuBtn", {
	font = "Jura",
	size = 18, --math.max(18, ScrH() / 480 * 10),
	weight = 550,
})

local PANEL = {}
PANEL.ButtonFont = "DeathMenuBtn"
PANEL.BackgroundColor = Color(34, 34, 34, 250)

function PANEL:Init()
	self:SetSize(ScrW(), 64)
	self:SetPos(0, ScrH() - 64)
	self:ParentToHUD()

	self.deathTime = nil
	self.allow_button = nil
	self.space = 128

	self.disconnect = self:Add("DButton")
	self.disconnect:Dock(LEFT)
	self.disconnect:SetWide(self.space)
	self.disconnect:SetFont(self.ButtonFont)
	self.disconnect:SetText(L"psp_btn_disconnect")
	self.disconnect:SetContentAlignment(5)
	self.disconnect:DockMargin(10, 10, 0, 10)
	self.disconnect.Paint = paint_button
	self.disconnect.DoClick = function()
		RunConsoleCommand("disconnect")
	end

	self.spawn1 = self:AddButton(L"psp_btn_spawnatsafe", true)
	self.spawn2 = self:AddButton(L"psp_btn_spawnrandomly")

	self.disconnect:SetTextColor(color_white)
	self.spawn1:ResetState()
	self.spawn2:ResetState()

	self:MakePopup()
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
end

function PANEL:AddButton(text, isRight)
	local btn = self:Add("DButton")
	btn:Dock(RIGHT)
	btn:SetFont(self.ButtonFont)
	btn:SetText("")
	btn:SetContentAlignment(5)
	btn:DockMargin(10, 10, isRight and 10 or 0, 10)
	btn.Text = text
	btn.ResetState = function(t)
		local text = t.Text
		t:SetText(text)

		surface.SetFont(self.ButtonFont)
		t:SetWide(self.space + select(1, surface.GetTextSize(text)) * 0.5)
		t:SetTextColor(color_white)
	end
	btn.Paint = paint_button
	btn.DoClick = function(t)
		if (!self.allow_button) then return end

		if ((LocalPlayer().ixPlayerDeathMenu or 0) < CurTime()) then
			LocalPlayer().ixPlayerDeathMenu = CurTime() + 1
		else
			return
		end

		net.Start("ixPlayerDeathMenu")
			net.WriteBool(isRight) -- true = safezone
		net.SendToServer()
	end

	return btn
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(self.BackgroundColor)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:SetupButtons()
	if (self.deathTime) then
		local time = math.max(0, self.deathTime - RealTime())
		local text1 = Format("%s (%s)", self.spawn1.Text, string.ToMinutesSeconds(time))
		local text2 = Format("%s (%s)", self.spawn2.Text, string.ToMinutesSeconds(time))

		self.spawn1:SetText(text1)
		self.spawn2:SetText(text2)

		surface.SetFont(self.ButtonFont)
		local textW = surface.GetTextSize(text1)
		self.spawn1:SetWide(self.space + textW * 0.5)

		textW = surface.GetTextSize(text2)
		self.spawn2:SetWide(self.space + textW * 0.5)

		if (time == 0) then
			self.spawn1:ResetState()
			self.spawn2:ResetState()
			self.allow_button = true
		else
			self.spawn1:SetTextColor(Color("red"))
			self.spawn2:SetTextColor(Color("red"))
		end
	end
end

function PANEL:Think()
	if (!LocalPlayer():GetCharacter()) then
		self:SetAlpha(0)
		return
	end

	local menu = (IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing()) and ix.gui.characterMenu
		or IsValid(ix.gui.menu) and ix.gui.menu
	local fraction = menu and 1 - menu.currentAlpha / 255 or 1

	if (LocalPlayer():Alive()) then
		fraction = 0

		if (self.allow_button) then
			self.deathTime = nil
			self.allow_button = nil
			self:SetMouseInputEnabled(false)
		end
	else
		if (!self.allow_button) then
			self.deathTime = self.deathTime or RealTime() + ix.config.Get("spawnTime", 5)
			self:SetMouseInputEnabled(true)
			self:SetupButtons()
		end
	end

	self:SetAlpha(255 * fraction)
end

vgui.Register("ixDeathScreenMenu", PANEL, "DPanel")

concommand.Add("gmodz_reload_death_menu", function()
	if (IsValid(ix.gui.death_menu)) then
		ix.gui.death_menu:Remove()
	end

	ix.gui.death_menu = vgui.Create("ixDeathScreenMenu") 
end)