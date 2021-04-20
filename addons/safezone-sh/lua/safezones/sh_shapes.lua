SH_SZ.Shapes = {}
SH_SZ.ShapesIndex = {}

SH_SZ.Shapes["cube"] = {
	name = "cube",
	icon = "shenesis/safezones/cube.png",
	points = 2,
	steps = {
		{type = "place"},
		{type = "place"},
		{type = "confirm"},
	},

	setup = function(zone, points, size)
		zone:SetupCube(points[1], points[2], size)
	end,
	render = function(points, size, color)
		local center, min, max = SH_SZ:GetLocalZonePosition(points[1], points[2], 1, size)
		color = Color(255, 255, 255, 25 + (1 + math.sin(SysTime() * 6)) * 115)

		render.DrawWireframeBox(center, angle_zero, min, max, color)
	end
}

SH_SZ.Shapes["sphere"] = {
	name = "sphere",
	icon = "shenesis/safezones/sphere.png",
	points = 1,
	steps = {
		{type = "place"},
		{type = "confirm"},
	},

	setup = function(zone, points, size)
		zone:SetupSphere(points[1], size)
	end,
	render = function(points, size, color)
		render.DrawWireframeSphere(points[1], size, 16, 16, color, true)
	end
}

do
	local i = 0
	for _, v in pairs(SH_SZ.Shapes) do
		i = i + 1
		v.id = i
		SH_SZ.ShapesIndex[i] = v
	end
end