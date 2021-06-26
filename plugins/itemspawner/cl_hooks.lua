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