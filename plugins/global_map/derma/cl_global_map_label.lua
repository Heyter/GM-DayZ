local PANEL = {}

function PANEL:Init()
	self.color_label = color_white
	self.text_label = "Label Name"

	self:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	self:Center()
	self:MakePopup()

	self.mixer = self:Add("DColorMixer")
	self.mixer:Dock(FILL)
	self.mixer:SetPalette(true)
	self.mixer:SetAlphaBar(true)
	self.mixer:SetWangs(true)
	self.mixer:SetColor(color_white)

	self.mixer.ValueChanged = function(_, col)
		self.color_label = col
	end

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:Dock(LEFT)

	for k, v in ipairs(ix.map.signs) do
		if (k != 1) then
			local btn = self.scroll:Add( "DButton" )
			btn:SetText(v)
			btn:Dock(TOP)
			btn:DockMargin(0, 0, 5, 5)
			btn.Paint = function(_, w, h)
				surface.SetDrawColor(Color("light_gray"))
				surface.DrawRect(0, 0, w, h)
			end
			btn.DoClick = function()
				self:SetData(v .. " " .. self.textEntry:GetValue())
			end
		end
	end

	self.button_done = self:Add("DButton")
	self.button_done:SetText("Done")
	self.button_done:SetIcon("icon16/accept.png")
	self.button_done:Dock(BOTTOM)

	self.button_done.DoClick = function()
		local text = self.textEntry:GetValue()

		if (#text < 1 or text == "Label Name") then
			return
		end

		if (self.DoneClick) then
			self:DoneClick(text, self.color_label, self.index_label)
		end

		self:Remove()
	end

	self.label = self:Add("EditablePanel")
	self.label:Dock(BOTTOM)
	self.label:SetSize(64, 64)
	self.label.Paint = function(this, w, h)
		surface.SetDrawColor(ColorAlpha(color_white, 100))
		surface.DrawRect(0, 0, w, h)

		local x, y = w * 0.5, h / 2

		draw.SimpleTextOutlined(self.text_label, "MapFont", x, y - ix.map.iconSize, self.color_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		draw.SimpleTextOutlined(ix.map.signs[1], "MapFont", x, y, self.color_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	end

	self.textEntry = self:Add("DTextEntry")
	self.textEntry:SetPlaceholderText("Enter the label name")
	self.textEntry:Dock(BOTTOM)
	self.textEntry.OnChange = function(this)
		local text = this:GetValue()

		if (#text < 1) then
			text = "Label Name"
		end

		self.text_label = text
	end
end

function PANEL:SetData(text, color, index)
	if (color) then
		self.color_label = color
		self.mixer:SetColor(color)
	end

	if (text) then
		self.text_label = text
		self.textEntry:SetValue(text)
	end

	if (index) then
		self.index_label = index
	end
end

vgui.Register("ixMapSetLabel", PANEL, "DFrame")