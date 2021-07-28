ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= ""
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

ENT.Misfired            = false

AddCSLuaFile()

ENT.Model = "models/weapons/fas2/world/explosives/m79_grenade_fly.mdl"

if SERVER then

    function ENT:Initialize()
        self:SetModel(self.Model)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_NONE)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        self.SpawnTime = CurTime()

        timer.Simple(0.1, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
        ParticleEffectAttach( "m79_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
    end

    function ENT:Think()
    end

    else

    function ENT:Think()
    end
end

function ENT:Detonate(isbody)
    if !self:IsValid() then return end
    local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )

    if self:WaterLevel() >= 1 then
        ParticleEffect("water_explosion_final", effectdata:GetOrigin(), Angle(0, 0, 0), nil)
        self:EmitSound("weapons/underwater_explode" .. math.random(3, 4) .. ".wav", 100, 100, 1, CHAN_AUTO)
    else
        ParticleEffect( isbody and "explosion_m79_body" or "explosion_m79", effectdata:GetOrigin(), Angle(-90, 0, math.random(0, 360)), nil)
        self:EmitSound("fas2/m79/m79_explode1.wav", 100, 100, 1, CHAN_AUTO)
        self:EmitSound("fas2/m79/m79_explode1_distant.ogg", 140, 100, 1, CHAN_WEAPON)
    end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    util.BlastDamage(self, attacker, self:GetPos(), 300, 100)
    util.BlastDamage(self, attacker, self:GetPos(), 770, 75)

    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if CurTime() > self.SpawnTime + 0.2 and not self.Misfired then
        local collent = colData.HitEntity
        self:Detonate( IsValid(collent) and ( collent:IsPlayer() or collent:IsNPC() ) )
    else
        if not self.Misfired then
            self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 80, 100)
            self.Misfired = true
        end
        self:StopParticles()
        SafeRemoveEntityDelayed(self, 10)
        
        vel = collider:GetVelocity()
        len = vel:Length()
        
        if len > 500 then
            collider:SetVelocity(vel * 0.6)
        end
    end
end

function ENT:Draw()
    self:DrawModel()
end