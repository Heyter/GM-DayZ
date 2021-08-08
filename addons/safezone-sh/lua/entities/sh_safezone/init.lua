AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:OnRemove()
	for k, v in pairs(self.m_Entities) do
		if (IsValid(v)) then
			self:EndTouch(v)
		end
	end
end

function ENT:Think()
	for k, v in pairs(self.m_Players) do
		if (!IsValid(v)) then
			self.m_Players[k] = nil
		end
	end

	for k, v in pairs(self.m_Entities) do
		if (!IsValid(v)) then
			self.m_Entities[k] = nil
		end
	end

	self:NextThink(CurTime() + 0.1)
	return true
end

function ENT:Touch(ent)
	if (!IsValid(ent) or ent.IsZone) then
		return end

	if (!self:PassesZoneFilter(ent)) then
		if (self.m_Entities[tostring(ent)]) then
			self:EndTouch(ent)
		end

		return
	end

	if (self.m_Entities[tostring(ent)]) then
		return end

	if (ent:IsPlayer() and ent:Alive()) then
		if (hook.Run("CanPlayerEnterSafeZone", self, ent) == false) then
			return
		end

		self.m_Players[ent:SteamID()] = ent
	end

	self.m_Entities[tostring(ent)] = ent

	self:OnZoneEntered(ent)
end

function ENT:EndTouch(ent)
	local call = false

	if (ent:IsPlayer()) then
		call = self.m_Players[ent:SteamID()] ~= nil
		self.m_Players[ent:SteamID()] = nil
	end

	if (self.m_Entities[tostring(ent)]) then
		call = true
		self.m_Entities[tostring(ent)] = nil
	end

	if (call) then
		self:OnZoneExited(ent)
	end
end

function ENT:OnZoneEntered(ent)
	if (ent:IsPlayer()) then
		SH_SZ:EnterSafeZone(ent, self)
	end

	if (ent:IsNPC() and self.m_Options.nonpc) then
		SafeRemoveEntity(ent)
	elseif (ent:IsVehicle()) then
		local driver = ent:GetDriver()
		if (!IsValid(driver) or !CAMI.PlayerHasAccess(driver, "Safezone - edit", nil)) then
			if (IsValid(driver)) then
				driver:ExitVehicle()
			end

			SafeRemoveEntity(ent)
		end
	elseif (ent.SH_SpawnedBy) then
		local owner = ent.SH_SpawnedBy
		if (self.m_Options.noprop and not (IsValid(owner) and CAMI.PlayerHasAccess(owner, "Safezone - edit", nil))) then
			SafeRemoveEntity(ent)
		end
	end
end

function ENT:OnZoneExited(ent)
	if (ent:IsPlayer()) then
		SH_SZ:ExitSafeZone(ent, self)
	end
end

function ENT:PassesZoneFilter(ent)
	if (self.m_Shape == "sphere") then
		local pos = ent:GetPos():Distance(self:GetPos())
		return pos <= self.m_fSize
	end

	return true
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end