local PLUGIN = PLUGIN

function PLUGIN:GetLocalAreaPosition(startPosition, endPosition)
	local center = LerpVector(0.5, startPosition, endPosition)
	local min = WorldToLocal(startPosition, angle_zero, center, angle_zero)
	local max = WorldToLocal(endPosition, angle_zero, center, angle_zero)

	return center, min, max
end

local function drawCircle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

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
	MAP.SizeN = MapSize + 250

	MAP.SizeX = MAP.SizeE + math.abs(MAP.SizeW)
	MAP.SizeY = MAP.SizeN + math.abs(MAP.SizeS)

	MAP.SizeX = math.abs(MAP.SizeX)
	MAP.SizeY = math.abs(MAP.SizeY)
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

    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 5, h - math.Clamp(a/MAP.SizeY * numa, 0, h), 12, 4, Color(0, 0, 0, 255))
    surface.SetDrawColor(color_white)
    surface.DrawCircle(math.Clamp(b/MAP.SizeX * numa, 0, w ), h - math.Clamp(a/MAP.SizeY * numa, 0, h), 4)

    if data.text then
    	draw.SimpleText(text,  font, math.Clamp(b/MAP.SizeX * numa, 0, w) + 1, 
    		h - math.Clamp(a/MAP.SizeY * numa, 0, h) + 6, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)  
    	draw.SimpleText(text,  font, math.Clamp(b/MAP.SizeX * numa, 0, w), 
    		h - math.Clamp(a/MAP.SizeY * numa, 0, h) + 5, color, TEXT_ALIGN_CENTER)
    end
    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 1, h - math.Clamp(a/MAP.SizeY * numa, 0, h) - 4, 4, 12, Color(0, 0, 0, 255))

    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 5, h - math.Clamp(a/MAP.SizeY * numa, 0, h), 11, 3, color)
    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, w ) - 1, h - math.Clamp(a/MAP.SizeY * numa, 0, h) - 4, 3, 11, color)
    --
end

function map.DrawArea(pos, radius, outline_color, inline_color, w, h)
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

    local numa = ScrH() * 0.7

	surface.SetDrawColor(inline_color)
	drawCircle(math.Clamp(b/MAP.SizeX * numa, 0, w ), h - math.Clamp(a/MAP.SizeY * numa, 0, h), radius, 128)

	surface.SetDrawColor(outline_color)
	surface.DrawCircle(math.Clamp(b/MAP.SizeX * numa, 0, w ), h - math.Clamp(a/MAP.SizeY * numa, 0, h), radius)
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
		
		for k, v in pairs(ix.area.stored) do
			local center = PLUGIN:GetLocalAreaPosition(v.startPosition, v.endPosition)

			map.DrawMarker({
				pos = center,
				text = k
			}, ww, wh)

			-- TODO: Find radius
			map.DrawArea(center, 6, color_white, Color(152, 251, 152,200), ww, wh)
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
