PLUGIN.name = "NPC Spawner Tool"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}

if (SERVER) then util.AddNetworkString("ixNPCSpawnerSync") end

ix.util.Include("sv_plugin.lua", "server")

if (CLIENT) then
	net.Receive("ixNPCSpawnerSync", function()
		PLUGIN.spawners = net.ReadTable()
	end)
end

if (CLIENT) then
	local PANEL = {}

	DEFINE_BASECLASS "DPropertySheet"

	AccessorFunc(PANEL, "m_ConVar", "ConVar")

	function PANEL:Init()
		local npcs = list.Get("NPC")

		local function onNPCSelected(_, _, line)
			RunConsoleCommand(self:GetConVar(), line.nicename)
		end

		-- All tab
		local ctrl = vgui.Create("DListView")
		ctrl:SetMultiSelect(false)
		ctrl:AddColumn("#tool.npc_spawnplatform.npc")
		ctrl:AddColumn("#category")

		for nicename, data in pairs(npcs) do
			local line = ctrl:AddLine(data.Name, data.Category or "#other")
			line.nicename = nicename
		end

		ctrl.OnRowSelected = onNPCSelected
		ctrl:SortByColumn(2, false)
		self:AddSheet("#tool.npc_spawnplatform.all_npcs", ctrl)

		local categories = {}

		for nicename, data in pairs(npcs) do
			local cat = data.Category or "#other"
			categories[cat] = categories[cat] or {}
			categories[cat][nicename] = data
		end

		for category, npcs in SortedPairs(categories) do
			-- Temp standin
			local ctrl = vgui.Create("DListView")
			ctrl:SetMultiSelect(false)
			ctrl:AddColumn("#tool.npc_spawnplatform.npc")

			for nicename, data in pairs(npcs) do
				local line = ctrl:AddLine(data.Name)
				line.nicename = nicename
			end
			ctrl.OnRowSelected = onNPCSelected

			ctrl:SortByColumn(1, false)

			self:AddSheet(category, ctrl)
		end

		self:SetTall(200)
		self.list = ctrl

	end

	function PANEL:ControlValues(data)
		if (data.command) then
			self:SetConVar(data.command)
		end
	end

	derma.DefineControl("NPCSpawnSelecter", "Selects a NPC fo' spawnin'", PANEL, "DPropertySheet")

	PANEL = {}
	DEFINE_BASECLASS "DComboBox"

	function PANEL:Init()
		-- Big brained sorting hack
		self:AddChoice("  " .. language.GetPhrase("menubar.npcs.defaultweapon"),
					"weapon_default")
		self:AddChoice("  " .. language.GetPhrase("menubar.npcs.noweapon"),
					"weapon_none")
		self:AddChoice(
			" " .. language.GetPhrase("tool.npc_spawnplatform.weapon_rebel"),
			"weapon_rebel")
		self:AddChoice(" " ..
						language.GetPhrase("tool.npc_spawnplatform.weapon_combine"),
					"weapon_combine")
		self:AddChoice(" " ..
						language.GetPhrase("tool.npc_spawnplatform.weapon_citizen"),
					"weapon_citizen")

		for _, tab in pairs(list.Get("NPCUsableWeapons")) do
			self:AddChoice(tab.title, tab.class)
		end
	end

	function PANEL:ControlValues(data)
		self:SetConVar(data.command)
		self:CheckConVarChanges()
	end

	function PANEL:OnSelect(i, label, value)
		RunConsoleCommand(self.m_strConVar, value)
	end

	derma.DefineControl("NPCWeaponSelecter", "Selects a NPC weapon", PANEL, "DComboBox")
end