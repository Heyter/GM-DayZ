local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}

local weaponsets = {
	weapon_rebel = {"weapon_pistol", "weapon_smg1", "weapon_ar2", "weapon_shotgun"},
	weapon_combine = {"weapon_smg1", "weapon_ar2", "weapon_shotgun"},
	weapon_citizen = {
		"weapon_citizenpackage",
		"weapon_citizensuitcase",
		"weapon_none",
	},
}

local function InternalSpawnNPC(
	Position,
	spawner,
	Equipment,
	NoDropToFloor
)

	local NPCList = list.Get("NPC")
	local NPCData = NPCList[spawner.npc]

	-- Don't let them spawn this entity if it isn't in our NPC Spawn list.
	-- We don't want them spawning any entity they like!
	if (!NPCData) then
		return
	end

	local bDropToFloor = true

	if (NPCData.NoDrop or NoDropToFloor) then
		bDropToFloor = false
	end

	--
	-- Offset the position
	--
	local Offset = NPCData.Offset or spawner.spawnheight or 32
	Position = Position + Vector(0, 0, Offset)

	if (!spawner.nocollide) then
		local data = {}
		data.start = Position
		data.endpos = data.start + vector_up
		data.filter = nil
		data.mins = Vector(-Offset, -Offset, 0)
		data.maxs = Vector(Offset, Offset, Offset)

		local trace = util.TraceHull(data)

		if (IsValid(trace.Entity)) then
			return
		end

		Position = data.endpos + Vector(0, 0, 25)
	end

	if (!util.IsInWorld(Position)) then
		return
	end

	-- Create NPC
	local NPC = ents.Create(NPCData.Class)
	if (!IsValid(NPC)) then
		return
	end

	NPC:SetPos(Position)

	-- Rotate to face player (expected behaviour)
	local Angles = spawner.angles

	if (!Angles) then
		Angles = angle_zero

		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180
	end

	if (NPCData.Rotate) then
		Angles = Angles + NPCData.Rotate
	end

	NPC:SetAngles(Angles)

	--
	-- This NPC has a special model we want to define
	--
	if (NPCData.Model) then
		NPC:SetModel(NPCData.Model)
	end

	--
	-- This NPC has a special texture we want to define
	--
	if (NPCData.Material) then
		NPC:SetMaterial(NPCData.Material)
	end

	--
	-- Spawn Flags
	--
	local SpawnFlags = spawner.flags
	if (NPCData.SpawnFlags) then
		SpawnFlags = bit.bor(SpawnFlags, NPCData.SpawnFlags)
	end
	if (NPCData.TotalSpawnFlags) then
		SpawnFlags = NPCData.TotalSpawnFlags
	end
	NPC:SetKeyValue("spawnflags", SpawnFlags)
	NPC.SpawnFlags = SpawnFlags

	--
	-- Optional Key Values
	--
	if (NPCData.KeyValues) then
		for k, v in pairs(NPCData.KeyValues) do
			NPC:SetKeyValue(k, v)
		end
	end

	--
	-- This NPC has a special skin we want to define
	--
	if (NPCData.Skin) then
		NPC:SetSkin(NPCData.Skin)
	end

	--
	-- What weapon should this mother be carrying
	--

	-- Check if this is a valid entity from the list, or the user is trying to fool us.
	local valid = false
	for _, v in pairs(list.Get("NPCUsableWeapons")) do
		if v.class == Equipment then
			valid = true
			break
		end
	end

	for _, v in pairs(NPCData.Weapons or {}) do
		if v == Equipment then
			valid = true
			break
		end
	end

	if (Equipment and Equipment ~= "none" and valid) then
		NPC:SetKeyValue("additionalequipment", Equipment)
		NPC.Equipment = Equipment
	end

	NPC:Spawn()
	NPC:Activate()

	-- For those NPCs that set their model in Spawn function
	-- We have to keep the call above for NPCs that want a model set by Spawn() time
	if (NPCData.Model and NPC:GetModel() ~= NPCData.Model) then
		NPC:SetModel(NPCData.Model)
	end

	if (bDropToFloor) then
		NPC:DropToFloor()
	end

	if (NPCData.Health) then
		NPC:SetHealth(NPCData.Health)
	end

	-- Body groups
	if (NPCData.BodyGroups) then
		for k, v in pairs(NPCData.BodyGroups) do
			NPC:SetBodygroup(k, v)
		end
	end

	return NPC
