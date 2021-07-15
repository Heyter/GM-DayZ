

-- Add SF Setting vgui
local function empty() end
local function wrapText(sText, wide)
	wide = wide - 10
	local tw,th = surface.GetTextSize(language.GetPhrase(sText))
	local lines,b = 1, false
	local s = ""
	for w in string.gmatch(sText, "[^%s,]+") do
		local tt = s .. (b and " " or "") .. w
		if surface.GetTextSize(tt) >= wide then
			s = s .. "\n" .. w
			lines = lines + 1
		else
			s = tt
		end
		b = true
	end
	return s, lines
end
local function niceName(sName)
	sName = string.Replace(sName, "_", " ")
	local str = ""
	for s in string.gmatch(sName, "[^%s]+") do
		str = str .. string.upper(s[1]) .. string.sub(s, 2) .. " "
	end
	return string.TrimRight(str, " ")
end
-- function to overwrite the textentity, and display the current temp setting.
local function makeTempDisplay( panel )
	panel._DrawTextEntryText = panel.DrawTextEntryText
	function panel:DrawTextEntryText( ... )
		local s = self:GetText()
		self:SetText(s .. StormFox2.Temperature.GetDisplaySymbol())
		self:_DrawTextEntryText( ... )
		self:SetText(s)
	end
end

local function PaintOver(self, w, h)
	--surface.SetDrawColor(color_black)
	--surface.DrawOutlinedRect(0,0,w,h)
	if not self.dMark then return end
	local b = self.dMark - CurTime()
	if b <= 0 then
		self.dMark = nil
		return
	end
	local a = math.sin(b * math.pi * 2 )
	surface.SetDrawColor(0,0,0, a * 100)
	surface.DrawRect(0,0,w,h)
end

local function SetSFConVar( convar, str )
	if StormFox2.Setting.IsGMSetting(convar) then return end
	if string.sub(convar, 0, 3) == "sf_" then
		convar = string.sub(convar, 4)
	end
	local var = StormFox2.Setting.StringToType( convar, str )
	StormFox2.Setting.Set(convar, var)
end

local function ConVarChanged( PANEL, strNewValue )
	if ( !PANEL.m_strConVar ) then return end
	SetSFConVar(PANEL.m_strConVar, strNewValue)
end

local function FindPercent( x, a, b )
	return (x - a) / (b - a)
end

local function SliderApply(self)
	local col = self.Label:GetTextStyleColor()
	if ( self.Label:GetTextColor() ) then col = self.Label:GetTextColor() end
	local col = table.Copy( col )
	col.a = 100 -- Fade it out a bit so it looks right
	if self.Slider.SetNotchColor then
		self.Slider:SetNotchColor( a )
	end
end

local b_alpha = Color(0,0,0,100)


