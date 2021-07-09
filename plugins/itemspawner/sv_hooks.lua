
local PLUGIN = PLUGIN

PLUGIN.spawner = PLUGIN.spawner or {}
PLUGIN.items = PLUGIN.items or {}
PLUGIN.spawner.positions = PLUGIN.spawner.positions or {}

Schema.dropItems = Schema.dropItems or {rare = {}, common = {}}
Schema.weightedItems = Schema.weightedItems or {}

function Schema.GetRandomItem(chance)
	local itemID = math.random()
	local isRare = false

	if (itemID > (chance or 0.05)) then
		itemID = Schema.dropItems.common[ math.random( #Schema.dropItems.common ) ]
	else
		itemID = Schema.dropItems.rare[ math.random( #Schema.dropItems.rare ) ]
		isRare = true
	end

	return itemID, isRare
end

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
util.AddNetworkString("ixItemSpawnerDelete")
util.AddNetworkString("ixItemSpawnerEdit")
util.AddNetworkString("ixItemSpawnerGoto")
util.AddNetworkString("ixItemSpawnerSpawn")
util.AddNetworkString("ixItemSpawnerChanges")

function PLUGIN:InitializedPlugins()
	Schema.dropItems = {rare = {}, common = {}}

	local total_weight = 0
	Schema.weightedItems = {}

	for itemID, v in pairs(ix.item.list) do
		if (v.rarity and istable(v.rarity)) then
			if (v.rarity.rare) then
				Schema.dropItems.rare[#Schema.dropItems.rare + 1] = itemID
			end

			if (v.rarity.common) then
				Schema.dropItems.common[#Schema.dropItems.common + 1] = itemID
			end

			if (v.rarity.weight) then
				Schema.weightedItems[#Schema.weightedItems + 1] = {id = itemID, weight = v.rarity.weight}
				total_weight = total_weight + v.rarity.weight
			end
		end
	end

	Schema.weightedItems[#Schema.weightedItems + 1] = {id = "money", weight = 90}

	if (#Schema.weightedItems > 0) then
		for _, v in ipairs(Schema.weightedItems) do
			v.weight = v.weight / total_weight
		end

		table.shuffle(Schema.weightedItems)
	end

	total_weight = nil
end

function PLUGIN:LoadData()
	PLUGIN.spawner.positions = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(PLUGIN.spawner.positions)
end

function PLUGIN:AddSpawner(client, position)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	local respawnTime = ix.config.Get("spawnerRespawnTime", 600)
	local offsetTime  = ix.config.Get("spawnerOffsetTime", 100)
	if (respawnTime < offsetTime) then
		offsetTime = respawnTime - 60
	end

	local data = {
		["ID"] = os.time(),
		["title"] = "Item Spawner #" .. #PLUGIN.spawner.positions + 1,
		["delay"] = math.random(respawnTime - offsetTime, respawnTime + offsetTime),
		["author"] = client:SteamID64(),
		["position"] = position,
		["rarity"] = ix.config.Get("spawnerRareItemChance", 0) / 100
	}

	data["lastSpawned"] = os.time() + (data["delay"] * 60)

	table.insert(PLUGIN.spawner.positions, data)
	data = nil

	net.Start("ixItemSpawnerDelete")
		net.WriteTable(PLUGIN.spawner.positions)
	net.Send(client)

	PLUGIN:SaveData()
end

function PLUGIN:RemoveSpawner(client, index)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	for k, v in ipairs(PLUGIN.spawner.positions) do
		if (k == index) then
			table.remove(PLUGIN.spawner.positions, k)
			PLUGIN:SaveData()
			return true
		end
	end

	return false
end

local nearDist = math.pow(256, 2)
function PLUGIN:ForceSpawn(client, spawner)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end
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

	local itemID = Schema.GetRandomWeightedItem(3, true)

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
	if (table.IsEmpty(PLUGIN.spawner.positions) or !(ix.config.Get("itemSpawnerActive", false))) then return end

	for _, v in ipairs(PLUGIN.spawner.positions) do
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

			local itemID = Schema.GetRandomWeightedItem(3, true)

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

net.Receive("ixItemSpawnerDelete", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	if (PLUGIN:RemoveSpawner(client, net.ReadUInt(12))) then
		net.Start("ixItemSpawnerManager")
			net.WriteTable(PLUGIN.spawner.positions)
		net.Send(client)
	end
end)

net.Receive("ixItemSpawnerGoto", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	client:SetPos(net.ReadVector())
end)

net.Receive("ixItemSpawnerSpawn", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	PLUGIN:ForceSpawn(client, net.ReadTable())
end)

net.Receive("ixItemSpawnerChanges", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	local changes = net.ReadTable()

	for k, v in ipairs(PLUGIN.spawner.positions) do
		if (k == changes[1]) then
			v.title = changes[2]
			v.delay = math.Clamp(changes[3], 1, 10000)
			v.rarity = math.Clamp(changes[4], 0, 100) / 100

			break
		end
	end

	net.Start("ixItemSpawnerManager")
		net.WriteTable(PLUGIN.spawner.positions)
	net.Send(client)
end)
