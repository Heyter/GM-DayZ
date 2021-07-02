PLUGIN.name = "Item Spawner"
PLUGIN.author = "Gary Tate"
PLUGIN.description = ""

CAMI.RegisterPrivilege({
	Name = "Helix - Item Spawner",
	MinAccess = "admin"
})

-- Item Spawner Toggle [On/Off]
ix.config.Add("itemSpawnerActive", true, "Toggle the item spawner.", nil, {
	category = PLUGIN.name
})

ix.config.Add("spawnerOffsetTime", 1, "The range of item spawns around the timer.", nil, {
	category = PLUGIN.name,
	data = { min = 0, max = 999 }
})

ix.config.Add("spawnerRespawnTime", 5, "Time for an item to spawn at any position.", nil, {
	ccategory = PLUGIN.name,
	data = { min = 1, max = 999 }
})

ix.config.Add("spawnerRareItemChance", 10, "Percentage chance of spawning a rare item.", nil, {
	ccategory = PLUGIN.name,
	data = { min = 0, max = 100 }
})

ix.util.Include("sh_commands.lua", "shared")
ix.util.Include("sv_hooks.lua", "server")

if (CLIENT) then
	local PLUGIN = PLUGIN

	net.Receive("ixItemSpawnerManager", function()
		local data = net.ReadTable()

		PLUGIN.spawner = PLUGIN.spawner or {}
		PLUGIN.spawner.positions = data

		if (IsValid(PLUGIN.ISM_Panel)) then
			PLUGIN.ISM_Panel:Remove()
		end

		vgui.Create("ixItemSpawnerManager"):Populate(data)
	end)

	net.Receive("ixItemSpawnerDelete", function()
		PLUGIN.spawner = PLUGIN.spawner or {}
		PLUGIN.spawner.positions = net.ReadTable()
	end)
end
