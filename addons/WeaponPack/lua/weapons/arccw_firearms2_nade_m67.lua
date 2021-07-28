SWEP.Base = "arccw_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M67"
SWEP.Trivia_Class = "Hand Grenade"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Day & Zimmermann"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1968

SWEP.WorldModelOffset = {
	pos		=	Vector(3, 2, -1.7),
	ang		=	Angle(0, -50, 180),
	bone	=	"ValveBiped.Bip01_R_Hand",
    scale   =   1
}

SWEP.Slot = 4

SWEP.PullPinTime = 0.8

SWEP.NotForNPCs = true

SWEP.Disposable = true

SWEP.Singleton = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/fas2/view/explosives/m67.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/explosives/m67.mdl"
SWEP.ViewModelFOV = 55

SWEP.FuseTime = false

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1

SWEP.MuzzleVelocity = 1150
SWEP.ShootEntity = "arccw_firearms2_m67"

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 20/20,
		SoundTable = {
            {s = "Firearms2.Deploy", t = 0},
            {s = "Firearms2.M67_Safety", t = 0.5},
            }, 
    },
    ["ready"] = {
        Source = "deploy",
        Time = 20/20,
		SoundTable = {
            {s = "Firearms2.Deploy", t = 0},
            {s = "Firearms2.M67_Safety", t = 0.5},
            }, 
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["pre_throw_cook"] = {
        Source = "cook",
        Time = 120/30,
        SoundTable = {
            {s = "Firearms2.M67_PinPull", t = 0.2},
            {s = "Firearms2.M67_Spoon", t = 0.3},
            {s = "Firearms2.M67_Primer", t = 0.4},
            }, 
    },
    ["pre_throw"] = {
        Source = "prime",
        Time = 4,
        SoundTable = {
            {s = "Firearms2.M67_PinPull", t = 0.2},
            }, 
    },
    ["throw"] = {
        Source = "throw",
        Time = 20/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        SoundTable = {
            {s = "Firearms2.Cloth_Fast", t = 0},
            }, 
    }
}

function SWEP:Throw()
    if self:GetNextPrimaryFire() > CurTime() then return end

    self:SetNWBool("grenadeprimed", false)

    self:PlayAnimation("throw", 1, false, 0, true)

    local heldtime = (CurTime() - self.GrenadePrimeTime - self.PullPinTime)

    local windup = heldtime / 0.5

    windup = math.Clamp(windup, 0, 1)

    local mv = self.MuzzleVelocity * self:GetBuff_Mult("Mult_MuzzleVelocity")

    local force = Lerp(windup, mv * 0.4, mv)

    self:SetTimer(0.15, function()

        local rocket = self:FireRocket(self.ShootEntity, force)

        if !rocket then return end

        if self.FuseTime then
            rocket.FuseTime = self.FuseTime - heldtime
        end

        local phys = rocket:GetPhysicsObject()

        if GetConVar("arccw_throwinertia"):GetBool() and mv > 100 then
            phys:AddVelocity(self:GetOwner():GetVelocity())
        end

        phys:AddAngleVelocity( Vector(0, 750, 0) )

        self:TakePrimaryAmmo(1)

        if self:Clip1() == 0 and self:Ammo1() >= 1 and !self.Singleton then
            self:SetClip1(1)
            self:GetOwner():SetAmmo(self:Ammo1() - 1, self.Primary.Ammo)
        else
            timer.Simple(0.6, function()
                if IsValid(self) and IsValid(self:GetOwner()) then
                    self:GetOwner():StripWeapon(self:GetClass())
                end
            end)
        end
    end)
    self:SetTimer(self:GetAnimKeyTime("throw"), function()
        self:PlayAnimation("draw")
    end)

    self:SetNextPrimaryFire(CurTime() + 1)

    self:GetBuff_Hook("Hook_PostThrow")
end

function SWEP:FireRocket(ent, vel, ang)
    if CLIENT then return end

    local rocket = ents.Create(ent)

    ang = ang or self:GetOwner():EyeAngles()

    local src = self:GetShootSrc()

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. ent) return end

    local EA =  self.Owner:EyeAngles()
    src = src + EA:Right() * 5 - EA:Up() * -2 + EA:Forward() * 8

    rocket:SetAngles(ang)
    rocket:SetPos(src)

    rocket:SetOwner(self:GetOwner())
    rocket.Inflictor = self

    rocket:Spawn()
    rocket:Activate()
    rocket:GetPhysicsObject():SetVelocity(self:GetOwner():GetAbsVelocity())
    rocket:GetPhysicsObject():SetVelocityInstantaneous(ang:Forward() * vel)
    rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)

    if rocket.ArcCW_Killable == nil then
        rocket.ArcCW_Killable = true
    end

    rocket.ArcCWProjectile = true

    return rocket
end