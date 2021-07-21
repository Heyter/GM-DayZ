PLUGIN.name = "Item Spawner"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

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

ix.util.Include("sv_plugin.lua", "server")

if (CLIENT) then
	local PLUGIN = PLUGIN

	net.Receive("ixItemSpawnerManager", function()
		PLUGIN.spawners = net.ReadTable()

		if (IsValid(PLUGIN.ISM_Panel)) then
			PLUGIN.ISM_Panel:Remove()
		end

		vgui.Create("ixItemSpawnerManager"):Populate(PLUGIN.spawners)
	end)

	net.Receive("ixItemSpawnerSync", function()
		PLUGIN.spawners = net.ReadTable()
	end)
end
