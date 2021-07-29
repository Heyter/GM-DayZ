SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "SG 552"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Swiss Arms AG"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "Switzerland"
SWEP.Trivia_Year = "1998"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/sg552.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/sg552.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 33
SWEP.DamageMin = 33 -- damage done at maximum range
SWEP.Range = 300 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 730 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 30

SWEP.Recoil = 1.85
SWEP.RecoilSide = 0.18
SWEP.RecoilRise = 0.03
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.0857 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
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

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "Firearms2_SG552"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/sg552.ogg"
SWEP.ShootSoundSilenced = "Firearms2_SG552_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_FAMAS"

SWEP.ShellModel = "models/shells/5_56x45mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.649, -2.757, 0.463),
    Ang = Angle(0.35, 0.01, 0),
    Magnification = 1.2,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.35

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-0.4, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -2, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -2, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(3.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["30rnd"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "weapon_main",
                Offset = {
                    pos = Vector(0, 9, 0.32),
                    ang = Angle(0, -90, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(20.5, 0.7, -6.7),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Bone = "weapon_main",
                Offset = {
                    pos = Vector(0, 9, 0.33),
                    ang = Angle(0, -90, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(20.5, 0.7, -6.7),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "weapon_main", 
        Offset = {
            vpos = Vector(0.012, 1.2, 1.33),
            vang = Angle(0, 270, 0),
            wpos = Vector(7.6, 0.7, -6.08),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 1.7,
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = {"fas2_sg55x_30rnd"}
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 33/34,
		SoundTable = {
            {s = "Firearms2.Deploy", t = 0},
            {s = "Firearms2.Cloth_Movement", t = 0.3},
            },
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 33/34,
		SoundTable = {
            {s = "Firearms2.Deploy", t = 0},
            {s = "Firearms2.Cloth_Movement", t = 0.3},
            },
    },
    -- ["ready"] = {
    --     Source = "draw",
    --     Time = 136/32,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --         {s = "Firearms2.Deploy", t = 0},
    --         {s = "Firearms2.Magpouch", t = 0.5},
    --         {s = "Firearms2.Cloth_Movement", t = 0.69},
    --         {s = "Firearms2.SG550_MagIn", t = 1.5},
    --         {s = "Firearms2.Cloth_Movement", t = 1.75},
    --         {s = "Firearms2.SG550_BoltBack", t = 2.45},
    --         {s = "Firearms2.Cloth_Movement", t = 2.56},
    --         {s = "Firearms2.SG550_BoltForward", t = 2.8},
    --         {s = "Firearms2.Cloth_Movement", t = 3.6},
    --         },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 22/34,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 22/34,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire", "fire2", "fire3"},
        Time = 20/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 20/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire_scoped", "fire_scoped2", "fire_scoped3"},
        Time = 10/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_scoped_last",
        Time = 10/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 110/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Firemode_Switch", t = 0.39},
		{s = "Firearms2.SG550_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.68},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SG550_MagIn", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 2.61},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 140/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Firemode_Switch", t = 0.39},
		{s = "Firearms2.SG550_MagOutEmpty", t = 0.65},
        {s = "Firearms2.Cloth_Movement", t = 0.68},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SG550_MagIn", t = 2.1},
		{s = "Firearms2.Cloth_Movement", t = 2.55},
		{s = "Firearms2.SG550_BoltForward", t = 2.86},
		{s = "Firearms2.Cloth_Movement", t = 3.43}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 89/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.Firemode_Switch", t = 0.55},
		{s = "Firearms2.SG550_MagOut", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SG550_MagIn", t = 1.25},
		{s = "Firearms2.Cloth_Movement", t = 1.28},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 100/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.Firemode_Switch", t = 0.55},
		{s = "Firearms2.SG550_MagOutEmpty", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SG550_MagIn", t = 1.25},
		{s = "Firearms2.Cloth_Movement", t = 1.28},
		{s = "Firearms2.SG550_BoltForward", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 2.29},
		},
    },
}