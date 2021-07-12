local PLUGIN = PLUGIN
util.AddNetworkString("ixPlayerDeathMenu")
util.AddNetworkString("ixPlayerSpawnerSync")

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
local angle_180 = Angle(0, 180, 0)
function PLUGIN:PlayerLoadout(client)
	if (client:GetCharacter() and !client:GetCharacter():GetData("pos") and #PLUGIN.spawners > 0) then
		if (!client.spawnInSafezone) then table.shuffle(PLUGIN.spawners) end

		local position

		for i = 1, #PLUGIN.spawners do
			local v = PLUGIN.spawners[i]

			if (client.spawnInSafezone) then
				if (!v.safezone) then continue end

				position = v.position
				break
			else
				if (!v.safezone and IsSpawnPointSafe(client, v.position, false)) then
					position = v.position
					break
				end
			end
		end

		if (position) then
			self:ResetPlayer(client)
			client:SetPos(position)
			client:SetEyeAngles(angle_180)
			return
		end

		for i = 1, #PLUGIN.spawners do
			position = GetSpawnPointsAroundSpawn(client, PLUGIN.spawners[i].position)

			if (position) then
				break
			end
		end

		if (position) then
			self:ResetPlayer(client)
			client:SetPos(position)
			client:SetEyeAngles(angle_180)
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

--[[ RE-SPAWN MENU ]]
function PLUGIN:DoPlayerDeath(client)
	client.deathSpawn = nil

	if (client:GetCharacter()) then
		client:GetCharacter():SetData("pos", nil, true)
	end
end

function PLUGIN:CanPlayerDeathThink(client)
	return client.deathSpawn
end

function PLUGIN:ResetPlayer(client)
	client.spawnInSafezone = nil
	client.deathSpawn = nil
	client.deathTime = nil
end

net.Receive("ixPlayerDeathMenu", function(_, client)
	if ((client.ixPlayerDeathMenu or 0) < CurTime()) then
		client.ixPlayerDeathMenu = CurTime() + 1
	else
		return
	end

	if (client:GetCharacter() and !client:Alive() and !client.deathSpawn and client.deathTime and client.deathTime <= CurTime()) then
		if (net.ReadBool()) then
			client.spawnInSafezone = true
		else
			client.spawnInSafezone = nil
		end

		client.deathSpawn = true
	end
end)
--[[ RE-SPAWN MENU END ]]

--[[ Spawn Saver by Chessnut ( Saves the position of a character. ) ]]
-- Called right before the character has its information save.
function PLUGIN:CharacterPreSave(character)
	-- Get the player from the character.
	local client = character:GetPlayer()

	-- Check to see if we can get the player's position.
	if (IsValid(client)) then
		if (client.bNotSavePosition or !client:Alive()) then
			character:SetData("pos", nil, true)
			client.bNotSavePosition = nil
			return
		end

		local position, eyeAngles = client:GetPos(), client:EyeAngles()
		-- Use pre-observer position to prevent spawning in the air.
		if (client.ixObsData) then
			position, eyeAngles = client.ixObsData[1], client.ixObsData[2]
		end
		-- Store the position in the character's data.
		character:SetData("pos", {position, eyeAngles, game.GetMap()}, true)
	end
end

-- Called after the player's loadout has been set.
function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	timer.Simple(0, function()
		if (IsValid(client)) then
			self:ResetPlayer(client)

			-- Get the saved position from the character data.
			local position = character:GetData("pos")

			-- Check if the position was set.
			if (position) then
				if (position[3] and position[3]:lower() == game.GetMap():lower()) then
					-- Restore the player to that position.
					client:SetPos(position[1].x and position[1] or client:GetPos())
					client:SetEyeAngles(position[2].p and position[2] or angle_zero)
				end

				-- Remove the position data since it is no longer needed.
				character:SetData("pos", nil, true)
			end
		end
	end)
end