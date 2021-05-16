PLUGIN.name = "Global map"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then return end

local function darken(clr, amt)
  return Color(
	math.Clamp(clr.r - amt, 0, 255),
	math.Clamp(clr.g - amt, 0, 255),
	math.Clamp(clr.b - amt, 0, 255),
	clr.a
  )
end

local map_texture = Material("gmodz/map004.png")
local frame, frame_label = nil, nil
local objects = {}

local SIGNS = {
	"➕",
	"☢"
}

local map = {}
function map.Generate()
	-- Thanks Dakota0001

	local mapBoundsMax = select(2, game.GetWorld():GetModelBounds())
	local uptrace = util.TraceLine({
		start = vector_origin,
		endpos = vector_origin + Vector(0,0,mapBoundsMax.z),
		mask = MASK_NPCWORLDSTATIC
	}).HitPos

	local startpos = Vector(0, 0, uptrace.z)
	local endX, endY = Vector(mapBoundsMax.x, 0, 0), Vector(0, mapBoundsMax.y, 0)

	local rTrace = util.TraceLine({
		start = startpos,
		endpos = startpos + endY,
		mask = MASK_NPCWORLDSTATIC
	}).HitPos

	local lTrace = util.TraceLine({
		start = startpos,
		endpos = startpos - endY,
		mask = MASK_NPCWORLDSTATIC
	}).HitPos

	-- local fTrace = util.TraceLine({
		-- start = startpos,
		-- endpos = startpos + endX,
		-- mask = MASK_NPCWORLDSTATIC
	-- }).HitPos

	-- local bTrace = util.TraceLine({
		-- start = startpos,
		-- endpos = startpos - endX,
		-- mask = MASK_NPCWORLDSTATIC
	-- }).HitPos

	-- map.Center = (rTrace + lTrace + fTrace + bTrace) * 0.25
	-- map.Center.z = LocalPlayer():GetPos().z + 2500

	local MapSize = rTrace:Distance(lTrace) / 2

	map.SizeW = -MapSize
	map.SizeE = MapSize
	map.SizeS = -MapSize
	map.SizeN = MapSize

	map.SizeX = math.abs(map.SizeE + math.abs(map.SizeW))
	map.SizeY = math.abs(map.SizeN + math.abs(map.SizeS))

	startpos, endX, endY, MapSize = nil, nil, nil, nil
	rTrace, lTrace=nil,nil--, fTrace, bTrace = nil, nil, nil, nil
	uptrace, mapBoundsMax = nil, nil

	collectgarbage()
end

function map.ToScreen(pos, w, h)
	local x = (map.SizeW > 0 and pos.x + map.SizeE or pos.x - map.SizeW)
	local y = (map.SizeS > 0 and pos.y + map.SizeN or pos.y - map.SizeS)

	-- Map borders
	return math.Clamp(x / map.SizeX * w, 0, w), h - math.Clamp(y / map.SizeY * h, 0, h)
end

function map.ToWorld(x, y, w, h)
	x = x * map.SizeX / w
	y = y * map.SizeY / h

	x = (map.SizeW > 0 and x - map.SizeE or x + map.SizeW)
	y = (map.SizeS > 0 and y - map.SizeN or y + map.SizeS)

	return Vector(x, -y, 0)
end

