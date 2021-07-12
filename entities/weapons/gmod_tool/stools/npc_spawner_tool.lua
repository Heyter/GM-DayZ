TOOL.Category = 'Gmodz'
TOOL.Name = 'NPC Spawner'
TOOL.Command = nil
TOOL.ConfigName = ''

local ClassName = "npc_spawner_tool"

local function lang(id)
	return "#tool." .. ClassName .. "." .. id
end
local function cvar(id)
	return ClassName .. "_" .. id
end

local cvars = {
	npc = "npc_combine_s",
	weapon = "weapon_smg1",
	spawnheight = 16,
	spawnradius = 16,
	maximum = 5,
	delay = 1,
	nocollide = 1,
	healthmul = 1,
	decrease = 0,
	skill = WEAPON_PROFICIENCY_AVERAGE,
	killreward = -1,
}

local cvars_type = {
	npc = "string",
	weapon = "string",
	spawnheight = "number",
	spawnradius = "number",
	maximum = "number",
	delay = "number",
	nocollide = "boolean",
	healthmul = "number",
	decrease = "number",
	skill = "number",
	killreward = "number",
}

table.Merge(TOOL.ClientConVar, cvars)

local wepprof = {}
local npcflags = {
	{512,	'Fade corpse on death'},
	{8192,	'Don\'t drop weapons on death'},
	{8,		'Drop healthkit on death'},
	{256,	'Increase visibility and shoot distance'},
	{16384,	'[PHYS] Ignore player push'},
	{4096,	'[PHYS] Alternate collision (don\'t avoid players)'},
	{1,		'[IDLE] Remain idle till seen'},
	{2,		'[IDLE] Make no idle sounds until angry'},
	{16,	'[IDLE] Don\'t acquire enemies or avoid obstacles'},
	{128,	'[DEV] Wait for script'},
	{4,		'[DEV] Fall to ground instead of teleporting'},
	{1024,	'[DEV] Think outside PVS'},
	{2048,	'[DEV] Template NPC'},
}

for _, v in ipairs(npcflags) do
	TOOL.ClientConVar['SF_'..v[1]] = 0
	if (CLIENT) then language.Add('tool.'..ClassName..'.SF_'..v[1], v[2]) end
end

TOOL.ClientConVar['SF_512'] = 1
TOOL.ClientConVar['SF_1024'] = 1
TOOL.ClientConVar['SF_8192'] = 1

if (SERVER) then
	function TOOL:SetKVs(index, PLUGIN)
		PLUGIN = PLUGIN or ix.plugin.Get("npc_spawner")

		for key in pairs(cvars) do
			if (cvars_type[key]) then
				if (cvars_type[key] == "number") then
					PLUGIN.spawners[index][key] = tonumber(self:GetClientInfo(key))
				elseif (cvars_type[key] == "boolean") then
					PLUGIN.spawners[index][key] = tobool(self:GetClientInfo(key))
				else
					PLUGIN.spawners[index][key] = self:GetClientInfo(key)
				end
			else
				PLUGIN.spawners[index][key] = self:GetClientInfo(key)
			end
		end

		local flags = 0
		for _, v in ipairs(npcflags) do
			if self:GetClientNumber('SF_'..v[1], 0) ~= 0 then
				flags = bit.bor(flags, v[1])

				PLUGIN.spawners[index].flagsIDs = PLUGIN.spawners[index].flagsIDs or {}
				PLUGIN.spawners[index].flagsIDs[v[1]] = true
			end
		end

		PLUGIN.spawners[index]["flags"] = flags
		PLUGIN.spawners[index]["lastSpawned"] = os.time() + (tonumber(PLUGIN.spawners[index]["delay"]) * 60)

		net.Start("ixNPCSpawnerSync")
			net.WriteTable(PLUGIN.spawners)
		net.Send(self:GetOwner())

		PLUGIN:SaveData()
	end
