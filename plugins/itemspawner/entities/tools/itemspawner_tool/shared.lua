TOOL.Category = 'GmodZ'
TOOL.Name = 'Item Spawner'
TOOL.Command = nil
TOOL.ConfigName = ''

local ClassName = "itemspawner_tool"

if (CLIENT) then
	language.Add('tool.'..ClassName..'.name', TOOL.Name)
	language.Add('tool.'..ClassName..'.desc', TOOL.Name .. ' Tool')
	language.Add('tool.'..ClassName..'.left', 'Create spawner')
	language.Add('tool.'..ClassName..'.right', 'Delete spawner')
	language.Add('tool.'..ClassName..'.reload', 'Item spawner menu')

	TOOL.Information = {
		{ name = "left" },
		{ name = "right" },
		{ name = "reload" }
	}

	function TOOL:LeftClick()
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:RightClick()
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:Reload()
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:Deploy()
		return self:GetOwner():IsSuperAdmin()
	end
end

function TOOL:AreaInRect(v, location)
	local radius = 16

	return (v.position.x >= location.x - radius and v.position.x <= (location.x + radius) and
		v.position.y >= location.y - radius and v.position.y <= (location.y + radius) and
		v.position.z >= location.z - radius and v.position.z <= (location.z + radius))
end

if (CLIENT) then
	local PLUGIN
	local nearDist = math.pow(256, 2)

	function TOOL:DrawHUD()
		PLUGIN = PLUGIN or ix.plugin.Get("itemspawner")

		if (!PLUGIN or !PLUGIN.spawners) then return false end
		local spawners = PLUGIN.spawners or {}
		if (table.IsEmpty(spawners)) then return false end

		local trace = self:GetOwner():GetEyeTraceNoCursor()
		local location = trace.HitPos + trace.HitNormal

		for _, v in ipairs(spawners) do
			local col = !v.static and color_white or Color("gray")
			local a = v.position:ToScreen()

			surface.SetFont("DermaDefaultBold")
			local tW, tH = surface.GetTextSize(v.title)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(a.x - tW * 0.5 - 5, a.y - 50, tW + 10, tH * 6)

			for _, v2 in ipairs(ents.FindInSphere(v.position, 16)) do
				if (IsValid(v2) and (v2:IsPlayer() and v2:GetMoveType() != MOVETYPE_NOCLIP or v2:GetClass() == "ix_item")) then
					col = Color("red")
					break
				end
			end

			if (LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP and LocalPlayer():GetPos():DistToSqr(v.position) < nearDist) then
				col = Color("red")
			end

			if (self:AreaInRect(v, location) and !v.static) then
				col = Color("green")
			end

			local space = 10

			surface.SetDrawColor(Color("sky_blue"))
			surface.DrawRect(a.x, a.y, 8, 8)

			draw.SimpleTextOutlined(v.title, "DermaDefaultBold", a.x, a.y - space, col, 1, 1, 1, color_black)

			space = space + 15
			draw.SimpleTextOutlined(Format("Задержка: %d мин.", v.delay), "DermaDefaultBold", a.x, a.y - space, Color("yellow"), 1, 1, 1, color_black)

			local chance = "Обычный"

			if (v.chance_type == 1) then
				chance = "Вещественный"
			elseif (v.chance_type == 2) then
				chance = "Линейный"
			end

			space = space + 15
			draw.SimpleTextOutlined("Рандом: " .. chance .. " (" .. (v.scale or 1) .. ")", "DermaDefaultBold", a.x, a.y - space, Color("yellow"), 1, 1, 1, color_black)
		end
	end
end