-- Title
do
	local PANEL = {}
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFTitle", "", PANEL, "DLabel" )
end
-- String
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local b = vgui.Create("DTextEntry", self)
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		b:SetPos(5, l:GetTall() + 2)
		b:SetWide(150)
		d:SetPos(74, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._b = b	
		self._d = d
		
		self._w = 64
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, sType, sDesc )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( "#sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		self._b:SetText( con:GetString())
		function self._b:OnEnter( str )
			SetSFConVar(sName, tostring(str))
		end
		if StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetDisabled( true )
		end
		StormFox2.Setting.Callback(sName,function(vVar,vOldVar,_, self)
			self._b:SetText(vVar)
		end,self)
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des, self:GetWide() - self._b:GetWide())
		self._d:SetPos(10 + self._b:GetWide(), self._l:GetTall() + 2)
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max( 40, 10 + lines * 20)
		if lines == 1 then
			self._d:SetTall(22)
		end
		self:SetTall( h )
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_String", "", PANEL, "DPanel" )
end
-- Table
do
	local PANEL = {}
	local sortNum = function(a,b)
		if type(a) == "boolean" then
			return a or b
		end
		return a>b 
	end
	local sortStr = function(a,b) return a<b end
	
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local b = vgui.Create("DComboBox", self)
		b:SetSortItems(false)
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		b:SetPos(5, l:GetTall() + 2)
		d:SetPos(74, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._b = b	
		self._d = d
		self._w = 64
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, sType, sDesc )
		local tab, sortorder = sType[1], sType[2]
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( "#sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		local options = table.GetKeys(tab)
		local w = 64
		local sort_func = tonumber(con:GetString()) and sortNum or sortStr
		surface.SetFont(self:GetFont() or "DermaDefault")
		if not sortorder then -- In case we don't sort
			table.sort(options, sort_func)
			for k,v in ipairs(options) do
				local text = niceName( language.GetPhrase(tab[v]))
				self._b:AddChoice( text, v, con:GetInt() == v )
				local tw = surface.GetTextSize(text) + 24
				w = math.max(w, tw)
			end
		else
			for _,v in ipairs(sortorder) do
				local text = niceName( language.GetPhrase(tab[v] or "UNKNOWN"))
				self._b:AddChoice( text, v, con:GetInt() == v )
				local tw = surface.GetTextSize(text) + 24
				w = math.max(w, tw)
			end
			if #sortorder ~= #tab then -- Add the rest
				table.sort(options, sort_func)
				for _,v in ipairs(options) do
					if table.HasValue(sortorder, v) then continue end
					local text = niceName( language.GetPhrase(tab[v]))
					self._b:AddChoice( text, v, con:GetInt() == v )
					local tw = surface.GetTextSize(text) + 24
					w = math.max(w, tw)
				end
			end
		end
		function self._b:OnSelect( index, text, data )
			if type(data) == "nil" then -- Somehow we didn't get the value, try and locate it from button
				data = table.KeyFromValue(tab, string.lower(text))
			elseif type(data) == "boolean" then
				data = data and 1 or 0
			end
			SetSFConVar(sName, tostring(data))
		end
		local text = tab[con:GetString()] or tab[con:GetFloat()] or tab[con:GetBool()] or con:GetString()
		self._b:SetText(niceName( language.GetPhrase(sDesc or text)))
		StormFox2.Setting.Callback(sName,function(vVar,vOldVar,_, self)
			if type(vVar) == "boolean" then
				vVar = vVar and 1 or 0
			end
			local text = tab[vVar] or tab[tostring(vVar)] or vVar
			self._b:SetText(niceName( language.GetPhrase(text)))
		end,self)
		if StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetDisabled( true )
		end
		self._w = w
		self._b:SetWide(w)
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des, self:GetWide() - self._b:GetWide())
		self._d:SetPos(10 + self._b:GetWide(), self._l:GetTall() + 2)
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max( 40, 10 + lines * 20)
		if lines == 1 then
			self._d:SetTall(22)
		end
		self:SetTall( h )
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Enum", "", PANEL, "DPanel" )
end
-- Boolean
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local b = vgui.Create("DCheckBox", self)
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		b:SetPos(5, l:GetTall() + 2)
		d:SetPos(25, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 30)
		self._l = l
		self._b = b	
		self._d = d
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName,_,sDesc )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		self._b:SetConVar( "sf_" .. sName )
		function self._b:DoClick()
			SetSFConVar(sName, not self:GetChecked())
		end
		if StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetDisabled( true )
		end
		self._b.ConVarChanged = ConVarChanged
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(language.GetPhrase(self._des), self:GetWide())
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		self:SetTall(10 + lines * 20)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Bool", "", PANEL, "DPanel" )
end
-- Float
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local b = vgui.Create("DNumSlider", self)
		b.ApplySchemeSettings = SliderApply
		b.Label:Dock(NODOCK)
		b.PerformLayout = empty
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		b:SetPos(5, l:GetTall())
		b:SetWide(300)
		d:SetPos(305, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._b = b	
		self._d = d
		b.TextArea:SetDrawLanguageID( false )
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, _, sDesc )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")

		self._b:SetMin(con:GetMin() or 0)
		self._b:SetMax(con:GetMax() or 1)
		self._b.Scratch.ConVarChanged = ConVarChanged
		self._b.TextArea.ConVarChanged = ConVarChanged
		if not StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetConVar( "sf_" .. sName )
			self._b.ConVarChanged = ConVarChanged
		end
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des, self:GetWide() )
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Float", "", PANEL, "DPanel" )
end
-- Float-Special
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local b = vgui.Create("DNumSlider", self)
		b.ApplySchemeSettings = SliderApply
		local t = vgui.Create("DCheckBox", self)
		t.b = b
		b.TextArea:SetDrawLanguageID( false )
		b.Label:Dock(NODOCK)
		b.PerformLayout = empty
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		b:SetPos(20, l:GetTall())
		b:SetWide(280)
		d:SetPos(295, l:GetTall() + 2)
		t:SetPos(5, l:GetTall() + 8)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._b = b	
		self._d = d
		self._t = t
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, _, sDesc )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. "desc" or con:GetHelpText() or "Unknown")
		self._b:SetConVar( "sf_" .. sName )
		self._b.ConVarChanged = ConVarChanged
		self._b.Scratch.ConVarChanged = ConVarChanged
		self._b.TextArea.ConVarChanged = ConVarChanged
		self._b:SetMinMax( con:GetMin() or 0, con:GetMax() or 1)
		function self._t:DoClick()
			if con:GetFloat() >= 0 then
				SetSFConVar(sName, -1)
			else
				SetSFConVar(sName, 0.5)
			end
		end
		if StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetDisabled( true )
		end
		function self._t:Think()
			b = con:GetFloat() >= 0
			self:SetChecked( b )
			self.b:SetEnabled( b )
		end
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des, self:GetWide() - 280)
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Float_Toggle", "", PANEL, "DPanel" )
end
-- Number
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		d:SetText("Unknown ConVar")
		d:SetColor(color_black)
		d:SetPos(5, l:GetTall() + 2)
		d:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._d = d
	end
	function PANEL:SetConvar( sName,_, sDesc )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		self._dw = 0
		local nMin, nMax = con:GetMin(), con:GetMax()
		-- Regular number
		if not nMax then
			self._type = false
			local n = vgui.Create("DNumberWang", self)
			n:SetPos(5, self._l:GetTall() + 2)
			n:SetValue( con:GetInt() )
			n:SetWide(64)
			n:SetMax(nil)
			self._dw = 64
			n:SetConVar( "sf_" .. sName )
			n:SetDrawLanguageID( false )
			n.ConVarChanged = ConVarChanged
			if StormFox2.Setting.IsGMSetting(sName) then
				n:SetDisabled( true )
			end
			self._d:SetPos(74,self._l:GetTall() + 4)
			if nMin then n:SetMin(nMin) end
		else
			self._type = true
			local b = vgui.Create("DNumSlider", self)
			b.ApplySchemeSettings = SliderApply
			b.Label:Dock(NODOCK)
			b.PerformLayout = empty
			b:SetPos(5, self._l:GetTall())
			b:SetWide(300)
			self._dw = 300
			b:SetDecimals( 0 )
			if nMin then b:SetMin(nMin) end
			b:SetMax(nMax)
			b:SetConVar( "sf_" .. sName  )
			b.Scratch.ConVarChanged = ConVarChanged
			b.TextArea.ConVarChanged = ConVarChanged
			b.TextArea:SetDrawLanguageID( false )
			b.ConVarChanged = ConVarChanged
			if StormFox2.Setting.IsGMSetting(sName) then
				b:SetDisabled( true )
			end
			self._d:SetPos(305, self._l:GetTall() + 2)
		end
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des or "UNKNOWN", self:GetWide() - self._dw)
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Number", "", PANEL, "DPanel" )
end
-- Time
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		self.trigger = true
		--self.Paint = empty
		local use_12 = StormFox2.Setting.GetCache("12h_display",default_12)
		local l = vgui.Create( "DLabel", self )
		local hour = vgui.Create("DNumberWang", self)
		local dot = vgui.Create("DPanel", self)
		function dot:Paint(w,h)
			draw.DrawText(":", "DermaLarge", w/2, -8, color_black, TEXT_ALIGN_CENTER)
		end
		local minute = vgui.Create("DNumberWang", self)
		minute:SetMax(59)
		hour:SetMin(0)
		minute:SetMin(0)
		minute:SetDrawLanguageID( false )
		hour:SetDrawLanguageID( false )
		local ampm
		if use_12 then
			hour:SetMax(12)
			ampm = vgui.Create("DComboBox", self)
			ampm:AddChoice( "AM", 0, false )
			ampm:AddChoice( "PM", 1, false )
			ampm:SetSize(64, 20)
			hour:SetMin(1)
			ampm:SetDrawLanguageID( false )
		else
			hour:SetMax(23)
		end
		local a = function(self, str)
			local n = tonumber(str) or 0
			if n < 0 then
				self:SetValue(0)
				self:SetText("0")
			elseif n > (self:GetMax()) then
				self:SetValue(self:GetMax())
				self:SetText(self:GetMax())
			elseif n < self:GetMin() then
				self:SetValue(self:GetMin())
				self:SetText(self:GetMin())
			end
		end
		hour.OnValueChanged = a
		minute.OnValueChanged = a
		local function OnValChang()
			if not self:IsEnabled() then return end
			if not self.trigger then return end
			local h = tonumber(hour:GetText()) or 0
			h = math.Clamp(h, 0, ampm and 12 or 23)
			local m = tonumber(minute:GetText()) or 0
			m = math.Clamp(m, 0, 59)
			local t = h .. ":" .. m
			if IsValid(ampm) then
				t = t .. " " .. ((ampm:GetSelected() or ampm:GetText()) == "AM" and "AM" or "PM")
			end
			local num = StormFox2.Time.StringToTime(t)
			if num and self.sName then
				SetSFConVar(self.sName, num)
			end
		end
		if ampm then
			function ampm:OnSelect()
				OnValChang()
			end
		end
		function hour:OnLoseFocus()
			self:UpdateConvarValue()
			hook.Call( "OnTextEntryLoseFocus", nil, self )
			a(self, self:GetText()) -- Clammp value
			local n = tonumber(self:GetText()) or 0
			OnValChang()
		end
		function minute:OnLoseFocus()
			self:UpdateConvarValue()
			hook.Call( "OnTextEntryLoseFocus", nil, self )
			a(self, self:GetText()) -- Clammp value
			local n = tonumber(self:GetText()) or 0
			OnValChang()
		end

		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		self.hour = hour
		self.minute = minute
		self.dot = dot
		self.ampm = ampm
		hour:SetWide(40)
		minute:SetWide(40)
		dot:SetWide(15)
		d:SetPos(25, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._d = d
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, _ , sDesc )
		local con = GetConVar( "sf_" .. sName )
		self.sName = sName
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		--self._b:SetConVar( "sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		self.trigger = false
			local n = con:GetFloat()
			if n < 0 then
				n = 0
				self.hour:SetDisabled(true)
				self.minute:SetDisabled(true)
				if self.ampm then
					self.ampm:SetDisabled(true)
				end
				self:SetDisabled(true)		
			end
			local time_str = StormFox2.Time.GetDisplay(n)
			local h,m = string.match(time_str, "(%d+):(%d+)")
			local am = string.find(time_str, "AM") and true or false
			self.hour:SetValue(tonumber(h))
			self.minute:SetValue(tonumber(m))
			if self.ampm then
				self.ampm:SetValue(am and "AM" or "PM")
			end
		self.trigger = true

		if StormFox2.Setting.IsGMSetting(sName) then
			self.hour:SetDisabled( true )
			self.minute:SetDisabled( true )
			if self.ampm then
				self.ampm:SetDisabled( true )
			end
		end

		StormFox2.Setting.Callback(sName,function(vVar,vOldVar,_, pln)
			pln.trigger = false
			if tonumber(vVar) < 0 then
				n = 0
				self.hour:SetDisabled(true)
				self.minute:SetDisabled(true)
				if self.ampm then
					self.ampm:SetDisabled(true)
				end
				self:SetDisabled(true)
			else
				self.hour:SetDisabled(false)
				self.minute:SetDisabled(false)
				if self.ampm then
					self.ampm:SetDisabled(false)
				end
				self:SetDisabled(false)
			end
			local time_str = StormFox2.Time.GetDisplay(vVar)
			local h,m,am = string.match(time_str, "(%d+):(%d+)%s?([PA]M)")
			pln.hour:SetValue(tonumber(h))
			local n = tonumber(m)
			pln.minute:SetValue(n)
			if pln.ampm then
				pln.ampm:SetValue(am=="AM" and "AM" or "PM")
			end
			pln.trigger = true
		end,self)
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local x = 5
		local y = self._l:GetTall() + 2
		self.hour:SetPos(x,y)
		x = x + self.hour:GetWide()
		self.dot:SetPos(x,y)
		x = x + self.dot:GetWide()
		self.minute:SetPos(x,y)
		x = x + self.minute:GetWide() + 5
		if self.ampm then
			self.ampm:SetPos(x,y)
			x = x + self.ampm:GetWide() + 5
		end
		local text, lines = wrapText(self._des, self:GetWide())
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		self._d:SetPos(x,y)

		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Time", "", PANEL, "DPanel" )
end
-- Time toggle
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		self.trigger = true
		self._enabled = true
		--self.Paint = empty
		local use_12 = StormFox2.Setting.GetCache("12h_display",default_12)
		local l = vgui.Create( "DLabel", self )
		local hour = vgui.Create("DNumberWang", self)
		local dot = vgui.Create("DPanel", self)
		local toggle = vgui.Create("DCheckBox", self)
		function dot:Paint(w,h)
			draw.DrawText(":", "DermaLarge", w/2, -8, color_black, TEXT_ALIGN_CENTER)
		end
		local minute = vgui.Create("DNumberWang", self)
		minute:SetMax(59)
		hour:SetMin(0)
		minute:SetMin(0)
		hour:SetDrawLanguageID( false )
		minute:SetDrawLanguageID( false )
		local ampm
		if use_12 then
			hour:SetMax(12)
			ampm = vgui.Create("DComboBox", self)
			ampm:AddChoice( "AM", 0, false )
			ampm:AddChoice( "PM", 1, false )
			ampm:SetSize(64, 20)
			ampm:SetDrawLanguageID( false )
		else
			hour:SetMax(23)
		end
		local a = function(self, str)
			local n = tonumber(str) or 0
			if n < 0 then
				self:SetValue(0)
				self:SetText("0")
			elseif n > (self:GetMax()) then
				self:SetValue(self:GetMax())
				self:SetText(self:GetMax())
			end
		end
		hour.OnValueChanged = a
		minute.OnValueChanged = a
		local function OnValChang()
			if not self._enabled then return end
			if not self.trigger then return end
			local h = tonumber(hour:GetText()) or 0
			h = math.Clamp(h, 0, ampm and 12 or 23)
			local m = tonumber(minute:GetText()) or 0
			m = math.Clamp(m, 0, 59)
			local t = h .. ":" .. m
			if ampm then
				t = t .. " " .. (ampm:GetSelected() or ampm:GetText() == "AM" and 0 or 1)
			end
			local num = StormFox2.Time.StringToTime(t)
			if num and self.sName then
				SetSFConVar(self.sName, num)
			end
		end
		if ampm then
			ampm.OnSelect = OnValChang
		end
		function hour:OnLoseFocus()
			self:UpdateConvarValue()
			hook.Call( "OnTextEntryLoseFocus", nil, self )
			a(self, self:GetText()) -- Clammp value
			local n = tonumber(self:GetText()) or 0
			OnValChang()
		end
		function minute:OnLoseFocus()
			self:UpdateConvarValue()
			hook.Call( "OnTextEntryLoseFocus", nil, self )
			a(self, self:GetText()) -- Clammp value
			local n = tonumber(self:GetText()) or 0
			OnValChang()
		end

		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		self._des = "This is an unset ConVar panel."
		d:SetText(self._des)
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		self.hour = hour
		self.minute = minute
		self.dot = dot
		self.ampm = ampm
		hour:SetWide(40)
		minute:SetWide(40)
		dot:SetWide(15)
		d:SetPos(25, l:GetTall() + 2)
		d:SetDark(true)
		d:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._d = d
		self._t = toggle
		self:InvalidateLayout(true)
	end
	function PANEL:SetConvar( sName, _, sDesc )
		local con = GetConVar( "sf_" .. sName )
		self.sName = sName
		self._l:SetText( sDesc and "#"..sDesc or "#sf_" .. sName )
		--self._b:SetConVar( "sf_" .. sName )
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or con:GetHelpText() or "Unknown")
		self.trigger = false
			local n = con:GetFloat()
			if n < 0 then
				n = 0
				self.hour:SetDisabled(true)
				self.minute:SetDisabled(true)
				if self.ampm then
					self.ampm:SetDisabled(true)
				end
				self._enabled = false
				self._t:SetChecked( false )
			else
				self._t:SetChecked( true )
			end
			local time_str = StormFox2.Time.GetDisplay(n)
			local h,m = string.match(time_str, "(%d+):(%d+)")
			local am = string.find(time_str, "AM") and true or false
			self.hour:SetValue(tonumber(h))
			self.minute:SetValue(tonumber(m))
			if self.ampm then
				self.ampm:SetValue(am and "AM" or "PM")
			end
		self.trigger = true
		function self._t:DoClick()
			if con:GetFloat() < 0 then
				SetSFConVar(sName, 0)
			else 
				SetSFConVar(sName, -1)
			end
		end
		if StormFox2.Setting.IsGMSetting(sName) then
			self._t:SetDisabled( true )
		end
		StormFox2.Setting.Callback(sName,function(vVar,vOldVar,_, pln)
			pln.trigger = false
			if tonumber(vVar) < 0 then
				n = 0
				self.hour:SetDisabled(true)
				self.minute:SetDisabled(true)
				if self.ampm then
					self.ampm:SetDisabled(true)
				end
				self._enabled = false
				self._t:SetChecked( false )
			else
				self.hour:SetDisabled(false)
				self.minute:SetDisabled(false)
				if self.ampm then
					self.ampm:SetDisabled(false)
				end
				self._enabled = true
				self._t:SetChecked( true )
			end
			local time_str = StormFox2.Time.GetDisplay(vVar)
			local h,m,am = string.match(time_str, "(%d+):(%d+)%s?([PA]M)")
			pln.hour:SetValue(tonumber(h))
			local n = tonumber(m)
			pln.minute:SetValue(n)
			if pln.ampm then
				pln.ampm:SetValue(am=="AM" and "AM" or "PM")
			end
			pln.trigger = true
		end,self)
		self:InvalidateLayout(true)
	end
	function PANEL:PerformLayout(w, h)
		local x = 5
		local y = self._l:GetTall() + 2
		self._t:SetPos(5,y+2)
		x = x + 20
		self.hour:SetPos(x,y)
		x = x + self.hour:GetWide()
		self.dot:SetPos(x,y)
		x = x + self.dot:GetWide()
		self.minute:SetPos(x,y)
		x = x + self.minute:GetWide() + 5
		if self.ampm then
			self.ampm:SetPos(x,y)
			x = x + self.ampm:GetWide() + 5
		end
		local text, lines = wrapText(self._des, self:GetWide())
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		self._d:SetPos(x,y)

		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Time_Toggle", "", PANEL, "DPanel" )
