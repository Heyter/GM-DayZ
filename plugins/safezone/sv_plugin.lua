local PLUGIN = PLUGIN

function PLUGIN:LoadData()
	SH_SZ.SafeZones = self:GetData() or {}

	for _, sz in pairs(SH_SZ.SafeZones) do
		local shape = SH_SZ.ShapesIndex[sz.shape]
		if (!shape) then
			return end

		SH_SZ:CreateSafeZone(sz, shape)
	end
end

function PLUGIN:SaveData()
	self:SetData(SH_SZ.SafeZones)
end

function PLUGIN:CanPlayerEnterSafeZone(entity, activator)
	if (!activator:CanEnterSafe() or activator:GetPVPTime() > CurTime()) then
		local dir = (entity:GetPos() - activator:GetPos()):GetNormalized()
		activator:SetVelocity(dir * -100)

		return false
	end
end

function PLUGIN:PlayerExitSafeZone(client)
	client.protection_time = CurTime() + 10
	client:SetNoCollideWithTeammates(false)
	client:SetAvoidPlayers(true)
	-- client:SetCollisionGroup(COLLISION_GROUP_PLAYER)
end

function PLUGIN:PlayerEnterSafeZone(client)
	-- client:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	client:SetNoCollideWithTeammates(true)
	client:SetAvoidPlayers(false)

	if (self.collides[client]) then
		self.collides[client] = nil
	end
end

function PLUGIN:PlayerSpawn(client)
	client:SetNoCollideWithTeammates(false)
	client:SetAvoidPlayers(true)

	if (self.collides[client]) then
		self.collides[client] = nil
	end
end

-- идиотский ShouldCollide крашит физику, пришлось костыль сделать.
PLUGIN.collides = PLUGIN.collides or {}
timer.Create("StuckPlayers", 0.5, 0, function()
	for _, v in ipairs(player.GetAll()) do
		if (IsValid(v) and !PLUGIN.collides[v] and v:Alive() and v:GetMoveType() == MOVETYPE_WALK and v:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE and v:IsStuck()) then
			v:SetNoCollideWithTeammates(true)
			v:SetAvoidPlayers(true)
			PLUGIN.collides[v] = true
		end
	end

	if (table.IsEmpty(PLUGIN.collides)) then return end

	for k in pairs(PLUGIN.collides) do
		if (IsValid(k) and k:Alive() and k:GetMoveType() == MOVETYPE_WALK and k:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
			if (!k:IsStuck()) then
				k:SetNoCollideWithTeammates(false)
				PLUGIN.collides[k] = nil
			end
		else
			PLUGIN.collides[k] = nil
		end
	end
end)