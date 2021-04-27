local PLUGIN = PLUGIN

local map = {
	font = "Default",

	key = KEY_M,
	delay = 1,

	panel_w = ScrH() * 0.7,
	panel_h = ScrH() * 0.7,

	markers = {
		{
			pos = Vector(0,0,0),
			text = "Marker!"
		}
	}
}

local MAP

function map.Generate()
	local LP = LocalPlayer()

	MAP = {}

	local uptrace = util.TraceLine( {
		start = Vector(0,0,2000),
		endpos = Vector(0,0,2000)+Vector(0,0,1)*1000000,
		mask = MASK_NPCWORLDSTATIC
	} )

	local startpos = Vector(0,0,uptrace.HitPos.z-25)
	local righttrace = util.TraceLine( {
		start = startpos,
		endpos = startpos+Vector(0,1,0)*1000000,
		mask = MASK_NPCWORLDSTATIC
	} )
	local lefttrace = util.TraceLine( {
		start = startpos,
		endpos = startpos-Vector(0,1,0)*1000000,
		mask = MASK_NPCWORLDSTATIC
	} )
	local fronttrace = util.TraceLine( {
		start = startpos,
		endpos = startpos+Vector(1,0,0)*1000000,
		mask = MASK_NPCWORLDSTATIC
	} )
	local backtrace = util.TraceLine( {
		start = startpos,
		endpos = startpos-Vector(1,0,0)*1000000,
		mask = MASK_NPCWORLDSTATIC
	} )

	local pos = LP:GetPos()
	MAP.MapCenter = (righttrace.HitPos+lefttrace.HitPos+fronttrace.HitPos+backtrace.HitPos)*0.25
	MAP.MapCenter.z = LP:GetPos().z+2500

	local MapSize = (righttrace.HitPos):Distance((lefttrace.HitPos))
	MapSize = MapSize*0.5

	MAP.SizeW = -MapSize - 250
	MAP.SizeE = MapSize + 250
	MAP.SizeS = -MapSize - 250
	MAP.SizeW = MapSize + 250
end

hook.Add("InitPostEntity", "minimap.InitPostEntity", function()
	map.Generate()
end)

function map.DrawMarker(data, w, h)
	local font = map.font

	local pos, text, color = data.pos, data.text, data.color and data_color or color_white

	-- Black magic! Death zone
	local a, b

	if MAP.SizeS > 0 then
    	a = pos.y + MAP.SizeN
    else
        a = pos.y - MAP.SizeS
    end

    if MAP.SizeW > 0 then
        b = pos.x + MAP.SizeE
    else
        b = pos.x - MAP.SizeW
    end

    -- map.panel_w
    local numa = ScrH() * 0.7

    draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 5, h - math.Clamp(a/MAP.SizeY * numa, 0, h), 12, 4, Color(0, 0, 0, 255))
    draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 1, h - math.Clamp(a/MAP.SizeY * numa, 0, h) - 4, 4, 12, Color(0, 0, 0, 255))

    draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 5, h - math.Clamp(a/MAP.SizeY * numa, 0, h), 11, 3, color)
    draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 1, h - math.Clamp(a/MAP.SizeY * numa, 0, h) - 4, 3, 11, color)
    draw.SimpleText(text,  font, math.Clamp(b/MAP.SizeX * numa, 0, w) + 1, 
    	h - math.Clamp(a/MAP.SizeY * numa, 0, h) + 11, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)  
    draw.SimpleText(text,  font, math.Clamp(b/MAP.SizeX * numa, 0, w), 
    	h - math.Clamp(a/MAP.SizeY * numa, 0, h) + 10, color, TEXT_ALIGN_CENTER)
end

function map.DrawMap(x, y, w, h)
	local old = DisableClipping(true)
		render.RenderView( {
			origin = MAP.MapCenter,
			angles = Angle(90, 0, 0),
			x = x, y = y,
			w = w, h = h,

			aspectratio = 1,
			znear = -10000,
			zfar = 10000,

			bloomtone = false,
			drawviewmodel = false,
			ortho = true,
			ortholeft = MAP.SizeW,
			orthoright = MAP.SizeE,
			orthotop = MAP.SizeS,
			orthobottom =  MAP.SizeN 
		} )
	DisableClipping(old)
end

function map.Open()
	if not MAP then map.Generate() return end

	if IsValid(map.panel) then
		map.panel:Remove()
		return
	end

	map.panel = vgui.Create("DFrame")
		map.panel:SetSize(map.panel_w, map.panel_h)
		map.panel:Center()
		map.panel:MakePopup()

	local container = vgui.Create("DPanel", map.panel)
		container:Dock(FILL)

	local x, y = map.panel:GetPos()
	local ww, wh = map.panel_w, map.panel_h

	function container:Paint(w, h)
		map.DrawMap(x, y + 24, ww, wh)

		for k, v in ipairs(map.markers) do
			map.DrawMarker(v, ww, wh)
		end
	end
end

hook.Add("PlayerButtonDown", "minimap.PlayerButtonDown", function(_, button)
	if button ~= map.key then return end

	local delay = LocalPlayer().minimap_delay
	if (delay and delay > CurTime()) then return end

	LocalPlayer().minimap_delay = CurTime() + map.delay
	map.Open()
end)