end
-- Temp
do
	local PANEL = {}
	PANEL.Paint = empty
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		--self.Paint = empty
		local l = vgui.Create( "DLabel", self )
		local d = vgui.Create( "DLabel", self )
		local b = vgui.Create("DNumberWang", self)
		local s = vgui.Create("DLabel", self)
		
		b:SetWide(60)
		l:SetText("Unknown ConVar")
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		d:SetText("Unknown ConVar")
		d:SetColor(color_black)
		d:SetPos(90, l:GetTall() + 4)
		d:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		s:SetText(StormFox2.Temperature.GetDisplaySymbol())
		s:SetPos(70,l:GetTall() + 2)
		s:SetColor(color_black)
		s:SizeToContents()
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._d = d
		self._b = b
		self._s = s
		b.Up.DoClick = function( button, mcode ) 
			b:SetValue( b:GetValue() + b:GetInterval() )
			b:OnLoseFocus( )
		end
		b.Down.DoClick = function( button, mcode )
			b:SetValue( b:GetValue() - b:GetInterval() ) 
			b:OnLoseFocus( )
		end
	end
	function PANEL:SetConvar( sName )
		local con = GetConVar( "sf_" .. sName )
		self._l:SetText( "#sf_" .. sName )
		local nMin, nMax = con:GetMin(), con:GetMax()
		self._des = language.GetPhrase(con:GetHelpText() or "Unknown")

		if nMax then self._b:SetMax( nMax ) else self._b.m_numMax = nil	end
		if nMin then self._b:SetMin( nMin )	else self._b.m_numMin = nil	end
		local val = StormFox2.Temperature.Convert(nil,StormFox2.Temperature.GetDisplayType(),con:GetInt())
		self._b:SetValue( val )

		if StormFox2.Setting.IsGMSetting(sName) then
			self._b:SetDisabled( true )
		end

		function self._b:OnLoseFocus( )
			local num = tonumber(self:GetText()) or 0
			num = StormFox2.Temperature.Convert(StormFox2.Temperature.GetDisplayType(),nil,num)
			SetSFConVar( sName, num )
		end
		StormFox2.Setting.Callback(sName,function(vVar,vOldVar,_, pln)
			local val = StormFox2.Temperature.Convert(nil,StormFox2.Temperature.GetDisplayType(),tonumber(vVar) or 0)
			pln:SetValue(val)
		end,self._b)
	end
	function PANEL:PerformLayout(w, h)
		local text, lines = wrapText(self._des or "UNKNOWN", self:GetWide())
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text

		self._b:SetPos(5,self._l:GetTall() + 2)
		self._s:SetPos(68,self._l:GetTall() + 5)
		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)
	end
	PANEL.PaintOver = PaintOver
	derma.DefineControl( "SFConVar_Temp", "", PANEL, "DPanel" )
