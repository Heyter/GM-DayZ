util.AddNetworkString("minimap.Request")

-- Black magic after this line
local function CalculateSize(na, size, nb, x, y, z, try)
	local res
	local End = 0

	for i = na, size, nb do
		if util.IsInWorld(Vector(x or i, y or i, z or i)) and End < try then
			res = i

			if End > 0 then
				End = 0
			end
		else
			End = End + 1

			if End >= try then
				break
			end
		end
	end
    
    return res
end

local function GetMap()
	local nb = 45
	local try = 3
	local size = 99999999

	local MAP = {}

	for k, v in ipairs(ents.FindByClass("info_player_*")) do
		MAP.SizeHeight = CalculateSize(v:GetPos().z, size, nb, v:GetPos().x, v:GetPos().y, nil, try)

		MAP.SizeN = CalculateSize(v:GetPos().y, size, nb, v:GetPos().x, nil, MAP.SizeHeight, try)
		MAP.SizeW = CalculateSize(v:GetPos().x, -size, -nb, nil, v:GetPos().y, MAP.SizeHeight, try)
		MAP.SizeS = CalculateSize(v:GetPos().y, -size, -nb, v:GetPos().x, nil, MAP.SizeHeight, try)
		MAP.SizeE = CalculateSize(v:GetPos().x, size, nb, nil, v:GetPos().y, MAP.SizeHeight, try)
            
        MAP.SizeHeight = math.Round(MAP.SizeHeight) + 128
		MAP.SizeN = math.Round(MAP.SizeN) - 64
		MAP.SizeW = math.Round(MAP.SizeW) + 64
		MAP.SizeS = math.Round(MAP.SizeS) + 64
		MAP.SizeE = math.Round(MAP.SizeE) - 64

		MAP.SizeX = MAP.SizeE + math.abs(MAP.SizeW)
		MAP.SizeY = MAP.SizeN + math.abs(MAP.SizeS)

		MAP.SizeX = math.abs(MAP.SizeX)
		MAP.SizeY = math.abs(MAP.SizeY)
	end

	return MAP
end

-- Black magic ended. Normal code here

net.Receive("minimap.Request", function(_, player)
	local time = os.time()

	if (!player.map_cooldown or player.map_cooldown < time) then
		net.Start("minimap.Request")
			net.WriteTable(GetMap())
		net.Send(player)

		-- На всякий случай. Все-таки что-то тут высчитывается. В теории сервер можно положить.
		player.map_cooldown = time + 120
	end
end)