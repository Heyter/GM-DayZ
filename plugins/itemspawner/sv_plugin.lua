local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}
PLUGIN.chance_type = {
	["weighted"] = 1,
	["linear"] = 2,
	["default"] = 3,
}

Schema.weightedItems = Schema.weightedItems or {}

function Schema.GetRandomWeightedItem(scale, shuffle)
	if (shuffle) then
		table.shuffle(Schema.weightedItems)
	end

	local random = math.random() * (scale or 1)
	local sum = 0

	for _, v in ipairs(Schema.weightedItems) do
		sum = sum + v.weight

		if random <= sum then
			return v.id
		end
	end
end

util.AddNetworkString("ixItemSpawnerManager")
util.AddNetworkString("ixItemSpawnerSync")
util.AddNetworkString("ixItemSpawnerEdit")
util.AddNetworkString("ixItemSpawnerGoto")
util.AddNetworkString("ixItemSpawnerSpawn")
util.AddNetworkString("ixItemSpawnerChanges")

function PLUGIN:InitializedPlugins()
	local total_weight = 0
	Schema.weightedItems = {}

	for itemID, v in pairs(ix.item.list) do
		if (v.rarity and istable(v.rarity)) then
			if (v.rarity.weight) then
				Schema.weightedItems[#Schema.weightedItems + 1] = {id = itemID, weight = v.rarity.weight}
				total_weight = total_weight + v.rarity.weight
			end
		end
	end

	if (#Schema.weightedItems > 0) then
		for _, v in ipairs(Schema.weightedItems) do
			v.weight = v.weight / total_weight
		end

		table.shuffle(Schema.weightedItems)
	end

	total_weight = nil
end

function PLUGIN:LoadData()
	local data = self:GetData() or {}

	if (!table.IsEmpty(data)) then
		for _, v in pairs(data) do
			for k, v2 in ipairs(v.items) do
				if (istable(v2) and !ix.item.list[v2.id]) then
					table.remove(v.items, k)
				else
					if (!ix.item.list[v2]) then
						table.remove(v.items, k)
					end
				end
			end

			if (table.IsEmpty(v.items)) then
				v.chance_type = 3
				v.items = nil
			end
		end
	end

	PLUGIN.spawners = table.Copy(data)
	data = nil
end

function PLUGIN:SaveData()
	self:SetData(PLUGIN.spawners)
end

function PLUGIN:GetRandomItem(type, items, scale, shuffle)
	if (type == 1) then -- weighted
		local random = math.random() * (scale or 1)
		local sum = 0

		if (shuffle) then
			table.shuffle(items)
		end

		for _, v in ipairs(items) do
			sum = sum + v.weight

			if random <= sum then
				return v.id
			end
		end
	elseif (type == 2) then -- linear
		return items[ math.random(#items) ]
	end
end

function PLUGIN:AddSpawner(client, position)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit PLUGIN.AddSpawner: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	local respawnTime = ix.config.Get("spawnerRespawnTime", 600)
	local offsetTime  = ix.config.Get("spawnerOffsetTime", 100)
	if (respawnTime < offsetTime) then
		offsetTime = respawnTime - 60
	end

	local data = {
		["title"] = "Item Spawner #" .. #PLUGIN.spawners + 1,
		["delay"] = math.random(respawnTime - offsetTime, respawnTime + offsetTime),
		["author"] = client:SteamID64(),
		["position"] = position,
		["chance_type"] = 3
	}

	data["lastSpawned"] = os.time() + (data["delay"] * 60)

	table.insert(PLUGIN.spawners, data)
	data = nil

	net.Start("ixItemSpawnerSync")
		net.WriteTable(PLUGIN.spawners)
	net.Send(client)

	PLUGIN:SaveData()
end

function PLUGIN:RemoveSpawner(client, index)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit PLUGIN.RemoveSpawner: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	for k, v in ipairs(PLUGIN.spawners) do
		if (k == index) then
			table.remove(PLUGIN.spawners, k)
			PLUGIN:SaveData()
			return true
		end
	end

	return false
end

local nearDist = math.pow(256, 2)
function PLUGIN:ForceSpawn(client, spawner)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit PLUGIN.ForceSpawn: %s (%s)", client:Name(), client:SteamID()))
		return
	end
	if !(ix.config.Get("itemSpawnerActive")) then return end

	spawner.lastSpawned = os.time() + (spawner.delay * 60)

	local near_item = nil
	for _, v in ipairs(ents.FindInSphere(spawner.position, 16)) do
		if (IsValid(v) and (v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP or v:GetClass() == "ix_item")) then
			near_item = true
			break
		end
	end

	for _, v in ipairs(player.GetHumans()) do
		if (IsValid(v) and v:GetMoveType() != MOVETYPE_NOCLIP and v:Alive() and v:GetPos():DistToSqr(spawner.position) < nearDist) then
			near_item = true
			break
		end
	end

	if (near_item) then
		spawner.lastSpawned = os.time() + 60
		near_item = nil
		return
	end

	local itemID

	if (spawner.items and spawner.chance_type != 3) then
		itemID = self:GetRandomItem(spawner.chance_type, spawner.items, spawner.scale, true)
	else
		itemID = Schema.GetRandomWeightedItem(spawner.scale, true)
	end

	if (itemID) then
		ix.item.Spawn(itemID, spawner.position, function(_, entity)
			entity:SetPos(spawner.position + Vector(0, 0, -entity:OBBMins().z))

			local physObj = entity:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
				physObj:Sleep()
			end
		end)
	end
end

timer.Create("ixItemSpawner", 5, 0, function()
	if (table.IsEmpty(PLUGIN.spawners) or !(ix.config.Get("itemSpawnerActive", false))) then return end

	for _, v in ipairs(PLUGIN.spawners) do
		if (v.lastSpawned < os.time()) then
			v.lastSpawned = os.time() + (v.delay * 60)

			local near_item = nil
			for _, v2 in ipairs(ents.FindInSphere(v.position, 16)) do
				if (IsValid(v2) and (v2:IsPlayer() and v2:GetMoveType() != MOVETYPE_NOCLIP or v2:GetClass() == "ix_item")) then
					near_item = true
					break
				end
			end

			for _, v2 in ipairs(player.GetHumans()) do
				if (IsValid(v2) and v2:GetMoveType() != MOVETYPE_NOCLIP and v2:Alive() and v2:GetPos():DistToSqr(v.position) < nearDist) then
					near_item = true
					break
				end
			end

			if (near_item) then
				v.lastSpawned = os.time() + 60
				near_item = nil
				continue
			end

			local itemID

			if (v.items and v.chance_type != 3) then
				itemID = PLUGIN:GetRandomItem(v.chance_type, v.items, v.scale, true)
			else
				itemID = Schema.GetRandomWeightedItem(v.scale, true)
			end

			if (itemID) then
				ix.item.Spawn(itemID, v.position, function(_, entity)
					entity:SetPos(v.position + Vector(0, 0, -entity:OBBMins().z))

					local physObj = entity:GetPhysicsObject()

					if (IsValid(physObj)) then
						physObj:EnableMotion(false)
						physObj:Sleep()
					end
				end)
			end
		end
	end
end)

net.Receive("ixItemSpawnerSync", function(_, client)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit ixItemSpawnerSync: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	if (PLUGIN:RemoveSpawner(client, net.ReadUInt(12))) then
		net.Start("ixItemSpawnerManager")
			net.WriteTable(PLUGIN.spawners)
		net.Send(client)
	end
end)

net.Receive("ixItemSpawnerGoto", function(_, client)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit ixItemSpawnerGoto: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	client:SetPos(net.ReadVector())
end)

net.Receive("ixItemSpawnerSpawn", function(_, client)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit ixItemSpawnerSpawn: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	PLUGIN:ForceSpawn(client, net.ReadTable())
end)

net.Receive("ixItemSpawnerChanges", function(_, client)
	if (!client:IsSuperAdmin()) then
		ix.util.DebugLog(Format("Exploit ixItemSpawnerChanges: %s (%s)", client:Name(), client:SteamID()))
		return
	end

	local changes = net.ReadTable()

	for k, v in ipairs(PLUGIN.spawners) do
		if (k == changes[1]) then
			v.title = changes[2]
			v.delay = math.Clamp(changes[3], 1, 10000)

			if (!table.IsEmpty(changes[5])) then
				v.chance_type = PLUGIN.chance_type[changes[4]]
				v.items = changes[5]
			else
				v.chance_type = 3
			end

			if (v.items and table.IsEmpty(v.items)) then
				v.items = nil
			end

			v.scale = math.Clamp(changes[6], 1, 100)

			break
		end
	end

	changes = nil

	net.Start("ixItemSpawnerManager")
		net.WriteTable(PLUGIN.spawners)
	net.Send(client)
end)
