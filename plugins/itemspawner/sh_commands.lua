
local PLUGIN = PLUGIN

ix.command.Add("ItemSpawnerAdd", {
	description = "@cmdItemSpawnerAdd",
	privilege = "Item Spawner",
	superAdminOnly = true,
	OnRun = function(self, client)
		local location = client:GetEyeTrace().HitPos
		--location.z = location.z + 10

		PLUGIN:AddSpawner(client, location)
	end
})

ix.command.Add("ItemSpawnerRemove", {
	description = "@cmdItemSpawnerRemove",
	privilege = "Item Spawner",
	superAdminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, index)
		return PLUGIN:RemoveSpawner(client, index) and "@cmdRemoved" or "@cmdNoRemoved"
	end
})

ix.command.Add("ItemSpawnerList", {
	description = "@cmdItemSpawnerList",
	privilege = "Item Spawner",
	superAdminOnly = true,
	OnRun = function(self, client)
		if (#PLUGIN.spawner.positions == 0) then
			return "@cmdNoSpawnPoints"
		end

		net.Start("ixItemSpawnerManager")
			net.WriteTable(PLUGIN.spawner.positions)
		net.Send(client)
	end
})