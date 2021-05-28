AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/fence01a.mdl")
	self:PhysicsInit(6)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(6)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	-- Position correctly to wall
	timer.Simple(1, function()
		if (IsValid(self)) then
			local pos = self:GetPos()
			local tr = util.TraceLine({
				start = pos,
				endpos = pos - self:GetForward() * 10000,
				filter = self,
			})

			self:SetPos(tr.HitPos + tr.HitNormal * 0.04)
			self:SetAngles(tr.HitNormal:Angle())
		end
	end)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	self:DrawShadow(false)
end

function ENT:Use(activator)

end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:SpawnFunction(client, trace)
	local angles = (trace.HitPos - client:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local entity = ents.Create("gmodz_stash")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(angles)
	entity:Spawn()

	return entity
end