else
	language.Add('tool.'..ClassName..'.name','NPC Spawner')
	language.Add('tool.'..ClassName..'.desc','NPC Spawner Tool')
	language.Add('tool.'..ClassName..'.left','Create/Update spawner')
	language.Add('tool.'..ClassName..'.right','Delete spawner')
	language.Add('tool.'..ClassName..'.reload','Copy info from spawner')
	language.Add('tool.'..ClassName..'.panel_npc','NPC Selection')
	language.Add('tool.'..ClassName..'.npc','NPC')
	language.Add('tool.'..ClassName..'.all_npcs','All NPCs')
	language.Add('tool.'..ClassName..'.weapon','Weapon')
	language.Add('tool.'..ClassName..'.skill','Weapon Skill')
	language.Add('tool.'..ClassName..'.panel_spawning','Spawning Rates')
	language.Add('tool.'..ClassName..'.delay','Spawning Delay (minutes)')
	language.Add('tool.'..ClassName..'.maximum','Max count')
	language.Add('tool.'..ClassName..'.decrease','Wave Delay Decrease')
	language.Add('tool.'..ClassName..'.decrease.help','Every time you kill (Max count) NPCs, the spawning delay will be decreased by this amount')
	language.Add('tool.'..ClassName..'.panel_positioning','Positioning')
	language.Add('tool.'..ClassName..'.positioning.help',"Because spawning is random, NPCs can get stuck.\nYou can either make them not collide with each other or space out where they spawn.")
	language.Add('tool.'..ClassName..'.nocollide','Disable NPC Collisions')
	language.Add('tool.'..ClassName..'.spawnheight','Spawn Height')
	language.Add('tool.'..ClassName..'.spawnradius','Spawn Distance')
	language.Add('tool.'..ClassName..'.panel_other','Other')
	language.Add('tool.'..ClassName..'.healthmul','Health multiplier')
	language.Add('tool.'..ClassName..'.killreward','Kill Reward')
	language.Add('tool.'..ClassName..'.killreward.help','Some gamemodes and addons give you a reward for killing NPCs. If you want to override the reward for NPCs spawned by this platform, set the value to anything other than -1.')
	language.Add('tool.'..ClassName..'.weapon_rebel','Random Rebel Weapon')
	language.Add('tool.'..ClassName..'.weapon_combine','Random Combine Weapon')
	language.Add('tool.'..ClassName..'.weapon_citizen','Random Citizen Weapon')
	language.Add('tool.'..ClassName..'.panel_spawn_flags','Spawn Flags')

	TOOL.Information = {
		{ name = "left" },
		{ name = "right" },
		{ name = 'reload' },
	}

	wepprof[WEAPON_PROFICIENCY_POOR] = 'Poor = 0'
	wepprof[WEAPON_PROFICIENCY_AVERAGE] = 'Average = 1'
	wepprof[WEAPON_PROFICIENCY_GOOD] = 'Good = 2'
	wepprof[WEAPON_PROFICIENCY_VERY_GOOD] = 'Very good = 3'
	wepprof[WEAPON_PROFICIENCY_PERFECT] = 'Perfect = 4'
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

		local PLUGIN = ix.plugin.Get("npc_spawner")
		if (!PLUGIN) then return false end

		local stop = nil
		local location = trace.HitPos + trace.HitNormal * 0.04

		for k, v in ipairs(PLUGIN.spawners) do
			if (self:AreaInRect(v, location)) then
				if (!v.static) then self:SetKVs(k, PLUGIN) end
				stop = true
				break
			end
		end

		if (stop) then
			return true
		end

		local ang = trace.HitNormal:Angle()
		ang.r = 0
		ang.p = 0
		ang.y = ang.y + 180

		local data = {
			position = trace.HitPos + trace.HitNormal * 0.04,
			angles = ang,
			title = "Spawner #" .. #PLUGIN.spawners + 1,
			spawnedNPCs = {},
			totalSpawnedNPCs = 0
		}

		for key, default in pairs(cvars) do
			if (cvars_type[key]) then
				if (cvars_type[key] == "number") then
					data[key] = tonumber(default)
				elseif (cvars_type[key] == "boolean") then
					data[key] = tobool(default)
				else
					data[key] = default
				end
			else
				data[key] = default
			end
		end

		data.lastSpawned = os.time() + (tonumber(data.delay) * 60)
		data.flagsIDs = {}

		local flags = 0
		for _, v in ipairs(npcflags) do
			local num = self:GetClientNumber('SF_'..v[1], 0)
			if self:GetClientNumber('SF_'..v[1], 0) ~= 0 then
				flags = bit.bor(flags,v[1])
				data.flagsIDs[v[1]] = true
			end
		end

		data.flags = flags

		local index = table.insert(PLUGIN.spawners, data)
		self:SetKVs(index)

		return true
	end

	function TOOL:RightClick(trace)
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get("npc_spawner")
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
			for ent in pairs(PLUGIN.spawners[index].spawnedNPCs or {}) do
				if (IsValid(ent) and !ent:IsPlayer()) then
					ent:Remove()
				end
			end

			table.remove(PLUGIN.spawners, index)

			net.Start("ixNPCSpawnerSync")
				net.WriteTable(PLUGIN.spawners)
			net.Send(owner)

			PLUGIN:SaveData()
		else
			return false
		end

		return true
	end

	function TOOL:Reload(trace)
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get("npc_spawner")
		if (!PLUGIN) then return false end

		local location = trace.HitPos + trace.HitNormal * 0.04
		local index

		for k, v in ipairs(PLUGIN.spawners) do
			if (!v.static and self:AreaInRect(v, location)) then
				index = k
				break
			end
		end

		if (!index) then
			return false
		end

		for key in pairs(self.ClientConVar) do
			local res = PLUGIN.spawners[index][key]
			if (res) then
				owner:ConCommand(cvar(key) .. " " .. tostring(res) .. "\n")
			end
		end

		for _, v in ipairs(npcflags) do
			if (PLUGIN.spawners[index].flagsIDs[v[1]]) then
				owner:ConCommand(cvar("SF_" .. v[1]) .. " 1\n")
			else
				owner:ConCommand(cvar("SF_" .. v[1]) .. " 0\n")
			end
		end

		return true
	end

	function TOOL:Deploy()
		local owner = self:GetOwner()

		if (!owner:IsSuperAdmin()) then
			return false
		end

		local PLUGIN = ix.plugin.Get("npc_spawner")
		if (!PLUGIN) then return false end

		net.Start("ixNPCSpawnerSync")
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
		CPanel:AddControl("Header", {Text = lang "name", Description = lang "desc"}):SetSkin("Default")

		local combo, options
		-- Presets
		local CVars = {}
		local defaults = {}
		for key, default in pairs(cvars) do
			key = cvar(key)
			table.insert(CVars, key)
			defaults[key] = default
		end

		CPanel:AddControl("ComboBox", {
			Label = "#Presets",
			Folder = "spawnplatform",
			CVars = CVars,
			Options = {
				default = defaults,
			},
			MenuButton = 1,
		}):SetSkin("Default")

		do -- NPC Selector

			local CPanel = AddControl(CPanel, "ControlPanel", "panel_npc")

			-- Type select
			AddControl(CPanel, "NPCSpawnSelecter", "npc")

			-- Weapon select
			AddControl(CPanel, "NPCWeaponSelecter", "weapon")

			-- Skill select
			local skill = CPanel:ComboBox('Skill', cvar("skill"))
			skill:SetMinimumSize(nil,20)
			skill:SetSortItems(false)
			function skill.UpdateData()
				skill:Clear()
				local currentProficiency = GetConVar(cvar("skill")):GetInt()
				for k,v in pairs(wepprof) do
					local showDefault = false
					if currentProficiency == k then
						showDefault = true
					end
					skill:AddChoice(v,k,showDefault)
				end
			end
			skill:UpdateData()
		end

		do
			local CPanel = AddControl(CPanel, "ControlPanel", "panel_spawn_flags")

			for k,v in ipairs(npcflags) do
				local fstr = 'SF_'..v[1]
				local check_flag = AddControl(CPanel, "Checkbox", fstr)
				check_flag.OnChange = function(self,bool)
					GetConVar(cvar(fstr)):SetInt(bool and 1 or 0)
				end
				check_flag.UpdateData = function(this)
					if (GetConVar(cvar(fstr)):GetString() == "1") then
						check_flag:SetChecked(true)
					else
						check_flag:SetChecked(false)
					end
				end
				check_flag:UpdateData()
			end
		end

		do
			local CPanel = AddControl(CPanel, "ControlPanel", "panel_spawning")

			-- Timer select
			AddControl(CPanel, "Slider", "delay", {Type = "Float", Min = 0.1, Max = 60})
			-- Maximum select
			AddControl(CPanel, "Slider", "maximum", {Type = "Integer", Min = 1, Max = 20})
			-- Timer Reduction
			AddControl(CPanel, "Slider", "decrease", {Type = "Float", Min = 0, Max = 2, Help = true})
		end

		do -- Positions

			local CPanel = AddControl(CPanel, "ControlPanel", "panel_positioning", {Closed = true})
			CPanel:Help(lang "positioning.help")
			-- Nocollide
			AddControl(CPanel, "Checkbox", "nocollide")
			-- Spawnheight select
			AddControl(CPanel, "Slider", "spawnheight", {Type = "Float", Min = 8, Max = 128})
			-- Spawnradius select
			AddControl(CPanel, "Slider", "spawnradius", {Type = "Float", Min = 0, Max = 128})

		end
		do -- Other
			local CPanel = AddControl(CPanel, "ControlPanel", "panel_other", {Closed = true})

			-- Healthmul select
			AddControl(CPanel, "Slider", "healthmul", {Type = "Float", Min = 0.5, Max = 5})

			-- NPC Kill Reward
			AddControl(CPanel, "Slider", "killreward", {Type = "Integer", Min = -1, Max = 1000, Help = true})
		end
	end

	local nearDist = math.pow(3000, 2)
	local PLUGIN

	function TOOL:DrawHUD()
		PLUGIN = PLUGIN or ix.plugin.Get("npc_spawner")

		if (!PLUGIN.spawners) then return false end
		local spawners = PLUGIN.spawners or {}
		if (table.IsEmpty(spawners)) then return false end

		local trace = self:GetOwner():GetEyeTraceNoCursor()
		local location = trace.HitPos + trace.HitNormal * 0.04

		for _, v in ipairs(PLUGIN.spawners or {}) do
			local col = !v.static and color_white or Color(167, 167, 167)
			local a = v.position:ToScreen()
			local title = Format("%s (%s)", v.title, v.npc)

			surface.SetFont("DermaDefaultBold")
			local tW, tH = surface.GetTextSize(title)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(a.x - tW * 0.5 - 5, a.y - 50, tW + 10, tH * 5)

			for _, v2 in ipairs(ents.FindInSphere(v.position, v.spawnradius or cvars.spawnradius)) do
				if (IsValid(v2) and (v2:IsPlayer() and v2:GetMoveType() != MOVETYPE_NOCLIP or v2:IsNPC())) then
					col = Color(255, 0, 0)
					break
				end
			end

			if (LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP and LocalPlayer():GetPos():DistToSqr(v.position) < nearDist) then
				col = Color(255, 0, 0)
			end

			if (self:AreaInRect(v, location)) then
				if (!v.static) then
					col = Color(0, 255, 0)
				end
			end

			local space = 10

			surface.SetDrawColor(Color(0, 255, 255))
			surface.DrawRect(a.x, a.y, 8, 8)

			draw.SimpleTextOutlined(title, "DermaDefaultBold", a.x, a.y - space, col, 1, 1, 1, color_black)

			space = space + 15
			draw.SimpleTextOutlined("Wep: " .. v.weapon, "DermaDefaultBold", a.x, a.y - space, Color(255, 255, 0), 1, 1, 1, color_black)

			space = space + 15
			draw.SimpleTextOutlined(Format("MaxNPCs: %d, Delay: %d", v.maximum, v.delay), "DermaDefaultBold", a.x, a.y - space, Color(255, 255, 0), 1, 1, 1, color_black)
		end
	end
end