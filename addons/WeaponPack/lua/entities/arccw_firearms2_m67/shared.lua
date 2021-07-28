ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = ""
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/fas2/world/explosives/m67_thrown.mdl"
ENT.FuseTime = 3.5
ENT.ArmTime = 0
ENT.ImpactFuse = false

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_NONE)
        self:DrawShadow( true )
        self.NextImpact = 0

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()

        if self.FuseTime <= 0 then
            self:Detonate()
        end

        timer.Simple(0.1, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
    end
end

local vel, len

function ENT:PhysicsCollide(data, physobj)
    vel = physobj:GetVelocity()
    len = vel:Length()
        
    if len > 500 then
        physobj:SetVelocity(vel * 0.6)
    end
        
    if len > 100 then
            
        if CurTime() > self.NextImpact then
            self:EmitSound("weapons/hegrenade/he_bounce-1.wav", 75, 100)
            self.NextImpact = CurTime() + 0.1
        end
    end

    if (CurTime() - self.SpawnTime >= self.ArmTime) and self.ImpactFuse then
        self:Detonate()
    end
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:Detonate()
    if SERVER then
        if !self:IsValid() then return end
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() >= 1 then
            ParticleEffect("water_explosion_final", effectdata:GetOrigin(), Angle(0, 0, 0), nil)
            self:EmitSound("weapons/underwater_explode" .. math.random(3, 4) .. ".wav", 120, 100, 1, CHAN_AUTO)
        else
            ParticleEffect("explosion_he_grenade", effectdata:GetOrigin(), Angle(0, 0, 0), nil)
            self:EmitSound("fas2/m67/m67_explode_" .. math.random(1, 6) .. ".wav", 100, 100, 1, CHAN_AUTO)
            self:EmitSound("fas2/m67/m67_explode_1_distant.ogg", 140, 100, 1, CHAN_WEAPON)
        end

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end

        util.BlastDamage(self, attacker, self:GetPos(), 380, 100)
        util.BlastDamage(self, attacker, self:GetPos(), 770, 75)

        self:Remove()

    end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end