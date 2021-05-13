PLUGIN.name = "Minimap"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then return end

local map_texture = Material("gmodz/map004.png")
local you_texture = Material("../data/rpgm/h4qojrp.png")
local frame = nil

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

	local fTrace = util.TraceLine({
		start = startpos,
		endpos = startpos + endX,
		mask = MASK_NPCWORLDSTATIC
	}).HitPos

	local bTrace = util.TraceLine({
		start = startpos,
		endpos = startpos - endX,
		mask = MASK_NPCWORLDSTATIC
	}).HitPos

	map.Center = (rTrace + lTrace + fTrace + bTrace) * 0.25
	map.Center.z = LocalPlayer():GetPos().z + 2500

	local MapSize = math.Round((rTrace):Distance((lTrace)) / 2)

	map.SizeW = -MapSize
	map.SizeE = MapSize
	map.SizeS = -MapSize
	map.SizeN = MapSize

	map.SizeX = math.abs(map.SizeE + math.abs(map.SizeW))
	map.SizeY = math.abs(map.SizeN + math.abs(map.SizeS))

	startpos, endX, endY, MapSize = nil, nil, nil, nil
	rTrace, lTrace, fTrace, bTrace = nil, nil, nil, nil
	uptrace, mapBoundsMax = nil, nil

	collectgarbage()
end

function map.ToScreen(pos, w, h)
	local y = (map.SizeS > 0 and pos.y + map.SizeN or pos.y - map.SizeS)
	local x = (map.SizeW > 0 and pos.x + map.SizeE or pos.x - map.SizeW)

	-- Map borders
	return math.Clamp(x / map.SizeX * w, 0, w), h - math.Clamp(y / map.SizeY * h, 0, h)
end

concommand.Add("show_map", function()
	if (!map.SizeX) then map.Generate() end
	if IsValid(frame) then frame:Remove() end

	frame = vgui.Create'DFrame'
	frame:SetSize( ScrW() * 0.8, ScrH() * 0.98 )
	frame:Center()
	frame:SetTitle("MAP")
	frame:MakePopup()

	frame.map = frame:Add("EditablePanel")
	frame.map:Dock(FILL)
	frame.map.Paint = function( this, w, h )
		surface.SetMaterial( map_texture )
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect( 0,0,w,h )

		x, y = map.ToScreen(LocalPlayer():GetPos(), w, h)

		local s = math.Round((tonumber(32) / 2160) * ScrH(), 0)
		draw.RoundedBox(0, x-3, y, 8, 2, Color(0,255,255))
		draw.RoundedBox(0, x, y-3, 2, 8, Color(0,255,255))
		draw.SimpleTextOutlined("YOU", "Default", x, y - s, Color(0,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		-- surface.SetDrawColor(100, 100, 255, 255)
		-- surface.SetMaterial(you_texture)
		-- surface.DrawTexturedRectRotated(x, y, s, s, LocalPlayer():EyeAngles().y - 90)
		-- draw.SimpleText("YOU", "Default", x - 1, y - s, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	end
end)

function PLUGIN:InitPostEntity() map.Generate() end