ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Smoke Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/fas2/world/explosives/m18_thrown.mdl"
ENT.FuseTime = 3.5
ENT.ArmTime = 0
ENT.ImpactFuse = false

ENT.Detonated = false

ENT.SmokeDuration = 18

ENT.RemoveTime = 30

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( true )
        self.NextImpact = 0

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()

        timer.Simple(0.1, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
    end
end

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	vel = physobj:GetVelocity()
	len = vel:Length()
	
	if len > 500 then
		physobj:SetVelocity(vel * 0.6)
	end
	
	if len > 100 then
		CT = CurTime()
		
		if CT > self.NextImpact then
			self:EmitSound("weapons/smokegrenade/grenade_hit1.wav", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end

    if (CurTime() - self.SpawnTime >= self.ArmTime) and self.ImpactFuse then
        self:Detonate()
    end
end

function ENT:Think()
    if ( not self.Detonated ) and SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
    if self.Detonated and SERVER and CurTime() - self.SpawnTime >= self.RemoveTime then 
        -- if self:IsValid() then self:Remove() 
        -- end
        SafeRemoveEntity( self )
    end
end

function ENT:Detonate()
		if self:IsValid() then
        -- local hitPos = self:GetPos()

        local cloud = ents.Create( "arccw_firearms2_m18_impact" )
		-- cloud:SetPos(hitPos)
        cloud:SetParent( self )
		cloud:Spawn()
        cloud:CreateParticles()

        self.Detonated = true
        
        timer.Simple( self.SmokeDuration, function() 
            SafeRemoveEntity( cloud )
            if self:IsValid() then self:StopParticles() end
            -- if self:IsValid() then self:Remove() end
        end )

        -- self:Remove()
	end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end