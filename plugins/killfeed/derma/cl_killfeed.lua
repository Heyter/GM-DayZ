-- FRETTA13

surface.CreateFont("ixKillfeed", {
	font = "Jura",
	extended = true, 
	size = ScreenScale(9), 
	weight = 400, 
})

local PANEL = {}

function PANEL:Init()
	self.Padding = 8
	self.Spacing = 8
	self.background_color = Color(0, 0, 0, 200)
	self.Items = {}
end 

function PANEL:AddItem(item)
	self.Items[#self.Items + 1] = item
	self:InvalidateLayout(true)
end

function PANEL:AddText(txt, color)
	txt = txt:Trim()

	local lbl = vgui.Create("DLabel", self)
	lbl:SetFont("ixKillfeed")
	lbl:SetText(txt)
	lbl:SetTextColor(color or color_white)

	self:AddItem(lbl)
end

function PANEL:AddIcon(txt)
	if (killicon.Exists(txt)) then
		local icon = vgui.Create("DKillIcon", self)
		icon:SetName(txt)
		icon:SizeToContents()
		self:AddItem(icon)
	else
		self:AddText("killed")
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(self.background_color)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:PerformLayout(w, h)
	local x = self.Padding
	local height = self.Padding * 0.5

	for _, v in ipairs(self.Items) do
		v:SetPos(x, self.Padding * 0.5)
		v:SizeToContents()

		x = x + v:GetWide() + self.Spacing
		height = math.max(height, v:GetTall() + self.Padding)
	end

	self:SetSize(x, height)
end

derma.DefineControl("GameNotice", "", PANEL, "DPanel")