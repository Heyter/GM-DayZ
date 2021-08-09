SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.ItemData = {
    width = 2,
    height = 1,
    JamCapacity = 200,
    DegradeRate = 0.02,
    price = 200,
    rarity = { weight = 1 },
    iconCam = {
        pos = Vector(0, 200, 0),
        ang = Angle(-1.46, 271, 0),
        fov = 12.1
    }
}

SWEP.PrintName = "AK-104"
SWEP.Trivia_Class = "Carbine"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Kalashnikov Concern"
SWEP.Trivia_Calibre = "7.62x39MM"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "1994"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/ak104.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/ak104.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 37
SWEP.DamageMin = 37 -- damage done at maximum range
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 670 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.Recoil = 1.95
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.8
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.095 -- 60 / RPM.
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
SWEP.HipDispersion = 470 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x39mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_AK104"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ak104.ogg"
SWEP.ShootSoundSilenced = "Firearms2_AK104_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_3bb"

SWEP.ShellModel = "models/shells/7_62x39mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.195, -4.65, 0.74),
    Ang = Angle(-0.3, 0.03, 0),
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

SWEP.CrouchPos = Vector(-3.8, -3, 0)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -4, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -4, 0)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 25

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
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "ak_frame",
                Offset = {
                    pos = Vector(0, 14.8, 0.9),
                    ang = Angle(0, 270, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(27, 0.67, -8),
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
                Bone = "ak_frame",
                Offset = {
                    pos = Vector(0, 14.8, 0.9),
                    ang = Angle(0, 270, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(27, 0.67, -8),
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
        Slot = {"fas2_sight", "fas2_scope", "fas2_scope_pso1"},
        Bone = "ak_frame",
        Offset = {
            vpos = Vector(-0.04, 1.77, 2.25),
            vang = Angle(0, 270, 0),
            wpos = Vector(6, 0.68, -6.4),
            wang = Angle(-10.393, 0, 180)
        },
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
        PrintName = "Skills",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 49/70,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["ready"] = {
        Source = "deploy",
        Time = 49/70,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 36/90,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 60/40,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 10/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 112/36,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.AK101_MagOut", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.5},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		{s = "Firearms2.AK101_MagIn", t = 1.9}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 130/36,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.Cloth_Movement", t = 0.7},
            {s = "Firearms2.AK101_MagOut", t = 0.7},
            {s = "Firearms2.Magpouch", t = 1.15},
            {s = "Firearms2.Cloth_Movement", t = 1.85},
            {s = "Firearms2.AK101_MagIn", t = 1.85},
            {s = "Firearms2.Cloth_Movement", t = 2.9},
            {s = "Firearms2.AK101_BoltPull", t = 2.9}
            },
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 100/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.AK101_MagOut", t = 0.6},
            {s = "Firearms2.Cloth_Movement", t = 0.6},
            {s = "Firearms2.Magpouch", t = 1.2},
            {s = "Firearms2.AK101_MagIn", t = 1.8},
            {s = "Firearms2.Cloth_Movement", t = 1.8},
            },
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 134/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.Magpouch", t = 0.8},
            {s = "Firearms2.AK101_MagOut", t = 1.5},
            {s = "Firearms2.Cloth_Movement", t = 1.5},
            {s = "Firearms2.AK101_MagIn", t = 1.8},
            {s = "Firearms2.Cloth_Movement", t = 1.8},
            {s = "Firearms2.AK101_BoltPull", t = 2.5},
            {s = "Firearms2.Cloth_Movement", t = 2.5}
            },
    },
}