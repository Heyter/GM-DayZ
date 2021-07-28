SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "RPG-26"
SWEP.Trivia_Class = "Disposable Anti-Tank Rocket Launcher"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Bazalt"
SWEP.Trivia_Calibre = "72.5MM"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1985"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/explosives/rpg26.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/explosives/rpg26.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 0
SWEP.DamageMin = 0 -- damage done at maximum range
SWEP.Range = 250 -- in METRES
SWEP.Penetration = 20
SWEP.ShootEntity = "arccw_firearms2_rocket_fly" -- entity to fire, if any
SWEP.MuzzleVelocity = 120000

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.

SWEP.Recoil = 3
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 4.5
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.1 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "Tube",
    },
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "RPG 26 Rocket" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "Firearms2_RPG26"
SWEP.ShootDrySound = "" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/rpg26.ogg"

SWEP.MuzzleEffect = "muzzle_rockets"

SWEP.ShellModel = "models/weapons/arccw/fas2/explosives/w_m79_grenade_shell.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Heavy
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.65
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-2, -1, -1),
    Ang = Angle(0.65, -0.02, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.5

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(0, 0, 0)
SWEP.CrouchAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, -3, 1)
SWEP.SprintAng = Angle(-9.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(3.824, 0, -2.297)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 28

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "first_draw",
    --     Time = 125/30,
    --     SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.M24_Back", t = 0.7},
    --     {s = "Firearms2.M24_Back", t = 1.7},
    --     {s = "Firearms2.M67_PinPull", t = 2.4},
    --     {s = "Firearms2.Cloth_Movement", t = 3},
    --     },
    -- },
    ["draw"] = {
        Source = "draw",
        Time = 31/40,
		SoundTable = {
        {s = "Firearms2.Deploy", t = 0},
        },
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/40,
        SoundTable = {
        {s = "Firearms2.Holster", t = 0},
        },
    },
    ["fire"] = {
        Source = "fire",
        Time = 50/30,
    },
}

function SWEP:Reload()
end

SWEP.Hook_PostFireBullets = function(wep)
    timer.Simple(1.5, function()
        if not IsValid( wep ) then return end
        if wep:Clip1() == 0 and wep:Ammo1() >= 1 then
            wep:SetClip1(1)
            wep:GetOwner():SetAmmo(wep:Ammo1() - 1, wep.Primary.Ammo)
        else
            if SERVER then
            wep:GetOwner():StripWeapon(wep:GetClass())
            end
        end
    end)
end