end

local function rand()
	return math.random() * 2 - 1
end

local ENT = {}
function ENT:GetSpawnLocation(position, radius)
--[[ 		local x = Vector(0, 0, 1)
	local y = Vector(1, 0, 0)
	local z = Vector(0, 1, 0) ]]
	return (position + Vector(radius * rand(), radius * rand(), 0))
end

function ENT:GetSpawnWeapon(weapon, class)
	local npcdata = list.Get("NPC")[class]

	if (weapon == "weapon_none" or weapon == "none") then
		weapon = nil
	elseif (weaponsets[weapon]) then
		weapon = table.Random(weaponsets[weapon])
	elseif (npcdata and npcdata.Weapons and (!weapon or weapon == "" or weapon == "weapon_default")) then
		weapon = table.Random(npcdata.Weapons)
	end

	return weapon
end

local nearDist = math.pow(3000, 2)
timer.Create("ixNPCSpawner", 5, 0, function()
	for k, v in ipairs(PLUGIN.spawners) do
		if (v.lastSpawned < os.time()) then
			v.lastSpawned = os.time() + (v.delay * 60)

			if (v.totalSpawnedNPCs >= v.maximum) then
				v.lastSpawned = os.time() + 90
				continue
			end

			local nearPlayer

			for _, v2 in ipairs(player.GetHumans()) do
				if (IsValid(v2) and v2:GetMoveType() != MOVETYPE_NOCLIP and v2:Alive() and v2:GetPos():DistToSqr(v.position) < nearDist) then
					nearPlayer = true
					break
				end
			end

			if (nearPlayer) then
				v.lastSpawned = os.time() + 60
				continue
			end

			local position = ENT:GetSpawnLocation(v.position, v.spawnradius)
			local npc = InternalSpawnNPC(position, v, ENT:GetSpawnWeapon(v.weapon, v.npc))

			if (!IsValid(npc)) then
				v.lastSpawned = os.time() + 60
				continue 
			end

			npc:CallOnRemove("NPCSpawnPlatform", function(t, index)
				index = index or t.SpawnerID

				if (PLUGIN.spawners[index] and PLUGIN.spawners[index].spawnedNPCs[t]) then
					PLUGIN.spawners[index].spawnedNPCs[t] = nil
					PLUGIN.spawners[index].totalSpawnedNPCs = math.max(0, PLUGIN.spawners[index].totalSpawnedNPCs - 1)
				end
			end, k)

			v.spawnedNPCs[npc] = true
			v.totalSpawnedNPCs = (v.totalSpawnedNPCs or 0) + 1

			local hp = npc:GetMaxHealth()
			local chp = npc:Health()

			-- Bug with nextbots
			if (chp > hp) then
				hp = chp
			end

			hp = hp * v.healthmul
			npc:SetMaxHealth(hp)
			npc:SetHealth(hp)

			if (npc.SetCurrentWeaponProficiency) then
				npc:SetCurrentWeaponProficiency(v.skill)
			end

			if (v.nocollide == true) then
				npc:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
			end

			npc:SetSpawnEffect(true)
			npc:DrawShadow(false)

			npc.KillReward = v.killreward
			npc.SpawnerID = k

			if (v.decrease > 0 and v.totalSpawnedNPCs % v.maximum == 0) then
				v.lastSpawned = v.lastSpawned - ( (math.max(0.1, v.delay - v.decrease) * 60 ) )
			end
		end
	end
end)

function PLUGIN:LoadData()
	PLUGIN.spawners = self:GetData() or {}

	// Здесь статичные зоны

	for _, v in pairs(PLUGIN.spawners) do
		v.totalSpawnedNPCs = 0

		for ent in pairs(v.spawnedNPCs or {}) do
			if (IsValid(ent) and !ent:IsPlayer()) then
				ent:Remove()
			end
		end

		v.spawnedNPCs = {}
		v.lastSpawned = os.time() + (v.delay * 60)
	end
end

function PLUGIN:SaveData()
	self:SetData(PLUGIN.spawners)
end