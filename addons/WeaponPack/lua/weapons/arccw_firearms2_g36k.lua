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
        ang = Angle(-1.6, 270.55, 0),
        fov = 12
    }
}

SWEP.PrintName = "G36K"
SWEP.Trivia_Class = "Carbine"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "German"
SWEP.Trivia_Year = "1997"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/g36k.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/g36k.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 30
SWEP.DamageMin = 30 -- damage done at maximum range
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 850 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.Recoil = 1.4
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.105 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -2,
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
SWEP.HipDispersion = 395 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_G36K"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/g36k.ogg"
SWEP.ShootSoundSilenced = "Firearms2_G36K_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_4"

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
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0),
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

SWEP.HolsterPos = Vector(3.532, -4, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3.532, -4, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.297)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(14.3, -0.05, 0),
                    ang = Angle(0, 0, 90),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(27.4, 0.67, -8.1),
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
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(14.3, -0.05, 0),
                    ang = Angle(0, 0, 90),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(27.4, 0.67, -8.1),
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
        DefaultAttName = "",
        Slot = "firearms2_g36k",
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(-0.766, -1.8505, 0),
            vang = Angle(0, 0, 270),
            wpos = Vector(4.1, 0.68, -7),
            wang = Angle(-10.393, 0, 180)
        },
        Installed = "fas2_scope_g36k",
        Integral = true,
        VMScale = Vector(1.01, 1.01, 1.01),
        CorrectivePos = Vector(0, 19, 0),
        CorrectiveAng = Angle(0, 0, 0),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
        Bone = "Dummy01",
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
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 90/30,
	-- 	SoundTable = {
    --         {s = "Firearms2.Cloth_Movement", t = 0},
    --         {s = "Firearms2.G36K_BoltHandle", t = 0.6},
    --         {s = "Firearms2.G36K_BoltBack", t = 0.9},
    --         {s = "Firearms2.Cloth_Movement", t = 0.9},
    --         {s = "Firearms2.G36K_BoltForward", t = 1.2},
    --         {s = "Firearms2.G36_Stock", t = 1.6},
    --         {s = "Firearms2.Cloth_Movement", t = 1.6},
    --         {s = "Firearms2.Cloth_Movement", t = 1.93},
    --         {s = "Firearms2.Firemode_Switch", t = 2.63},
    --         },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3"},
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire1_scoped", "fire2_scoped", "fire3_scoped"},
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_last_scoped",
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 65/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.G36K_MagOut", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.Magpouch", t = 1.2},
		{s = "Firearms2.G36K_MagIn", t = 1.5},
		{s = "Firearms2.Cloth_Movement", t = 1.5}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.G36K_MagOut", t = 0.3},
            {s = "Firearms2.Cloth_Movement", t = 0.3},
            {s = "Firearms2.Magpouch", t = 1.15},
            {s = "Firearms2.G36K_MagIn", t = 1.5},
            {s = "Firearms2.Cloth_Movement", t = 1.5},
            {s = "Firearms2.G36K_BoltBack", t = 2.1},
            {s = "Firearms2.Cloth_Movement", t = 2.3},
            {s = "Firearms2.G36K_BoltForward", t = 2.3}
            },
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 50/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.G36K_MagOut", t = 0.25},
            {s = "Firearms2.Cloth_Movement", t = 0.25},
            {s = "Firearms2.Magpouch", t = 0.75},
            {s = "Firearms2.G36K_MagIn", t = 1.15},
            {s = "Firearms2.Cloth_Movement", t = 1.15},
            },
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 67/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.G36K_MagOut", t = 0.3},
            {s = "Firearms2.Cloth_Movement", t = 0.3},
            {s = "Firearms2.Magpouch", t = 1},
            {s = "Firearms2.G36K_MagIn", t = 1.2},
            {s = "Firearms2.Cloth_Movement", t = 1.2},
            {s = "Firearms2.G36K_BoltBack", t = 1.65},
            {s = "Firearms2.Cloth_Movement", t = 1.65},
            {s = "Firearms2.G36K_BoltForward", t = 1.85}
            },
    },
}