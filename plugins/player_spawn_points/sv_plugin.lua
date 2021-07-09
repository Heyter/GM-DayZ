local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}

local spawnPointVariations = {Vector(0, 0, 0)}

for i = 0, 360, 22.5 do
	spawnPointVariations[#spawnPointVariations + 1] = Vector(math.cos(i), math.sin(i), 0)
end

local function GetPlayerSize(ply)
	local bottom, top = ply:GetHull()

	return top - bottom
end

-- https://github.com/TTT-2/TTT2/blob/master/lua/ttt2/libraries/spawn.lua#L52
local function IsSpawnPointSafe(ply, pos, force, filter)
	local sizePlayer = GetPlayerSize(ply)

	if not util.IsInWorld(pos) then
		return false
	end

	filter = istable(filter) and filter or {filter}

	-- the center pos is slightly shifted to the top to prevent ground
	-- collisions in the walltrace
	local posCenter = pos + Vector(0, 0, 0.525 * sizePlayer.z)

	-- Make sure there is enough space around the player
	local traceWalls = util.TraceHull({
		start = posCenter,
		endpos = posCenter,
		mins = -0.5 * sizePlayer,
		maxs = 0.5 * sizePlayer,
		filter = function(ent)
			if not IsValid(ent) or table.HasValue(filter, ent) then
				return false
			end

			if ent:GetCollisionGroup() == COLLISION_GROUP_WEAPON then
				return false
			end

			return true
		end,
		mask = MASK_SOLID
	})

	if traceWalls.Hit then
		return false
	end

	-- make sure the new position is on the ground
	local traceGround = util.TraceLine({
		start = posCenter,
		endpos = posCenter - Vector(0, 0, sizePlayer.z),
		filter = player.GetAll(),
		mask = MASK_SOLID
	})

	if not traceGround.Hit then
		return false
	end

	local blockingEntities = ents.FindInBox(
		pos + Vector(-0.5 * sizePlayer.x, -0.5 * sizePlayer.y, 0),
		pos + sizePlayer
	)

	for i = 1, #blockingEntities do
		local blockingEntity = blockingEntities[i]

		if not IsValid(blockingEntity) or not blockingEntity:IsPlayer() or not blockingEntity:Alive() then continue end
		if table.HasValue(filter, blockingEntity) then continue end

		if force then
			blockingEntity:Kill()
		else
			return false
		end
	end

	return true
end

local function GetSpawnPointsAroundSpawn(ply, pos, radiusMultiplier)
	local sizePlayer = GetPlayerSize(ply)
	local boundsPlayer = Vector(sizePlayer.x, sizePlayer.y, 0) * 1.5 * (radiusMultiplier or 1)
	local positions = {}

	for i = 1, #spawnPointVariations do
		positions[i] = pos + spawnPointVariations[i] * boundsPlayer
	end

	for i = 1, #positions do
		local spawnPoint = positions[i]

		if not IsSpawnPointSafe(ply, spawnPoint, false) then continue end

		return spawnPoint
	end
end

-- https://github.com/TTT-2/TTT2/blob/master/lua/ttt2/libraries/spawn.lua#L234
function PLUGIN:PlayerLoadout(client)
	if (#PLUGIN.spawners > 0) then
		table.shuffle(PLUGIN.spawners)

		local position

		for i = 1, #PLUGIN.spawners do
			local v = PLUGIN.spawners[i]
			-- if (v.safezone) then // не делать проверку IsSpawnPointSafe т.к там нет коллизии у игроков
			-- если игрок мертв предложить меню спавна, переписав Spawn мету, дабы не восскреснуть или найти как не воскрешать

			if (IsSpawnPointSafe(client, v.position, false)) then
				position = v.position
				break
			end
		end

		if (position) then
			client:SetPos(position)
			return
		end

		for i = 1, #PLUGIN.spawners do
			position = GetSpawnPointsAroundSpawn(client, PLUGIN.spawners[i].position)

			if (position) then
				break
			end
		end

		if (position) then
			client:SetPos(position)
			return
		end
	end
end

function PLUGIN:LoadData()
	PLUGIN.spawners = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(PLUGIN.spawners)
end