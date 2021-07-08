AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:Wake()
	end

	self.DieTime = CurTime() + 2.5
end

function ENT:Think()
	if (self.DieTime < CurTime()) then
		self:Explode()
	end
end

function ENT:Explode()
	local pos = self:GetPos()
	local data = self.Data

	if (data) then
		pos = pos - data.HitNormal * 24
	end

	local effect = EffectData()
		effect:SetOrigin(pos)
	util.Effect("Explosion", effect)

	if (IsValid(self:GetOwner())) then
		util.BlastDamage(self, self:GetOwner(), pos, self.Radius, self.Damage)
	else
		util.BlastDamage(self, Entity(0), pos, self.Radius, self.Damage)
	end

	util.ScreenShake(pos, 10, 2, 0.4, self.Radius + 200)

	self:EmitSound(self.Sound, 120)
	self:Remove()
end

function ENT:PhysicsCollide(data, physObj)
	self.Data = data

	if (physObj:GetVelocity():Length() >= 100) then
		self:EmitSound("weapons/hegrenade/he_bounce-1.wav")
	end
end