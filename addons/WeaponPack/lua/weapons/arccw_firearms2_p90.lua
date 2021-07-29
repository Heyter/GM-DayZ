SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "FN P90"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "FN Herstal"
SWEP.Trivia_Calibre = "5.7x28MM"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = "1990"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/p90.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/p90.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 25
SWEP.DamageMin = 25 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 715 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.Recoil = 1.7
SWEP.RecoilSide = 0.18
SWEP.RecoilRise = 0.17
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.0666 -- 60 / RPM.
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
SWEP.HipDispersion = 390 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.7x28MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_P90"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/p90.ogg"
SWEP.ShootSoundSilenced = "Firearms2_P90_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_4bb"

SWEP.ShellModel = "models/shells/5_7x28mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.198, -3.646, 0.05),
    Ang = Angle(0.4, 0.01, 0),
    Magnification = 1.2 ,
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

SWEP.CrouchPos = Vector(-1, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(2, -2.5, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(2, -2.5, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(2.824, 0, -0.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 23

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
                Bone = "body",
                Offset = {
                    pos = Vector(-0.07, -5.9, -0.01),
                    ang = Angle(0, 90, -90),
                },
                Scale = Vector(1.25, 1.25, 1.25),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(14.7, 0.8, -4.7),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(2.25, 2.25, 2.25),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Bone = "body",
                Offset = {
                    pos = Vector(-0.07, -5.9, 0),
                    ang = Angle(0, 90, -90),
                },
                Scale = Vector(1.55, 1.55, 1.55),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(14.7, 0.8, -4.7),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(2.7, 2.7, 2.7),
            }
        },
    },
}

SWEP.Attachments = {
    -- {
    --     PrintName = "Mount",
    --     DefaultAttName = "Ironsight",
    --     Slot = {"fas2_sight", "fas2_scope"},
    --     Bone = "body",
    --     Offset = {
    --         vpos = Vector(-2.08, -1.4, -0),
    --         vang = Angle(180, 90, 90),
    --         wpos = Vector(5.8, 0.75, -7),
    --         wang = Angle(-10.393, 0, 180)
    --     },
    --     ExtraSightDist = 1.5,
    --     WMScale = Vector(1.8, 1.8, 1.8),
    --     CorrectivePos = Vector(0, -4.7, -0.4),
    --     CorrectiveAng = Angle(0, 180, 180)
    -- },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
        Bone = "body",
    },
    {
        PrintName = "Tactical",
        Slot = "fas2_tactical",
        Bone = "body",
        Offset = {
            vpos = Vector(-1.75, -2.5, 0.428),
            vang = Angle(0, 90, 0),
            wpos = Vector(7.8, 0.0, -6.65),
            wang = Angle(-10.393, 0, 270),
        },
        WMScale = Vector(1.8, 1.8, 1.8),
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 32/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 14/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 14/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 110/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0.01},
		{s = "Firearms2.P90_BoltForward", t = 0.45},
		{s = "Firearms2.P90_MagOut", t = 0.7},
		{s = "Firearms2.P90_MagDraw", t = 1.1},
		{s = "Firearms2.P90_MagIn", t = 1.6},
		{s = "Firearms2.P90_MagHit", t = 1.85}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 150/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0.01},
        {s = "Firearms2.P90_BoltForward", t = 0.45},
        {s = "Firearms2.P90_MagOut", t = 0.7},
        {s = "Firearms2.P90_MagDraw", t = 1.1},
        {s = "Firearms2.P90_MagIn", t = 1.6},
        {s = "Firearms2.P90_MagHit", t = 1.85},
        {s = "Firearms2.P90_BoltBack", t = 2.7},
        {s = "Firearms2.P90_BoltForward", t = 3}
        },
    },
}