TOOL.Category = 'Gmodz'
TOOL.Name = 'Player Spawn Points'
TOOL.Command = nil
TOOL.ConfigName = ''

local ClassName = "player_spawn_points"

local function lang(id)
	return "#tool." .. ClassName .. "." .. id
end

local function cvar(id)
	return ClassName .. "_" .. id
end

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

if (SERVER) then
	function TOOL:LeftClick(trace)
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get(ClassName)
		if (!PLUGIN) then return false end

		local stop = nil
		local location = trace.HitPos + trace.HitNormal * 2

		for k, v in ipairs(PLUGIN.spawners) do
			if (self:AreaInRect(v, location)) then
				if (!v.static) then
					v.safezone = tobool(self:GetClientNumber("safezone", 0))
				end

				stop = true
				break
			end
		end

		if (stop) then
			net.Start("ixPlayerSpawnerSync")
				net.WriteTable(PLUGIN.spawners)
			net.Send(owner)

			PLUGIN:SaveData()

			return true
		end

		local angles = (trace.HitPos - owner:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local data = {
			position = location,
			angles = angles,
			title = "Player Spawn Point #" .. #PLUGIN.spawners + 1,
			safezone = tobool(self:GetClientNumber("safezone", 0))
		}

		table.insert(PLUGIN.spawners, data)
		data = nil

		net.Start("ixPlayerSpawnerSync")
			net.WriteTable(PLUGIN.spawners)
		net.Send(owner)

		PLUGIN:SaveData()

		return true
	end

	function TOOL:RightClick(trace)
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get(ClassName)
		if (!PLUGIN) then return false end

		local location = trace.HitPos + trace.HitNormal * 0.04
		local index

		for k, v in ipairs(PLUGIN.spawners) do
			if (!v.static and self:AreaInRect(v, location)) then
				index = k
				break
			end
		end

		if (index) then
			table.remove(PLUGIN.spawners, index)

			net.Start("ixPlayerSpawnerSync")
				net.WriteTable(PLUGIN.spawners)
			net.Send(owner)

			PLUGIN:SaveData()
		else
			return false
		end

		return true
	end

	function TOOL:Deploy()
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get(ClassName)
		if (!PLUGIN) then return false end

		net.Start("ixPlayerSpawnerSync")
			net.WriteTable(PLUGIN.spawners)
		net.Send(owner)

		return true
	end
end

if (CLIENT) then
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
end

if (CLIENT) then
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
		PLUGIN = PLUGIN or ix.plugin.Get(ClassName)

		if (!PLUGIN.spawners) then return false end
		local spawners = PLUGIN.spawners or {}
		if (table.IsEmpty(spawners)) then return false end

		local trace = self:GetOwner():GetEyeTraceNoCursor()
		local location = trace.HitPos + trace.HitNormal * 0.04

		for _, v in ipairs(PLUGIN.spawners or {}) do
			local col = !v.static and color_white or Color(167, 167, 167)
			local a = v.position:ToScreen()

			surface.SetFont("DermaDefaultBold")
			local tW, tH = surface.GetTextSize(v.title)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(a.x - tW * 0.5 - 5, a.y - 35, tW + 10, tH * 4)

			if (self:AreaInRect(v, location) and !v.static) then
				col = Color("green")
			end

			local space = 10

			surface.SetDrawColor(Color(0, 255, 255))
			surface.DrawRect(a.x, a.y, 8, 8)

			draw.SimpleTextOutlined(v.title, "DermaDefaultBold", a.x, a.y - space, col, 1, 1, 1, color_black)

			space = space + 15
			draw.SimpleTextOutlined("Is Safezone: " .. tostring(v.safezone), "DermaDefaultBold", a.x, a.y - space, v.safezone == true and Color("green") or Color("red"), 1, 1, 1, color_black)
		end
	end
end