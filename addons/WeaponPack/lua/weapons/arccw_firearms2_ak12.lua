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
        ang = Angle(-1.33, 270.01, 0),
        fov = 13
    }
}

SWEP.PrintName = "AK-12"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Izhmash"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "2012"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/ak12.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/ak12.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 32
SWEP.DamageMin = 32 -- damage done at maximum range
SWEP.Range = 800 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 900 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.Recoil = 1.3
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.5
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.092307 -- 60 / RPM.
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

SWEP.Primary.Ammo = "5.45x39mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_AK12"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ak12.ogg"
SWEP.ShootSoundSilenced = "Firearms2_AK74_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_1bb"

SWEP.ShellModel = "models/shells/5_45x39mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.208, -3.875, 0.59),
    Ang = Angle(0.2, 0, 0),
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

SWEP.BarrelLength = 28

SWEP.RejectAttachments = {
    ["fas2_extra_anpeq2"] = true,
    ["fas2_scope_pso1"] = true
}

SWEP.AttachmentElements = {
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
                    pos = Vector(0, 17, 0.85),
                    ang = Angle(0, 270, 0),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(32.3, 0.67, -8.5),
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
                    pos = Vector(0, 17, 0.85),
                    ang = Angle(0, 270, 0),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(32.3, 0.67, -8.5),
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
        Bone = "ak_frame",
        Offset = {
            vpos = Vector(0, 2.95, 1.92),
            vang = Angle(0, 270, 0),
            wpos = Vector(7.72, 0.68, -5.99),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Canted Sight",
        Slot = "fas2_cantedsight",
        Bone = "ak_frame",
        Offset = {
            vpos = Vector(0, 5.9, 1.92), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 270, 0),
            wpos = Vector(13, 0.68, -6.85),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Tactical",
        Slot = "fas2_tactical",
        Bone = "ak_frame",
        Offset = {
            vpos = Vector(0, 8.6, 2),
            vang = Angle(0, 270, 0),
            wpos = Vector(17.8, 0.68, -7.9),
            wang = Angle(-10.393, 0, 180),
        },
        WMScale = Vector(1.8, 1.8, 1.8),
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
		{s = "Firearms2.AK74_MagOut", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.5},
		{s = "Firearms2.AK74_MagIn", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 130/36,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.AK74_MagOutEmpty", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.Magpouch", t = 1.15},
		{s = "Firearms2.AK74_MagIn", t = 1.85},
		{s = "Firearms2.Cloth_Movement", t = 1.85},
		{s = "Firearms2.AK74_BoltPull", t = 2.9},
		{s = "Firearms2.Cloth_Movement", t = 2.9}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 100/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.AK74_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1.2},
		{s = "Firearms2.AK74_MagIn", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 1.8}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 134/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.8},
		{s = "Firearms2.AK74_MagOutEmptyNomen", t = 1.5},
		{s = "Firearms2.Cloth_Movement", t = 1.5},
		{s = "Firearms2.AK74_MagIn", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 1.8},
		{s = "Firearms2.AK74_BoltPull", t = 2.5},
		{s = "Firearms2.Cloth_Movement", t = 2.5}
		},
    },
}