SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "KRISS Vector"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Kriss USA Inc."
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Country = "	United States"
SWEP.Trivia_Year = "2009"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/vector.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/vector.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 24
SWEP.DamageMin = 9 -- damage done at maximum range
SWEP.Range = 70 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 25 -- DefaultClip is automatically set.

SWEP.Recoil = 0.9
SWEP.RecoilSide = 0.04
SWEP.RecoilRise = 0.02
SWEP.RecoilPunch = 0.6
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.065 -- 60 / RPM.
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
SWEP.HipDispersion = 370 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 250 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = ".45 ACP" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_VECTOR"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/vector.ogg"
SWEP.ShootSoundSilenced = "Firearms2_MP5k_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_pistol_cleric"

SWEP.ShellModel = "models/shells/45acp.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.13, -3.449, 1.52),
    Ang = Angle(0.5, -0.98, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.35

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "ar2"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-3.8, -3, 0.8)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(5.532, -2, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(5.532, -2, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 24


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
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(10, 0.4, -0.126),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.48, 1.48, 1.48),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(19.9, 0.8, -5.95),
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
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(10, 0.38, -0.126),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.48, 1.48, 1.48),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(19.9, 0.8, -5.98),
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
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(1, -0.34, 0.025),
            vang = Angle(-0.6, 0, -90),
            wpos = Vector(7, 0.68, -4.7),
            wang = Angle(-10.393, -2, 180)
        },
        ExtraSightDist = 1.8,
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0.004, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Canted Sight",
        Slot = "fas2_cantedsight",
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(3.5, -0.34, 0.01),
            vang = Angle(-1.5, 0, -90),
            wpos = Vector(10.8, 0.68, -5.35),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy_grip",
        Time = 20/40,
		ProcDraw = true,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster_grip",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "shoot_grip",
        Time = 31/35,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_scoped_grip",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload_grip",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch_SMG", t = 1.2},
		{s = "Firearms2.MP5_MagIn", t = 2.15},
		{s = "Firearms2.Cloth_Movement", t = 2.15},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty_grip",
        Time = 110/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.MP5_MagOut", t = 0.6},
        {s = "Firearms2.Cloth_Movement", t = 0.6},
        {s = "Firearms2.Magpouch_SMG", t = 1.2},
        {s = "Firearms2.MP5_MagIn", t = 2.15},
        {s = "Firearms2.Cloth_Movement", t = 2.15},
		{s = "Firearms2.MP5_BoltPull", t = 2.9},
		{s = "Firearms2.Cloth_Movement", t = 2.9},
        },
    },
}