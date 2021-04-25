local PLUGIN = PLUGIN

local MAP

hook.Add("InitPostEntity", "minimap.InitPostEntity", function()
	net.Start("minimap.Request")
	net.SendToServer()
end)

net.Receive("minimap.Request", function()
	MAP = net.ReadTable()
end)

local map = {
	font = "Default",

	key = KEY_M,
	delay = 2,

	panel_w = ScrH() * 0.7,
	panel_h = ScrH() * 0.7,

	markers = {
		{
			pos = Vector(0,0,0),
			text = "Marker!"
		}
	}
}

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
			origin = Vector(0, 0, MAP.SizeHeight * 0.8),
			angles = Angle(90, 90, 0),
			x = x, y = y,
			w = w, h = h,

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
	if IsValid(map.panel) then
		map.panel:Remove()
		return
	end

	-- May be it can be removed
	if not MAP then
		net.Start("minimap.Request")
		net.SendToServer()
	end

	map.panel = vgui.Create("DFrame")
		map.panel:SetSize(map.panel_w, map.panel_h)
		map.panel:Center()

	local container = vgui.Create("Panel", map.panel)
		container:Dock(FILL)

	local x, y = container:GetPos()

	function container:Paint(w, h)
		for k, v in ipairs(map.markers) do
			map.DrawMarker(v, w, h)
		end

		map.DrawMap(x, y, w, h)
	end
end

hook.Add("PlayerButtonDown", "minimap.PlayerButtonDown", function(_, button)
	if button ~= map.key then return end

	local delay = LocalPlayer().minimap_delay
	if (delay and delay > CurTime()) then return end

	LocalPlayer().minimap_delay = CurTime() + map.delay
	map.Open()
end)