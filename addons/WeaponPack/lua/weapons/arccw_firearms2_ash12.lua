SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "ASH-12"
SWEP.Trivia_Class = "Bullpup Battle Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Izhmash"
SWEP.Trivia_Calibre = "12.7x55MM"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "2010"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/ash12.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/ash12.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 57
SWEP.DamageMin = 42 -- damage done at maximum range
SWEP.Range = 300 -- in METRES
SWEP.Penetration = 15
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 315 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.Recoil = 2.4
SWEP.RecoilSide = 0.7
SWEP.RecoilRise = 0.9
SWEP.RecoilPunch = 2
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.098 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 410 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "12.7x55MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_ASH12"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ash12.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_5"

SWEP.ShellModel = "models/shells/12_7x55mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Heavy
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.6
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-1.644, -2, 0.01),
    Ang = Angle(1, 0.02, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.4

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(2.532, -2.8, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(2.532, -2.8, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 29


SWEP.RejectAttachments = {
    ["fas2_scope_pso1"] = true
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "weapon_main",
        Offset = {
            vpos = Vector(0.025, 2.75, 1.52),
            vang = Angle(0, 270, 0),
            wpos = Vector(4.9, 0.62, -7.43),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 0.9,
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(1.5, 1.5, 1.5),
        CorrectivePos = Vector(0, -0.7, 0),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Tactical",
        Slot = "fas2_tactical",
        Bone = "weapon_main",
        Offset = {
            vpos = Vector(0.6, 7.1, -0.235),
            vang = Angle(0, 270, 270),
            wpos = Vector(14.1, 1.8, -5.45),
            wang = Angle(-10.393, 0, 90),
        },
        WMScale = Vector(1.8, 1.8, 1.8),
    },
}

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 55/30,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.ASH12_Cloth2", t = 0.1},
    --     {s = "Firearms2.ASH12_BoltBack", t = 0.65}
    --     },
    -- },
    ["draw"] = {
        Source = "deploy",
        Time = 26/34,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 18/34,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire1",
        Time = 18/36,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 10/36,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        Time = 10/36,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = {"reload", "reload2"},
        Time = 80/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.ASH12_Cloth2", t = 0},
		{s = "Firearms2.ASH12_MagOut", t = 0.4},
		{s = "Firearms2.ASH12_Cloth", t = 1.05},
		{s = "Firearms2.ASH12_MagIn", t = 1.5},
		{s = "Firearms2.ASH12_Cloth2", t = 2}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.ASH12_Cloth2", t = 0},
		{s = "Firearms2.ASH12_MagOut", t = 0.4},
		{s = "Firearms2.ASH12_Cloth", t = 1.05},
		{s = "Firearms2.ASH12_MagIn", t = 1.5},
		{s = "Firearms2.ASH12_Cloth2", t = 2},
		{s = "Firearms2.ASH12_BoltBack", t = 3.1},
		{s = "Firearms2.ASH12_BoltForward", t = 3.3},
		{s = "Firearms2.ASH12_Cloth", t = 3.6}
		},
    },
}