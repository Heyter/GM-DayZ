AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local spd, ent

function ENT:Initialize()
	self:SetModel("models/Items/AR2_Grenade.mdl") 
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	timer.Simple(self.SmokeDuration, function()
		SafeRemoveEntity(self)
	end)
end

function ENT:CreateParticles()
	self:GetParent():EmitSound("fas2/m18/smoke.wav", 90, 100, 1, CHAN_AUTO)
	ParticleEffectAttach( "smoke_grenade_smoke", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), 0 )
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	self:StopParticles()
	return false
end 