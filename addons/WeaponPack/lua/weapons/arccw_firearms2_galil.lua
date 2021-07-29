SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "IMI Galil"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Israel Military Industries"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "Israel"
SWEP.Trivia_Year = "1972"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/galil.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/galil.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 29
SWEP.DamageMin = 29 -- damage done at maximum range
SWEP.Range = 300 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 950 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 35 -- DefaultClip is automatically set.

SWEP.Recoil = 1.55
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 0.07
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.08 -- 60 / RPM.
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
SWEP.HipDispersion = 340 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_GALIL"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/galil.ogg"
SWEP.ShootSoundSilenced = "Firearms2_SAKO95_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_6"

SWEP.ShellModel = "models/shells/5_56x45mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.983, -4.053, 0.455),
    Ang = Angle(-0.02, 0.07, 1),
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

SWEP.CrouchPos = Vector(-0.8, -2, -1.2)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(3, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3, -3, 0.5)
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
                Bone = "frame",
                Offset = {
                    pos = Vector(0, -0.52, 17.5),
                    ang = Angle(92, 0, 90),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(31.8, 0.55, -8.62),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.85, 1.85, 1.85),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Bone = "frame",
                Offset = {
                    pos = Vector(0, -0.52, 17.5),
                    ang = Angle(92, 0, 90),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(31.8, 0.55, -8.62),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.85, 1.85, 1.85),
            }
        },
    },
}

SWEP.Attachments = {
    -- {
    --     PrintName = "Mount",
    --     DefaultAttName = "Ironsight",
    --     Slot = {"fas2_sight", "fas2_scope", "fas2_scope_pso1"},
    --     Bone = "frame", 
    --     Offset = {
    --         vpos = Vector(0.13, -2.32, 1.4),
    --         vang = Angle(270.32, 181, 90),
    --         wpos = Vector(6.55, 0.6, -6.45),
    --         wang = Angle(-10.393, 0, 180)
    --     },
    --     ExtraSightDist = 1.6,
    --     WMScale = Vector(1.6, 1.6, 1.6),
    --     CorrectivePos = Vector(-0.001, 0, 0.053),
    --     CorrectiveAng = Angle(0, 0, 0)
    -- },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Skills",
        Slot = "fas2_nomen",
        Bone = "ak_frame",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 15/45,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_last_scoped",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 91/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SAKO95_MagOut", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.Magpouch", t = 1.5},
		{s = "Firearms2.SAKO95_MagIn", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SAKO95_MagOutEmpty", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.Magpouch", t = 1.15},
		{s = "Firearms2.SAKO95_MagIn", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		{s = "Firearms2.SAKO95_BoltBack", t = 3.2},
		{s = "Firearms2.Cloth_Movement", t = 3.2},
		{s = "Firearms2.SAKO95_BoltForward", t = 3.5}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 91/37.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SAKO95_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1.2},
		{s = "Firearms2.SAKO95_MagIn", t = 1.55},
		{s = "Firearms2.Cloth_Movement", t = 1.55}
		},
    },
    ["reload_empty_nomen"] = {
        Source = "reload_empty_nomen",
        Time = 120/37.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SAKO95_MagOutEmpty", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1.15},
		{s = "Firearms2.SAKO95_MagIn", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6},
		{s = "Firearms2.SAKO95_BoltBack", t = 2.6},
		{s = "Firearms2.Cloth_Movement", t = 2.6},
		{s = "Firearms2.SAKO95_BoltForward", t = 2.8},
		},
    },
}