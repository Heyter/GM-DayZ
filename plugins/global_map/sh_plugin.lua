PLUGIN.name = "Global map"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then return end

local draw, surface, TEXT_ALIGN_CENTER = draw, surface, TEXT_ALIGN_CENTER

ix.map = ix.map or {
	texture = Material("gmodz/global_map/rp_stalker_v2.png"),
	objects = {},
	gui = {
		map = nil,
		label = nil
	},
	signs = { "➕", "☢" },
	default_color = Color(0, 255, 255, 255)
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

	ix.map.iconSize = math.Round((tonumber(32) / 2160) * ScrH(), 0)

	-- pre-cache
	surface.SetFont("MapFont")
	local tw, th = surface.GetTextSize(ix.map.signs[1])

	ix.map.signSize = {tw*0.5, th*0.5}

	startpos, endX, endY, MapSize = nil, nil, nil, nil
	rTrace, lTrace = nil, nil--, fTrace, bTrace = nil, nil, nil, nil
	uptrace, mapBoundsMax = nil, nil
	tw, th = nil, nil

	collectgarbage()
end

function map.Save()
	timer.Create("ixGlobalMap", 5, 1, function()
		ix.data.Set("global_map", ix.map.objects)
	end)
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

function map.Open()
	if (!map.SizeX) then map.Generate() end
	if (IsValid(ix.map.gui.map)) then ix.map.gui.map:Remove() end

	local clr = nil

	local frame = vgui.Create('DFrame')
	ix.map.gui.map = frame

	frame:SetSize(ScrH(), ScrH())
	frame:Center()
	frame:SetTitle("MAP")
	frame:MakePopup()

	frame.OnKeyCodeReleased = function(t, keyCode)
		if (keyCode == KEY_F2) then
			ix.map.gui.map = nil
			t:Remove()
		end
	end

	frame.map = frame:Add("EditablePanel")
	frame.map:Dock(FILL)
	frame.map.Paint = function( self, w, h )
		--local mx, my = self:CursorPos()

		surface.SetMaterial(ix.map.texture)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(0, 0, w, h)

		x, y = map.ToScreen(LocalPlayer():GetPos(), w, h)

		-- hs = ix.map.iconSize/2
		--draw.RoundedBoxEx( 0, mx-hs, my-hs, s, s, color_white, false, true, false, true )

		clr = ix.map.default_color

		--frame:SetTitle(math.Clamp(mx, 0, w) .. ", " .. math.Clamp(my, 0, h))

		draw.SimpleTextOutlined("YOU", "MapFont", x, y - ix.map.iconSize, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		draw.SimpleTextOutlined(ix.map.signs[1], "MapFont", x, y, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)

		for k, v in ipairs(ix.map.objects) do
			clr = v[2]
			x, y = map.ToScreen(v[3], w, h)
			if (self:MouseInRect(x, y, ix.map.signSize[1], ix.map.signSize[2])) then
				clr = Color(clr.r, clr.g, clr.b):Darken(25)
			end
			--local x1, y1 = map.ToScreen(LocalPlayer():GetPos(), w, h)
			--local dist = math.Round(math.Distance(x, y, x1, y1), 2)
			--if dist < 35 then
				draw.SimpleTextOutlined(v[1], "MapFont", x, y - ix.map.iconSize, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
				draw.SimpleTextOutlined(ix.map.signs[1], "MapFont", x, y, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
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

			for k, v in ipairs(ix.map.objects) do
				x, y = map.ToScreen(v[3], w, h)
				if (self:MouseInRect(x, y, ix.map.signSize[1], ix.map.signSize[2])) then
					current_index = k
					break
				end
			end

			if (current_index) then
				ix.map.objects[current_index][3] = map.ToWorld(mx, my, w, h)
				map.Save()
			end
		end
	end

	function frame.map:OnMousePressed(code)
		if (code == MOUSE_RIGHT) then
			local w, h = self:GetSize()
			local current_index

			for k, v in ipairs(ix.map.objects) do
				x, y = map.ToScreen(v[3], w, h)
				if (self:MouseInRect(x, y, ix.map.signSize[1], ix.map.signSize[2])) then
					current_index = k
					break
				end
			end

			local dmenu = DermaMenu()
			local x, y = self:CursorPos()

			if (current_index) then
				dmenu:AddOption("Edit", function()
					if (IsValid(ix.map.gui.label)) then ix.map.gui.label:Remove() end
					local data = ix.map.objects[current_index]

					ix.map.gui.label = vgui.Create("ixMapSetLabel")
					ix.map.gui.label:SetData(data[1], data[2], current_index)

					function ix.map.gui.label:DoneClick(text, color, index)
						ix.map.objects[index] = {text, color, map.ToWorld(x, y, w, h)}
						map.Save()
					end

					ix.map.gui.label = nil
				end):SetImage("icon16/wand.png")

				dmenu:AddSpacer()

				dmenu:AddOption("Remove", function()
					table.remove(ix.map.objects, current_index)
					current_index = nil
				end):SetImage("icon16/exclamation.png")
			elseif (!IsValid(ix.map.gui.label)) then
				dmenu:AddOption("Label", function()
					ix.map.gui.label = vgui.Create("ixMapSetLabel")

					function ix.map.gui.label:DoneClick(text, color)
						ix.map.objects[#ix.map.objects + 1] = {text, color, map.ToWorld(x, y, w, h)}
						map.Save()
					end

					ix.map.gui.label = nil
				end):SetImage("icon16/attach.png")
			end

			dmenu:Open()
		end
	end
end

concommand.Add("show_map", function()
	map.Open()
end)

-- HOOKS
function PLUGIN:LoadFonts()
	surface.CreateFont("MapFont", {
		font = "Jura",
		size = ix.util.ScreenScaleH(10),
		weight = 500,
	})
end

function PLUGIN:InitPostEntity()
	map.Generate()
	ix.map.objects = ix.data.Get("global_map", {})
end

function PLUGIN:PlayerBindPress(_, bind, pressed)
	if (bind:find("gm_showteam") and pressed) then
		map.Open()
		return true
	end
end