end
-- Ring
do
	local PANEL = {}
	local m_ring = Material("stormfox2/hud/hudring.png")
	local cCol1 = Color(55,55,55,55)
	local cCol2 = Color(55,55,255,105)
	local seg = 40
	function PANEL:SetColor(r,g,b,a)
		self.cCol2 = (r and g and b) and Color(r,g,b,a or 105) or r
	end
	function PANEL:Init()
		self._val = 1
		self._off = 0.05
		self.cCol1 = cCol1
		self.cCol2 = cCol2
	end
	function PANEL:SetValue(nNum)
		self._val = math.Clamp(nNum, 0, 1)
		self:RebuildPoly()
	end
	function PANEL:SetText(sText)
		self._text = sText
	end
	function PANEL:RebuildPoly()
		local pw, ph = self:GetWide(), self:GetTall()
		local x,y = pw / 2, ph / 2
		local polyMul = 1.2
		local radius = math.min(pw, ph) / 2 * polyMul
		local mul2 = 2 / polyMul

		-- Generate poly
		self._poly = {}
		local seg = 40
		table.insert( self._poly, { x = x, y = y, u = 0.5, v = 0.5 } )
		local n = self._val * seg
		for i = 0, n do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( self._poly, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / mul2 + 0.5, v = math.cos( a ) / mul2 + 0.5 } )
		end
		local a = math.rad( ( n / seg ) * -360 )
		table.insert( self._poly, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / mul2 + 0.5, v = math.cos( a ) / mul2 + 0.5 } )
		table.insert( self._poly, { x = x, y = y, u = 0.5, v = 0.5 } )
	end
	function PANEL:PerformLayout(pw, ph)
		self:RebuildPoly()
	end
	function PANEL:Paint(w,h)
		if self._text then
			local td = string.Explode("\n",self._text)
			for k,v in ipairs(td) do
				local n = k - 1
				draw.SimpleText(v, "DermaDefault", w / 2, h / 2 + n * 12 - (#td - 1) * 6, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			draw.SimpleText(self._val, "DermaDefault", w / 2, h / 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		if not self._poly then return end
		surface.SetMaterial(m_ring)
		surface.SetDrawColor(self.cCol1)
		surface.DrawTexturedRect(self._x or 0,self._y or 0,self._w or w,self._h or h)
		surface.SetDrawColor(self.cCol2)
		surface.DrawPoly(self._poly)
	end
	derma.DefineControl( "SF_HudRing", "", PANEL, "DPanel" )
end
-- Double Slider
do
	local PANEL = {}
	local function paintKnob(self,x, y) -- Skin doesn't have x or y pos
		local skin = self:GetSkin()
		if ( self:GetDisabled() ) then	return skin.tex.Input.Slider.H.Disabled( x, y, 15, 15 ) end
		if ( self.Depressed ) then
			return skin.tex.Input.Slider.H.Down( x, y, 15, 15 )
		end
		if ( self.Hovered ) then
			return skin.tex.Input.Slider.H.Hover( x, y, 15, 15 )
		end
		skin.tex.Input.Slider.H.Normal( x, y, 15, 15 )
	end
	AccessorFunc( PANEL, "m_fSlide2X", "Slide2X" )
	AccessorFunc( PANEL, "m_fSlideX", "SlideX" )
	AccessorFunc( PANEL, "m_max", "Max" )
	AccessorFunc( PANEL, "m_min", "Min" )
	AccessorFunc( PANEL, "m_fDecimal", "Decimals" )
	function PANEL:Init()
		self:SetSlideX(1)
		self:SetSlide2X(0)
		self:SetWide(200)
		self:SetMax(1)
		self:SetMin(0)
		self:SetText("")
		self:SetDark(true)
		self:SetDecimals(2)
	end
	--Derma_Hook( PANEL, "Paint2", "Paint", "NumSlider" )
	--function PANEL:GetNotchColor()
--		return color_white
--	end
	function PANEL:GetRange()
		return self.m_max - self.m_min
	end
	function PANEL:GetNotches()
		return math.floor(self:GetRange() / 4)
	end
	function PANEL:GetNotchColor()
		return b_alpha
	end
	function PANEL:Paint( w, h )
		-- GetNotchColor
		local skin = self:GetSkin()
		skin:PaintNumSlider(self,w,h)
		--self:Paint2(w,h)
		local sw = w - 15
		paintKnob(self,sw * self.m_fSlideX,0)
		paintKnob(self,sw * self.m_fSlide2X,0)
		surface.SetDrawColor(color_white)
	end
	function PANEL:SetSlideX( i )
		self.m_fSlideX = math.Clamp(math.max(i, self.m_fSlide2X or 0), 0, 1)
	end
	function PANEL:SetSlide2X( i )
		self.m_fSlide2X = math.Clamp( math.min(i, self.m_fSlideX or 1) , 0, 1)
	end
	function PANEL:OnDepressed()
		local w_f = (self:LocalCursorPos() - 7) / (self:GetWide() - 15)
		w_f = math.Clamp(w_f, 0, 1)
		self._knob = self.SetSlideX
		if self.m_fSlideX == self.m_fSlide2X then -- They're equal
			if w_f < self.m_fSlideX then
				self._knob = self.SetSlide2X
			end
		else
			local mp = (self.m_fSlideX + self.m_fSlide2X) / 2
			if w_f < mp then
				self._knob = self.SetSlide2X
			end
		end
	end
	function PANEL:SetMinVar( f )
		local r = self:GetMax() - self:GetMin()
		self:SetSlide2X( (f - self:GetMin()) / r )
	end
	function PANEL:SetMaxVar( f )
		local r = self:GetMax() - self:GetMin()
		self:SetSlideX( (f - self:GetMin()) / r )
	end
	function PANEL:GetMinVar()
		local r = self.m_max - self.m_min
		return self.m_min + r * self.m_fSlide2X
	end
	function PANEL:GetMaxVar()
		local r = self.m_max - self.m_min
		return self.m_min + r * self.m_fSlideX
	end
	function PANEL:OnValueChanged( min, max )
	end
	function PANEL:Think()
		if self._wdown and not self:IsDown() then -- We let go
			if not self.OnValueChanged then return end
			self:OnValueChanged( self:GetMinVar(), self:GetMaxVar() )
			self._wdown = false
		elseif self:IsDown() and self._knob then
			local w_f = (self:LocalCursorPos() - 7) / (self:GetWide() - 15)
			w_f = math.Round(math.Clamp(w_f, 0, 1), self.m_fDecimal)
			self._knob(self, w_f)
			self._wdown = true
		end		
	end
	local function conFunc(self, min, max)
		if self._conMin:GetFloat() ~= min then
			SetSFConVar(self._conMin:GetName(), min)
		end
		if self._conMax:GetFloat() ~= max then
			SetSFConVar(self._conMax:GetName(), max)
		end
	end
	function PANEL:SetConvar( sMinName, sMaxName )
		local conMi = GetConVar( "sf_" .. sMinName )
		local conMa = GetConVar( "sf_" .. sMaxName )
		self._conMax = conMa
		self._conMin = conMi
		self:SetMax( conMa:GetMax() or 1 )
		self:SetMin( conMi:GetMin() or 0 )
		self:SetMaxVar( conMa:GetFloat() )
		self:SetMinVar( conMi:GetFloat() )

		if StormFox2.Setting.IsGMSetting(sMinName) or StormFox2.Setting.IsGMSetting(sMaxName) then
			self:SetDisabled( true )
		end
		
		self.OnValueChanged = conFunc	
		StormFox2.Setting.Callback(sMinName,function(vVar,vOldVar,_, pln)
			pln:SetMinVar( vVar )
		end,self)
		StormFox2.Setting.Callback(sMaxName,function(vVar,vOldVar,_, pln)
			pln:SetMaxVar(vVar)
		end,self)
	end
	derma.DefineControl( "SF_DDSlider", "", PANEL, "DButton" )
end
-- Double num slider
do
	local PANEL = {}
	function PANEL:Init()
		self:DockMargin(5,0,10,0)
		local l = vgui.Create( "DLabel", self )
		local d = vgui.Create( "DLabel", self )
		l:SetText("Unknown ConVar")
		l:SetColor(color_black)
		l:SetFont("DermaDefaultBold")
		l:SizeToContents()
		d:SetText("Unknown ConVar")
		d:SetColor(color_black)
		d:SetPos(5, l:GetTall() + 2)
		d:SizeToContents()
		l:InvalidateLayout(true)
		l:Dock(TOP)
		self:SetTall(l:GetTall() + 34)
		self._l = l
		self._d = d

		local n_min = vgui.Create("DTextEntry", self)
		local b = vgui.Create("SF_DDSlider", self)
		local n_max = vgui.Create("DTextEntry", self)
		n_min:SetNumeric(true)
		n_max:SetNumeric(true)
		n_min:SetWide(46)
		n_max:SetWide(46)
		n_min:SetPaintBackground( false )
		n_max:SetPaintBackground( false )
		self._b = b
		self.n_min = n_min
		self.n_max = n_max
				
		b:SetPos(5, self._l:GetTall())
		b:SetWide(300)
		self._dw = 300
		b:SetDecimals( 2 )
		self._d:SetPos(305, self._l:GetTall() + 2)
		n_min.sl = self
		n_max.sl = self
		function n_min:Think()
			if not self.sl:IsDown() then return end
			local var = self.sl:GetMinVar()
			self:SetText( math.Round(var, self.sl:GetDecimals()) )
		end
		function n_max:Think()
			if not self.sl:IsDown() then return end
			local var = self.sl:GetMaxVar()
			self:SetText( math.Round(var, self.sl:GetDecimals()) )
		end
	end
	function PANEL:SetMin( f )
		self._b:SetMin( f )
	end
	function PANEL:GetMin()
		self._b:GetMin()
	end
	function PANEL:SetMax( f )
		self._b:SetMax( f )
	end
	function PANEL:IsDown()
		return self._b:IsDown()
	end
	function PANEL:GetMax()
		self._b:GetMax()
	end
	function PANEL:GetMinVar()
		if self._temp then
			return StormFox2.Temperature.Convert(nil, StormFox2.Temperature.GetDisplayType(),self._b:GetMinVar())
		end
		return self._b:GetMinVar()
	end
	function PANEL:GetMaxVar()
		if self._temp then
			return StormFox2.Temperature.Convert(nil, StormFox2.Temperature.GetDisplayType(),self._b:GetMaxVar())
		end
		return self._b:GetMaxVar()
	end
	function PANEL:GetDecimals()
		return self._b:GetDecimals()
	end
	function PANEL:SetDecimals( i )
		return self._b:SetDecimals( i )
	end
	
	PANEL.Paint = empty
	function PANEL:PerformLayout(w,h)
		local text, lines = wrapText(self._des or "UNKNOWN", self:GetWide() - self._dw)
		self._d:SetText(text)
		self._d:SizeToContents()
		self._desr = text
		local h = math.max(10 + lines * 20, 44)
		self:SetTall(h)

		self.n_min:SetPos( 0, h - 32)
		self._b:SetPos(self.n_min:GetWide(),h - 32)
		local sw = 300 - self.n_min:GetWide() - self.n_max:GetWide()
		self._b:SetWide( sw )
		self.n_max:SetPos( sw + self.n_min:GetWide(), h - 32)
	end
	function PANEL:SetConvar( sMinName, sMaxName,_type, sDesc )
		self._temp = _type == "temperature"
		self.n_min._temp = self._temp
		self.n_max._temp = self._temp
		if self._temp then
			makeTempDisplay(self.n_min)
			makeTempDisplay(self.n_max)
		end			
		self._l:SetText( sDesc and sDesc or "#sf_" .. sMinName )
		local minCon = GetConVar( "sf_" .. sMinName)
		local maxCon = GetConVar( "sf_" .. sMaxName)
		self._des = language.GetPhrase(sDesc and sDesc .. ".desc" or minCon:GetHelpText() or "Unknown")
		local minVal = minCon:GetFloat()
		local maxVal = maxCon:GetFloat()
		if self._temp then
			minVal = StormFox2.Temperature.Convert(nil,StormFox2.Temperature.GetDisplayType(),minVal)
			maxVal = StormFox2.Temperature.Convert(nil,StormFox2.Temperature.GetDisplayType(),maxVal)
		end
		self.n_min:SetText(math.Round(minVal, self:GetDecimals()))
		self.n_max:SetText(math.Round(maxVal, self:GetDecimals()))
		self.n_min._con = minCon
		self.n_max._con = maxCon
		self._b:SetConvar( sMinName, sMaxName )
		self._b.ConVarChanged = ConVarChanged
		self.n_min.OnValueChange = function( self, val )
			if self._temp then
				val = StormFox2.Temperature.Convert(StormFox2.Temperature.GetDisplayType(),nil,val)
			end
			SetSFConVar(self._con:GetName(), val)
		end
		self.n_max.OnValueChange = function( self, val )
			if self._temp then
				val = StormFox2.Temperature.Convert(StormFox2.Temperature.GetDisplayType(),nil,val)
			end
			SetSFConVar(self._con:GetName(), val)
		end
		StormFox2.Setting.Callback(sMinName,function(vVar,vOldVar,_, pln)
			if self._temp then
				vVar = StormFox2.Temperature.Convert(nil, StormFox2.Temperature.GetDisplayType(),vVar)
			end
			pln:SetText(math.Round(vVar, pln.sl:GetDecimals()))
		end,self.n_min)
		StormFox2.Setting.Callback(sMaxName,function(vVar,vOldVar,_, pln)
			if self._temp then
				vVar = StormFox2.Temperature.Convert(nil, StormFox2.Temperature.GetDisplayType(),vVar)
			end
			pln:SetText(math.Round(vVar, pln.sl:GetDecimals()))
		end,self.n_max)
		if StormFox2.Setting.IsGMSetting(sMinName) or StormFox2.Setting.IsGMSetting(sMaxName) then
			self.n_min:SetDisabled( true )
			self.n_max:SetDisabled( true )
		end
	end

	derma.DefineControl( "SF_DDSliderNum", "", PANEL, "DPanel" )
end
-- World Display
do
	local owm = Material("stormfox2/hud/openweather.png")
	local PANEL = {}
	AccessorFunc( PANEL, "m_lat", "Lat" )
	AccessorFunc( PANEL, "m_lon", "Lon" )
	AccessorFunc( PANEL, "m_zoom","Zoom" )
	local w_map = Material("stormfox2/hud/world.png")
	local c = Color(0,0,0,55)
	function PANEL:Init()
		self._map = vgui.Create("DPanel", self)
		self:SetLat(StormFox2.Setting.Get("openweathermap_lat", 52.6139095))
		self:SetLon(StormFox2.Setting.Get("openweathermap_lon", -2.0059601))
		self:SetSize(400, 300)
		self:SetZoom(3)
		self._range = 1
		
		self._map._s = self
		function self._map:Paint(w,h)
			if self._s:GetDisabled() then return end
			surface.SetDrawColor(color_white)
			surface.SetMaterial( w_map )
			surface.DrawTexturedRect(0,0,w,h)
			local x = 0.5 + ( self._s:GetLon()) / 360
			local y = 0.5 - ( self._s:GetLat()) / 180
			local ws = math.ceil(w / 360)
			local hs = math.ceil(h / 180)
			surface.SetDrawColor(color_black)
			local xx,yy = x * w - ws / 2, y * h - hs / 2
			surface.DrawOutlinedRect(xx,yy, ws, hs)
			surface.SetDrawColor(c)
			c.a = 150 + math.sin(SysTime() * 10) * 50
			local xT = math.max(1, ws / 4)
			local yT = math.max(1, hs / 4)
			-- X
			surface.DrawRect(0, 		yy + hs * .5 - xT / 2, xx, yT)
			surface.DrawRect(xx + ws, 	yy + hs * .5 - xT / 2, w - xx - ws, yT)
			--Y
			surface.DrawRect(xx + ws * 0.5 - yT / 2, 0, xT, yy)
			surface.DrawRect(xx + ws * 0.5 - yT / 2, yy + hs, xT, h - yy - hs)
		end
		self:SetMouseInputEnabled( true )
		StormFox2.Setting.Callback("openweathermap_lat",function(vVar,_,_, self)
			self:SetLat( tonumber(vVar) )
			self:ReSize()
		end,self)
		StormFox2.Setting.Callback("openweathermap_lon",function(vVar,_,_, self)
			self:SetLon( tonumber(vVar) )
			self:ReSize()
		end,self)
	end
	function PANEL:ReSize()
		local z = self:GetZoom() * 0.5
		local w,h = 1617 * z, 808 * z
		if w < self:GetWide() or h < self:GetTall() then
			z = math.max(self:GetWide() / 1617, self:GetTall() / 808)
			w = 1617 * z
			h = 808 * z
		end
		self._map:SetSize(w, h)
		local x,y = 0.5 + ( self:GetLon()) / 360, 0.5 - ( self:GetLat() ) / 180
		local px,py = -w * x + self:GetWide() / 2, -h * y + self:GetTall() / 2
		px = math.Clamp(px, -w, 0)
		py = math.Clamp(py, -h, 0)
		
		self._map:SetPos(px,py)
	end
	function PANEL:OnMouseWheeled( sD )
		local z = self:GetZoom() + sD / 2
		self:SetZoom( math.Clamp(z, 1, 28) )
		self:ReSize()
		return true
	end
	function PANEL:PerformLayout()
		self:ReSize()
	end
	function PANEL:Paint(w,h)
		if self:GetDisabled() then return end
		surface.SetDrawColor(color_white)
		surface.SetMaterial( w_map )
		surface.DrawTexturedRectUV(0,0,w,h,0,0,0.01,0.01)
	end
	function PANEL:PaintOver(w,h)
		surface.SetDrawColor(color_black)
		surface.SetMaterial(owm)
		local tw = w / 5
		local th = tw * 0.42
		surface.DrawTexturedRect(0, h - th, tw, th)
	end
	derma.DefineControl( "SF_WorldMap", "", PANEL, "DPanel" )
end

-- Day Display
do
	local function displayLayout(self, width, height )
		-- Temp changes
		local tmin,tmax = StormFox2.Setting.Get("min_temp",-10), StormFox2.Setting.Get("max_temp",20)
		local tsize = (tmax - tmin)
		self.temp_size = height / 20
		self.temp_y = FindPercent(0, tmax, tmin)
		if self.last_temp then
			self.TempY = FindPercent(self.last_temp, tmax, tmin) * height
		else
			self.TempY = 0
		end
		self.TempY2 = FindPercent(self.temp, tmax, tmin) * height
		self.TempY3 = FindPercent(self.next_temp, tmax, tmin) * height
	end
	local b_c = Color(255,255,255,55)
	local b_c2 = Color(255,255,255,5)
	local r_c = Color(155,155,255,25)
	local function displayPaint(self, w, h)
		-- Draw bar
		surface.SetDrawColor(b_c)
		surface.DrawLine(0,self.temp_y * h, w, self.temp_y * h)
		surface.SetDrawColor(b_c2)
		for y = self.temp_y * h, 0, -20 do
			surface.DrawLine(0,y, w, y)
		end
		for y = self.temp_y * h, h, 20 do
			surface.DrawLine(0,y, w, y)
		end
		-- Draw "rain"
		if self.weather and self.weather.Name == "Rain" then
			surface.SetDrawColor(r_c)
			local h2 = self.weather_a * h
			surface.DrawRect(0, h - h2, w, h2)
		end
		if not self.TempY or not self.TempY2 or not self.TempY3 then return end
		if self.TempY < self.TempY2 then -- Down
			surface.SetDrawColor(color_white)
		else							-- Up
			surface.SetDrawColor(Color(0,255,0))
		end
		surface.DrawLine(-w / 2, self.TempY, w / 2, self.TempY2 )
		if self.TempY2 < self.TempY3 then -- Blue
			surface.SetDrawColor(color_white)
		else							-- Up
			surface.SetDrawColor(Color(0,255,0))
		end
		surface.DrawLine(w / 2, self.TempY2, w * 1.5, self.TempY3)
	end

	local PANEL = {}
	function PANEL:Init()
		self:SetWide(60)
		self.icon = vgui.Create("DImage", self)
		self.icon:Dock(TOP)
		self.icon:DockMargin(15,15,15,5)
		self.icon:SetMaterial( Material("gui/noicon.png") )
		self.temp = vgui.Create("DPanel", self)
		self.temp:Dock(TOP)
		self.temp.text = ""
		self.time = ""
		self.temp.desc = "Unknown"
		self.temp:SetTall(30)
		function self.temp:Paint(w,h)
			draw.SimpleText(self.text, "DermaDefault",w / 2,0,color_white,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.desc, "DermaDefault",w / 2,h/2,color_white,TEXT_ALIGN_CENTER)
		end
		self.display = vgui.Create("DPanel", self)
		self.display:Dock(FILL)
		self.display.PerformLayout = displayLayout
		self.display.Paint = displayPaint
		self.time = vgui.Create("DPanel", self)
		self.wind = vgui.Create("DPanel", self)
		self.wind:Dock(BOTTOM)
		self.time:Dock(BOTTOM)
		self.time:SetTall(30)
		function self.time:Paint(w,h)
			draw.SimpleText(self.text, "DermaDefault",w / 2,h / 4,color_white,TEXT_ALIGN_CENTER)
		end
		function self.wind:Paint(w,h)
			draw.SimpleText(self.text, "DermaDefault",w / 2,h / 4,color_white,TEXT_ALIGN_CENTER)
		end
	end
	function PANEL:SetData(time, last_data, data, next_data, unixtime )
		self.data = data
		self.temp.text = math.Round(StormFox2.Temperature.GetDisplay(data.Temperature), 1) .. StormFox2.Temperature.GetDisplaySymbol()
		
		self.display.last_temp 	= last_data and last_data.Temperature or 0
		self.display.next_temp 	= next_data and next_data.Temperature or data.Temperature
		self.display.temp 		= data.Temperature

		self.time.text = time and StormFox2.Time.GetDisplay(data.Time * 60) or unixtime
		self.wind.text = (data.Wind or 0) .. " m/s"
		self.weather = StormFox2.Weather.Get( data.Weather and data.Weather or "Clear" )
		self.display.weather = self.weather
		self.display.weather_a = data.Percent
		if self.weather then
			self.icon:SetMaterial(	self.weather.GetIcon(time or 720, data.Temperature or 20, data.Wind, data.Thunder, data.Percent))
			self.temp.desc = 		self.weather:GetName(time or 720, data.Temperature or 20, data.Wind, data.Thunder, data.Percent )
		end
	end


	function PANEL:PerformLayout(w, h)
		-- Icon
		self.icon:SetTall(w - 30)
	end

	function PANEL:Paint(w, h)

		-- self.desc
	end
	derma.DefineControl( "SF_WeatherHour", "", PANEL, "DPanel" )
end

-- Weather Display
do
	local PANEL = {}
	local col = Color(26,41,72, 255)
	local mat = Material("vgui/loading-rotate")
	function PANEL:Init()
		-- StormFox2.WeatherGen.GetData()
		self:SetSize( 400, 300 )
		self._Generated = false
		
		self._board = vgui.Create("DHorizontalScroller", self)
		self._board:Dock(FILL)
		self._board:DockPadding(0,0,0,24)
		self:Update()
		hook.Add("StormFox2.WeatherGen.ForcastUpdate", self, function()
			self.data = nil
			self:Update()
		end)
	end
	function PANEL:Update()
		if not StormFox2.WeatherGen then return end
		local json = StormFox2.WeatherGen.GetForcast()
		if not json or #json < 1 then return end
		self.data = json
		for _, v in ipairs( self._board.Panels ) do
			v:Remove()
		end
		local time = StormFox2.Time.Get()
		for i, data in ipairs( json ) do
			local n
			if i <= 8 then
				if json.unix_stamp then
					if data.Unix < os.time() then continue end
					self.firstUp = 1440
				else
					if (data.Time * 60) + 30 < time then continue end
					self.firstUp = math.min(data.Time * 60, self.firstUp or 1440)
				end
			end
			local v_hour = vgui.Create("SF_WeatherHour", self._board)
			v_hour:DockMargin(0,0,0,24)
			self._board:AddPanel(v_hour)
			--		SetData(time, last_data, data, next_data )
			local dn = math.floor(i / 8) * 24
			v_hour:SetData( data.Time, json[ i - 1 ],data, json[ i + 1 ], data.Unix and (os.date("%H",data.Unix) + dn) )
		end
		self._board:InvalidateLayout()
	end
	function PANEL:Think()
		if not self.data then
			self:Update()
		elseif self.firstUp and self.firstUp + 30 <= StormFox2.Time.Get() then
			self.firstUp = nil
			self:Update()
		end
	end
	function PANEL:Paint(w,h)
		surface.SetDrawColor(col)
		surface.DrawRect(0, 0, w,h)
	end
	function PANEL:PaintOver(w,h)
		if not self.data then
			surface.SetMaterial(mat)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectRotated(w / 2, h / 2, 50, 50, SysTime() * 300 % 360)
			surface.SetFont("SF_Menu_H2")
			local t = niceName(language.GetPhrase("loading"))
			t = t .. string.rep(".", CurTime() % 4)
			local tw,th = surface.GetTextSize( t )
			surface.SetTextColor(color_white)
			surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2 - 40)
			surface.DrawText(t)
		end
	end
	derma.DefineControl( "SF_WeatherMap", "", PANEL, "DPanel" )
end
-- Menu
do
	local function empty() end
	local function switch(sName, tab, buttons, sCookie)
		sName = string.lower(sName)
		local pnl
		for k, v in pairs(tab) do
			if k == sName then
				v:Show()
				pnl = v
			else
				v:Hide()
			end
		end
		if not IsValid(pnl) or pnl:GetDisabled() then
			pnl = tab["start"]
			sName = "start"
			if IsValid(pnl) then
				pnl:Show()
			end
		end
		for k,v in pairs(buttons) do
			v._selected = k == sName
		end
		if sCookie then
			cookie.Set(sCookie, sName)
		end
		return pnl
	end
	local function addSetting(sName, pPanel, _type, _desc)
		local setting
		if type(sName) == "table" then
			setting = vgui.Create("SF_DDSliderNum", pPanel)
			setting:SetConvar(sName[1],sName[2], _type, _desc)
			return setting
		end
		if type(_type) == "table" then
			setting = vgui.Create("SFConVar_Enum", pPanel)
		elseif _type == "boolean" then
			setting = vgui.Create("SFConVar_Bool", pPanel)
		elseif _type == "float" then
			setting = vgui.Create("SFConVar_Float", pPanel)
		elseif _type == "special_float" then
			setting = vgui.Create("SFConVar_Float_Toggle", pPanel)
		elseif _type == "number" then
			setting = vgui.Create("SFConVar_Number", pPanel)
		elseif _type == "time" then
			setting = vgui.Create("SFConVar_Time", pPanel)
		elseif _type == "string" then
			setting = vgui.Create("SFConVar_String", pPanel)
		elseif _type == "time_toggle" then
			setting = vgui.Create("SFConVar_Time_Toggle", pPanel)
		elseif _type == "temp" or _type == "temperature" then
			setting = vgui.Create("SFConVar_Temp", pPanel)
		elseif _type == "double_number" then
			setting = vgui.Create("SF_DDSliderNum", pPanel)
			setting:SetConvar(sName[1],sName[2], _type, _desc)
			return setting
		else
			StormFox2.Warning("Unknown Setting Variable: " .. sName .. " [" .. tostring(_type) .. "]")
			return
		end
		if not setting then
			StormFox2.Warning("Unknown Setting Variable: " .. sName .. " [" .. tostring(_type) .. "]")
			return
		end
		--local setting = _type == "boolean" and vgui.Create("SFConVar_Bool", board) or  vgui.Create("SFConVar", board)
		setting:SetConvar(sName, _type, _desc)
		return setting
	end
	local col = {Color(230,230,230), color_white}
	local col_dis = Color(0,0,0,55)
	local col_dis2 = Color(0,0,0,55)
	local bh_col = Color(55,55,55,55)
	local sb_col = Color(91,155,213)

	local icon = Material("icon16/zoom.png")
	local icon_c = Color(255,255,255,180)

	local s = 20
	local side_button = function(self, w, h)
		if self:IsHovered() and not self:GetDisabled() then
			surface.SetDrawColor(bh_col)
			surface.DrawRect(0,0,w,h)
		end

		surface.SetDrawColor(self:GetDisabled() and col_dis or color_black)
		surface.SetMaterial(self.icon)
		surface.DrawTexturedRect(24 - s / 2, (h - s) / 2, s,s)

		local t = self.text or "ERROR"
		surface.SetFont("DermaDefault")
		local tw,th = surface.GetTextSize( t )
		surface.SetTextColor(self:GetDisabled() and col_dis2 or color_black)
		surface.SetTextPos(48, h / 2 - th / 2)
		surface.DrawText(t)

		if self._selected then
			surface.SetDrawColor(sb_col)
			surface.DrawRect(4,4,4,h - 8)
		end
	end

	local t_mat = "icon16/font.png"
	local s_mat = "icon16/cog.png"
	local s = 60
	local b_mat = Material("stormfox2/hud/menu/beta.png")
	local n_vc = Color(55,255,55)
	local n_bm = Material("vgui/notices/undo")

	local PANEL = {}
	function PANEL:Init()
		-- BG
		self:SetTitle("")
		function self:SetTitle( str )
			self._title = str
		end
		self:SetSize(64 * 11, 500)
		self:Center()
		self:DockPadding(0,24,0,0)
		function self:Paint(w, h)
			surface.SetDrawColor( col[2] )
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor( col[1] )
			if self.p_left then
				surface.DrawRect(0,0,self.p_left:GetWide(),24)
			else
				surface.DrawRect(0,0,w,24)
			end

			surface.SetDrawColor(55,55,55,255)
			surface.DrawRect(0, 0, w, 24)

			local t = self._title or "Window"
			surface.SetFont("DermaDefault")
			local tw,th = surface.GetTextSize( t )
			surface.SetTextColor(color_white)
			surface.SetTextPos(5, 12 - th / 2)
			surface.DrawText(t)
		end
		-- Left panel
		local p_left = vgui.Create("DPanel", self)
		self.p_left = p_left
		p_left:SetWide(180)
		p_left:Dock( LEFT )
		p_left:DockPadding(0,0,0,0)
		function p_left:Paint(w, h)
			surface.SetDrawColor( col[1] )
			surface.DrawRect(0,0,w,h)
		end
		-- Right panel
		local p_right = vgui.Create("DPanel", self)
		self.p_right = p_right
		p_right:Dock( FILL )
		p_right.Paint = empty
		p_right.sub = {}
	end
	function PANEL:CreateLayout( tabs, setting_list )
		local p = self
		local p_right = self.p_right
		local p_left = self.p_left
		p_right.sub = {}
	
		for k,v in ipairs( tabs ) do
			local p = vgui.Create("DScrollPanel", self.p_right)
			-- Draw beta
			function p:PaintOver(w,h)
				surface.SetMaterial(b_mat)
				surface.SetDrawColor(color_white)
				if self.VBar.Enabled then
					surface.DrawTexturedRect(w - s - self.VBar:GetWide(), 0, s, s)
				else
					surface.DrawTexturedRect(w - s, 0, s, s)
				end
			end
			p:Dock(FILL)
			self.p_right.sub[string.lower(v[1])] = p
			p:Hide()
		end
		p_right.sub["start"]._isstart = true
	
		p_left.buttons = {}
		-- Add Start
		local b = vgui.Create("DButton", p_left)
		b:Dock(TOP)
		b:SetTall(40)
		b:SetText("")
		b.icon = tabs[1][3]
		b.text = niceName( language.GetPhrase(tabs[1][2]) )
		b.Paint = side_button
		p_left.buttons["start"] = b
		function b:DoClick()
			switch("start", p_right.sub, p_left.buttons, p._cookie)
		end
	
		-- Add search bar
		local sp = vgui.Create("DPanel", p_left)
		local search_tab = {}
		sp:Dock(TOP)
		sp:SetTall(40)
		function sp:Paint() end
		sp.searchbar = vgui.Create("DTextEntry",sp)
		sp.searchbar:SetText("")
		sp.searchbar:Dock(TOP)
		sp.searchbar:SetHeight(20)
		sp.searchbar:DockMargin(4,10,4,0)
		function sp.searchbar:OptionSelected( sName, page, vguiObj )
			local board = switch(page, p_right.sub, p_left.buttons, p._cookie)
			if vguiObj then
				vguiObj.dMark = 2 + CurTime()
				if board then
					board:ScrollToChild(vguiObj)
				end
				timer.Simple(1, function() vguiObj:RequestFocus() end )
			end
			self:SetText("")
			self:KillFocus()
		end
		function sp.searchbar:OnChange( )
			local val = self:GetText()
			local tab = {}
			if self.result and IsValid(self.result) then
				self.result:Remove()
			end
			local OnlyTitles = val == ""
			self.result = vgui.Create("DMenu")
			function self.result:OptionSelected( pnl, text )
				if not search_tab[pnl.sName] then return end
				sp.searchbar:OptionSelected( text, search_tab[pnl.sName][1], search_tab[pnl.sName][2] )
			end
			for sName, v in pairs( search_tab ) do
				local phrase = language.GetPhrase( sName )
				if string.find(string.lower(phrase),string.lower(val)) then
					if OnlyTitles and v[3]~=t_mat then continue end
					table.insert(tab, {sName, v[1], v[2]})
					local op = self.result:AddOption( phrase )
					if v[3] then
						op:SetIcon(v[3])
					end
					op.sName = sName
				end
			end
			local x,y = self:LocalToScreen(0,0)
			self.result:Open(x, y + self:GetTall())
		end
		function sp.searchbar:OnGetFocus()
			self:OnChange( )
		end
		function sp.searchbar:OnLoseFocus()
			if not self.result then return end
			self.result:Remove()
			self.result = nil
		end
		function sp.searchbar:Paint(w,h)
			surface.SetDrawColor(color_white)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(color_black)
			surface.DrawOutlinedRect(0,0,w,h)
			local text = self:GetText()
			if self:IsEditing() then
				if math.Round(SysTime() * 2) % 2 == 0 then
					text = text .. "|"
				end
			elseif #text < 1 then
				text = "#searchbar_placeholer"
			end
			surface.SetMaterial(icon)
			surface.SetDrawColor(icon_c)
			local s = 4
			surface.DrawTexturedRect(w - h + s / 2, s / 2, h - s, h - s)
			draw.DrawText(text, "DermaDefault", 5, 2, color_black, TEXT_ALIGN_BOTTOM)
		end
		for i = 2, #tabs do
			v = tabs[i]
			local b = vgui.Create("DButton", p_left)
			b:Dock(TOP)
			b:SetTall(40)
			b:SetText("")
			b.icon = v[3]
			b.text = niceName( language.GetPhrase(tabs[i][2]) )
			b.sTab = v[1]
			b.Paint = side_button
			p_left.buttons[string.lower(tabs[i][1])] = b
			function b:DoClick()
				switch(self.sTab, p_right.sub,p_left.buttons, p._cookie)
			end
		end
		
		-- Move changelog down
		if p_left.buttons["changelog"] then
			p_left.buttons["changelog"]:Dock(BOTTOM)
			p_left.buttons["changelog"]:SetZPos(1)
		end

		-- Add workshop button
		local b = vgui.Create("DButton", p_left)
		b:Dock(BOTTOM)
		b:SetTall(40)
		b:SetText("")
		b.icon = tabs[1][3]
		b.text = "Workshop"
		b.Paint = side_button
		b.r = 180
		if StormFox2.NewVersion() then
			function b:PaintOver(w,h)
				surface.SetDrawColor(color_white)
				surface.SetMaterial(n_bm)
				if self:IsHovered() then
					local dif = math.abs(math.AngleDifference(self.r, 0)) + 5
					self.r = (self.r + math.max(0.01,dif) * FrameTime() * 5) % 360
				else
					self.r = 180
				end
				surface.DrawTexturedRectRotated(w - 20, h / 2, 20, 20, self.r)
--					surface.DrawRect( - w,0,w,h - 1)
				draw.DrawText( StormFox2.NewVersion() , "SF_Menu_H2", w - 34 , h / 2 - 8, color_black, TEXT_ALIGN_RIGHT)
			end
		end
		p_left.buttons["workshop"] = b
		function b:DoClick()
			gui.OpenURL( StormFox2.WorkShopURL )
		end
		if not StormFox2.WorkShopURL then
			b:SetDisabled(true)
		end
	
		local used = {}
		function p:AddSetting( sName, group, _type, sDesc )
			if not group then 
				group = select(2, StormFox2.Setting.GetType(sName))
			end
			if not group then
				group = "misc"
			elseif not p_right.sub[group] then 
				group = "misc" 
			end
			local board = p_right.sub[group]
			return board:AddSetting( sName, _type, sDesc )
		end
		function p:MarkUsed( sName )
			used[sName] = true
		end
		for sBName, pnl in pairs(p_right.sub) do
			pnl.sBName = string.lower(sBName)
			pnl._other = false
			function pnl:AddSetting( sName, _type, sDesc )
				if self._other then
					self:AddTitle("#other", true)
					pnl._other = false
				end
				local mul = type( sName ) == "table"
				if not _type then
					_type = StormFox2.Setting.GetType(mul and sName[1] or sName)
				end
				local setting = addSetting(sName, self, _type, sDesc)
				if not setting then return end
				if not mul then
					if not search_tab["sf_" .. sName] or not self._isstart then
						search_tab["sf_" .. sName] = {self.sBName, setting, s_mat}
					end
					used[sName] = true
				else
					for k,v in ipairs(sName) do
						if not search_tab["sf_" .. v] or not self._isstart then
							search_tab["sf_" .. v] = {self.sBName, setting, s_mat}
						end
						used[v] = true
					end
				end
				--local setting = _type == "boolean" and vgui.Create("SFConVar_Bool", board) or  vgui.Create("SFConVar", board)
				setting:DockMargin(15,0,0,15)
				setting:Dock(TOP)
				self:AddItem(setting)
				return setting
			end
			function pnl:AddTitle( sName, bIgnoreSearch )
				local dL = vgui.Create("SFTitle", self)
				local text = niceName( language.GetPhrase(sName) )
				dL:SetText( text )
				dL:SetDark(true)
				dL:SetFont("SF_Menu_H2")
				dL:SizeToContents()
				dL:Dock(TOP)
				dL:DockMargin(5,self._title and 20 or 0,0,0)
				self._title = true
				self:AddItem(dL)
				if (not search_tab[text] or not self._isstart) and #sName > 0 and not bIgnoreSearch then
					search_tab[text] = {self.sBName, dL, t_mat}
				end
				return dL
			end
			function pnl:MarkUsed( sName )
				p:MarkUsed( sName )
			end
		end
		-- Make the layout
		for _,v in ipairs(tabs) do
			if not v[4] then continue end
			local b = p_right.sub[string.lower(v[1])]
			if not b then continue end
			v[4]( b )
		end
	
		-- Add all other settings
		for sBName, pnl in pairs(p_right.sub) do
			pnl._other = true
		end
		for _, sName in ipairs( setting_list ) do
			if used[sName] then continue end
			p:AddSetting( sName )
		end
		-- If there are empty setting-pages, remove them
		for sBName, pnl in pairs(p_right.sub) do
			local n = #pnl:GetChildren()[1]:GetChildren()
			if n > 0 then continue end
			local b = self.p_left.buttons[sBName]
			if IsValid(b) then
				b:SetDisabled(true)
			end
			local p = self.p_right.sub[string.lower(sBName)]
			if IsValid(p) then
				p:SetDisabled(true)
			end
		end
		-- Add space at bottom
		for sBName, pnl in pairs(p_right.sub) do
			pnl:AddTitle("")
		end
	end
	function PANEL:SetCookie( sCookie )
		self._cookie = sCookie
		local selected = cookie.GetString(sCookie, "start") or "start"
		if not self.p_right.sub[selected] then -- Unknown page, set it to "start"
			selected = "start"
		end
		switch(selected, self.p_right.sub,self.p_left.buttons, sCookie)
	end
	function PANEL:Select( str_page )
		switch(str_page, self.p_right.sub,self.p_left.buttons, self._cookie)
	end
	derma.DefineControl( "SF_Menu", "", PANEL, "DFrame" )
end