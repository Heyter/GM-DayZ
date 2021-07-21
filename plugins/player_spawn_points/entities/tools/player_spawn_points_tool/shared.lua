TOOL.Category = 'GmodZ'
TOOL.Name = 'Player Spawn Points'
TOOL.Command = nil
TOOL.ConfigName = ''

local ClassName = "player_spawn_points_tool"

TOOL.ClientConVar['safezone'] = 0

if (CLIENT) then
	language.Add('tool.'..ClassName..'.name', TOOL.Name)
	language.Add('tool.'..ClassName..'.desc', TOOL.Name .. ' Tool')
	language.Add('tool.'..ClassName..'.left','Create/Update spawner')
	language.Add('tool.'..ClassName..'.right','Delete spawner')
	language.Add('tool.'..ClassName..'.panel_positioning', 'Misc')
	language.Add('tool.'..ClassName..'.safezone', 'Is Safezone')

	TOOL.Information = {
		{ name = "left" },
		{ name = "right" }
	}
end

function TOOL:AreaInRect(v, location)
	local radius = 16

	return (v.position.x >= location.x - radius and v.position.x <= (location.x + radius) and
		v.position.y >= location.y - radius and v.position.y <= (location.y + radius) and
		v.position.z >= location.z - radius and v.position.z <= (location.z + radius))
end

if (CLIENT) then
	local function lang(id)
		return "#tool." .. ClassName .. "." .. id
	end

	local function cvar(id)
		return ClassName .. "_" .. id
	end

	function TOOL:LeftClick(trace)
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:RightClick(trace)
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:Reload(trace)
		return self:GetOwner():IsSuperAdmin()
	end

	function TOOL:Deploy()
		return self:GetOwner():IsSuperAdmin()
	end

	local function AddControl(CPanel, control, name, data)
		data = data or {}
		data.Label = lang(name)
		if (control ~= "ControlPanel" and control ~= "ListBox") then
			data.Command = cvar(name)
		end
		local ctrl = CPanel:AddControl(control, data)
		if (data.Tooltip) then
			ctrl:SetToolTip(lang(name .. ".tooltip"))
		end

		ctrl:SetSkin("Default")

		return ctrl
	end

	function TOOL.BuildCPanel(CPanel)
		CPanel:ClearControls()
		CPanel:AddControl("Header", {Text = lang "name", Description = lang "desc"}):SetSkin("Default")

		AddControl(CPanel, "Checkbox", "safezone")
	end

	local PLUGIN
	function TOOL:DrawHUD()
		PLUGIN = PLUGIN or ix.plugin.Get("player_spawn_points")

		if (!PLUGIN or !PLUGIN.spawners) then return false end
		local spawners = PLUGIN.spawners or {}
		if (table.IsEmpty(spawners)) then return false end

		local trace = self:GetOwner():GetEyeTraceNoCursor()
		local location = trace.HitPos + trace.HitNormal * 0.04

		for _, v in ipairs(spawners) do
			local col = !v.static and color_white or Color("gray")
			local a = v.position:ToScreen()

			surface.SetFont("DermaDefaultBold")
			local tW, tH = surface.GetTextSize(v.title)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(a.x - tW * 0.5 - 5, a.y - 35, tW + 10, tH * 4)

			if (self:AreaInRect(v, location) and !v.static) then
				col = Color("green")
			end

			local space = 10

			surface.SetDrawColor(Color("sky_blue"))
			surface.DrawRect(a.x, a.y, 8, 8)

			draw.SimpleTextOutlined(v.title, "DermaDefaultBold", a.x, a.y - space, col, 1, 1, 1, color_black)

			space = space + 15
			draw.SimpleTextOutlined("Is Safezone: " .. tostring(v.safezone), "DermaDefaultBold", a.x, a.y - space, v.safezone == true and Color("green") or Color("red"), 1, 1, 1, color_black)
		end
	end
end