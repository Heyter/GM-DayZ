SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "PP-19 Bizon"
SWEP.Trivia_Class = "Machine pistol"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Izhmash"
SWEP.Trivia_Calibre = "9x18MM"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "1996"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/bizon.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/bizon.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 20
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 320 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.Recoil = 1.25
SWEP.RecoilSide = 0.04
SWEP.RecoilRise = 0.02
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.085 -- 60 / RPM.
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
SWEP.HipDispersion = 420 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x18MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_PP19"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/pp19.ogg"
SWEP.ShootSoundSilenced = "Firearms2_PP19_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_smg_bizon"

SWEP.ShellModel = "models/shells/9x18mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.742, -1.5, 0.388),
    Ang = Angle(0, 0.03, 0),
    Magnification = 1.1,
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

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(3, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3, -3, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.2, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 26

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Bone = "Framebone",
                Offset = {
                    pos = Vector(0, -0.37, 7.95),
                    ang = Angle(90, 0, 270),
                },
                Scale = Vector(1, 1, 1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(20.55, 0.7, -6.35),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.9, 1.9, 1.9),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Bone = "Framebone",
                Offset = {
                    pos = Vector(0, -0.385, 7.95),
                    ang = Angle(90, 0, 270),
                },
                Scale = Vector(1, 1, 1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(20.55, 0.67, -6.37),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.9, 1.9, 1.9),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight"},
        -- Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Framebone",
        Offset = {
            vpos = Vector(0, -1.46, 0.1),
            vang = Angle(90, 0, 270),
            wpos = Vector(5.5, 0.66, -5.8),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        VMScale = Vector(0.9, 0.9, 0.9),
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0.003, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
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
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 31/90,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 31/90,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 40/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_ironsight",
        Time = 20/35,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 109/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.PP19_MagOut", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.5},
		{s = "Firearms2.PP19_MagLatch", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		{s = "Firearms2.PP19_MagIn", t = 2.6},
		{s = "Firearms2.Cloth_Movement", t = 2.6},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 155/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.PP19_MagOutEmpty", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6},
		{s = "Firearms2.Magpouch", t = 2.1},
		{s = "Firearms2.PP19_MagLatch", t = 2.5},
		{s = "Firearms2.Cloth_Movement", t = 2.5},
		{s = "Firearms2.PP19_MagIn", t = 3.1},
		{s = "Firearms2.Cloth_Movement", t = 3.1},
		{s = "Firearms2.PP19_BoltPull", t = 4.1},
		{s = "Firearms2.Cloth_Movement", t = 4.1},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 110/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.PP19_MagOut", t = 0.425},
		{s = "Firearms2.Cloth_Movement", t = 0.425},
		{s = "Firearms2.Magpouch", t = 1.15},
		{s = "Firearms2.PP19_MagLatch", t = 1.525},
		{s = "Firearms2.Cloth_Movement", t = 1.525},
		{s = "Firearms2.PP19_MagIn", t = 1.95},
		{s = "Firearms2.Cloth_Movement", t = 1.95},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 140/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.PP19_MagOut", t = 0.425},
        {s = "Firearms2.Cloth_Movement", t = 0.425},
        {s = "Firearms2.Magpouch", t = 1.15},
        {s = "Firearms2.PP19_MagLatch", t = 1.475},
        {s = "Firearms2.Cloth_Movement", t = 1.475},
        {s = "Firearms2.PP19_MagIn", t = 1.95},
        {s = "Firearms2.Cloth_Movement", t = 1.95},
        {s = "Firearms2.PP19_BoltPull", t = 2.675},
        {s = "Firearms2.Cloth_Movement", t = 2.675},
        },
    },
}