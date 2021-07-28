ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "RPG-26 HEAT"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

ENT.Misfired            = false


AddCSLuaFile()

ENT.Model = "models/weapons/fas2/world/explosives/rpg26/rocket.mdl"
ENT.Ticks = 0
ENT.FuseTime = 4.5

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
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
    end

    self.SpawnTime = CurTime()
    self.motorsound = CreateSound( self, "fas2/rpg26/rpg26_rocketloop.wav")
    self.motorsound:Play()

    timer.Simple(0, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:OnRemove()
    self.motorsound:Stop()
end

function ENT:Think()
    if SERVER then
        if self.SpawnTime + self.FuseTime <= CurTime() then
            self:Detonate()
        end
        ParticleEffectAttach( "m79_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
    end
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
        ParticleEffect( isbody and "explosion_m79_body" or "explosion_he_grenade", effectdata:GetOrigin(), Angle(-90, 0, math.random(0, 360)), nil)
        self:EmitSound("fas2/rpg26/rpg26_rockethit.wav", 100, 100, 1, CHAN_AUTO)
        self:EmitSound("fas2/rpg26/rpg26_rockethit_distance1.wav", 140, 100, 1, CHAN_WEAPON)
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
    local collent = colData.HitEntity
    self:Detonate( IsValid(collent) and ( collent:IsPlayer() or collent:IsNPC() ) )
    -- self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
    cam.Start3D() -- Start the 3D function so we can draw onto the screen.
        render.SetMaterial( Material("effects/fas_glow_debris") ) -- Tell render what material we want, in this case the flash from the gravgun
        render.DrawSprite( self:GetPos(), math.random(100, 200), math.random(100, 200), Color(255, 225, 175) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
    cam.End3D()
end