ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = ""
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/fas2/world/explosives/m84_thrown.mdl"
ENT.FuseTime = 2.5
ENT.ArmTime = 0
ENT.ImpactFuse = false
ENT.Armed = true

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
			self:EmitSound("fas2/m84/flashbang_hit1.wav", 75, 100)
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
        if self:WaterLevel() >= 1 then self:Remove() return end
        self:EmitSound("fas2/m84/flashbang_explode1.wav", 100, 100, 1, CHAN_ITEM)
        self:EmitSound("fas2/m84/flashbang_explode1_distant.wav", 160, 100, 1, CHAN_WEAPON)

		    pos = self:GetPos()
		    own = self:GetOwner()

        local effectdata = EffectData()
			        effectdata:SetOrigin( self:GetPos() )
			        ParticleEffect("explosion_flashbang", pos, Angle(0, 0, 0), nil)
                local targets = ents.FindInSphere(self:GetPos(), 1024)
                    for _, k in pairs(targets) do
            if k:IsPlayer() then
                local dp = (k:EyePos() - self:GetPos()):DotProduct(k:EyeAngles():Forward())
            if dp < 0.5 then
                local time = Lerp( self:GetPos():Distance(k:GetPos()) / 1024, 2.5, 0.25 )
                    if self:Visible( k ) then
                        k:ScreenFade( SCREENFADE.IN, Color( 255, 255, 255, 255 ), 2.5, time )
					    k:SetDSP( 37, false )
                    end
                end
            end
        end
        self:Remove()
    end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end