concommand.Add("show_map", function()
	if (!map.SizeX) then map.Generate() end
	if IsValid(frame) then frame:Remove() end

	local panel_size = ScrH()
	local s = math.Round((tonumber(32) / 2160) * ScrH(), 0)
	local hs = s/2

	frame = vgui.Create'DFrame'
	frame:SetSize(panel_size, panel_size)
	frame:Center()
	frame:SetTitle("MAP")
	frame:MakePopup()

	frame.map = frame:Add("EditablePanel")
	frame.map:Dock(FILL)
	frame.map.Paint = function( self, w, h )
		local mx, my = self:CursorPos()

		surface.SetMaterial( map_texture )
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect( 0,0,w,h )

		x, y = map.ToScreen(LocalPlayer():GetPos(), w, h)

		--draw.RoundedBoxEx( 0, mx-hs, my-hs, s, s, color_white, false, true, false, true )

		local clr = Color(0, 255, 255, 255)

		frame:SetTitle(math.Clamp(mx, 0, w) .. ", " .. math.Clamp(my, 0, h))

		draw.SimpleTextOutlined("YOU", "MapFont", x, y-s, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		draw.SimpleTextOutlined(SIGNS[1], "MapFont", x, y, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)

		for k, v in ipairs(objects) do
			clr = v[2]
			x, y = map.ToScreen(v[3], w, h)
			local tw, th = surface.GetTextSize(SIGNS[1])
			if (self:MouseInRect(x, y, tw*0.5, th*0.5)) then
				clr = darken(clr, 50)
			end
			--local x1, y1 = map.ToScreen(LocalPlayer():GetPos(), w, h)
			--local dist = math.Round(math.Distance(x, y, x1, y1), 2)
			--if dist < 35 then
				draw.SimpleTextOutlined(v[1], "MapFont", x, y-s, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
				draw.SimpleTextOutlined(SIGNS[1], "MapFont", x, y, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			--end
		end
	end

	function frame.map:MouseInRect(x, y, w, h)
		local mx, my = self:CursorPos()
		return (mx >= x - w and mx <= (x + w) and my >= y - h and my <= (y + h))
	end

	function frame.map:OnCursorMoved(mx, my)
		if (input.IsMouseDown(MOUSE_LEFT)) then
			local w, h = self:GetSize()
			local current_index

			for k, v in ipairs(objects) do
				x, y = map.ToScreen(v[3], w, h)
				local tw, th = surface.GetTextSize(SIGNS[1])
				if (self:MouseInRect(x, y, tw, th)) then
					current_index = k
					break
				end
			end

			if (current_index) then
				objects[current_index][3] = map.ToWorld(mx, my, w, h)
			end
		end
	end

	function frame.map:OnMousePressed(code)
		if (code == MOUSE_RIGHT) then
			local w, h = self:GetSize()
			local current_index

			for k, v in ipairs(objects) do
				x, y = map.ToScreen(v[3], w, h)
				local tw, th = surface.GetTextSize(SIGNS[1])
				if (self:MouseInRect(x, y, tw, th)) then
					current_index = k
					break
				end
			end

			local dmenu = DermaMenu()
			local x, y = self:CursorPos()

			if (current_index) then
				dmenu:AddOption("Edit", function()
					if (IsValid(frame_label)) then frame_label:Remove() end
					local data = objects[current_index]

					frame_label = vgui.Create("ixMapSetLabel")
					frame_label:SetData(data[1], data[2], current_index)

					function frame_label:DoneClick(text, color, index)
						objects[index] = {text, color, map.ToWorld(x, y, w, h)} 
					end

					frame_label = nil
				end):SetImage("icon16/wand.png")
				dmenu:AddSpacer()
				dmenu:AddOption("Remove", function()
					table.remove(objects, current_index)
					current_index = nil
				end):SetImage("icon16/exclamation.png")
			elseif (!IsValid(frame_label)) then
				dmenu:AddOption("Label", function()
					frame_label = vgui.Create("ixMapSetLabel")
					function frame_label:DoneClick(text, color)
						objects[#objects+1] = {text, color, map.ToWorld(x, y, w, h)} 
					end
					frame_label = nil
				end):SetImage("icon16/attach.png")
			end

			dmenu:Open()
		end
	end
end)

function PLUGIN:LoadFonts()
	surface.CreateFont("MapFont", {
		font = "Jura",
		size = ScrW()*0.012,
		weight = 500,
	})

	map.Generate()

	objects = ix.data.Get("global_map", {})

	timer.Create("ixGlobalMap", 300, 0, function()
		ix.data.Set("global_map", objects)
	end)
end

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

	self.scroll = vgui.Create( "DScrollPanel", self )
	self.scroll:Dock(LEFT)

	for k, v in ipairs(SIGNS) do
		if k == 1 then continue end
		local btn = self.scroll:Add( "DButton" )
		btn:SetText(v)
		btn:Dock(TOP)
		btn:DockMargin(0, 0, 5, 5)
		btn.Paint = function(_, w, h)
			surface.SetDrawColor(192, 192, 192, 255)
			surface.DrawRect(0, 0, w, h)
		end
		btn.DoClick = function()
			self:SetData(v .. " " .. self.textEntry:GetValue())
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
		surface.SetDrawColor(255, 255, 255, 100)
		surface.DrawRect(0, 0, w, h)

		local x, y = w * 0.5, h / 2

		draw.SimpleTextOutlined(self.text_label, "MapFont", x, y-math.Round((tonumber(32) / 2160) * ScrH(), 0), self.color_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		draw.SimpleTextOutlined(SIGNS[1], "MapFont", x, y, self.color_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
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