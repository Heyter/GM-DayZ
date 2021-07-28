SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "Uzi"
SWEP.Trivia_Class = "Submachine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Israel Military Industries"
SWEP.Trivia_Calibre = "9x19MM"
SWEP.Trivia_Country = "Israel"
SWEP.Trivia_Year = "1950"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/uzi.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/uzi.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 21
SWEP.DamageMin = 6 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 32 -- DefaultClip is automatically set.

SWEP.Recoil = 1
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.05
SWEP.RecoilPunch = 1
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.1 -- 60 / RPM.
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

SWEP.Primary.Ammo = "9x19mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_UZI"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/uzi.ogg"
SWEP.ShootSoundSilenced = "Firearms2_UZI_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_smg"

SWEP.ShellModel = "models/shells/9x19mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.314, -3.906, 1),
    Ang = Angle(1.2, 0.11, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1.1, -3, 0)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -3, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.9)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 20

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["uzistock"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
        ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Bone = "frame",
                Offset = {
                    pos = Vector(8.35, -0.08, 0.317),
                    ang = Angle(0, 0, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(14.65, 0.66, -4.98),
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
                Bone = "frame",
                Offset = {
                    pos = Vector(8.35, -0.08, 0.33),
                    ang = Angle(0, 0, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(14.65, 0.66, -5),
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
        Bone = "frame",
        Offset = {
            vpos = Vector(-1.4, 0.016, 1.6),
            vang = Angle(0, 0, 0),
            wpos = Vector(-1.18, 0.66, -4.3),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(1.4, 1.4, 1.4),
        CorrectivePos = Vector(-0.003, 0, 0.001),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Stock",
        DefaultAttName = "Standard Stock",
        Slot = {"fas2_woodenstock"}
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "draw_first",
    --     Time = 100/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 0.1},
    --     {s = "Firearms2.UZI_StockUnfold", t = 0.6},
    --     {s = "Firearms2.Cloth_Movement", t = 0.6},
    --     {s = "Firearms2.Cloth_Movement", t = 1},
    --     {s = "Firearms2.Cloth_Movement", t = 1.5}
    --     },
    -- },
    ["draw"] = {
        Source = "draw",
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "shoot1",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 15/35,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 115/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.UZI_MagRelease", t = 0.85},
		{s = "Firearms2.Cloth_Movement", t = 0.85},
		{s = "Firearms2.UZI_MagOut", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.Magpouch_SMG", t = 2},
		{s = "Firearms2.UZI_MagInPartial", t = 2.4},
		{s = "Firearms2.Cloth_Movement", t = 2.4},
		{s = "Firearms2.UZI_MagIn", t = 2.75},
		{s = "Firearms2.Cloth_Movement", t = 2.75}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 125/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.UZI_BoltBack", t = 0.5},
        {s = "Firearms2.Cloth_Movement", t = 0.5},
        {s = "Firearms2.UZI_BoltForward", t = 0.8},
        {s = "Firearms2.UZI_MagRelease", t = 1.84},
        {s = "Firearms2.Cloth_Movement", t = 1.84},
        {s = "Firearms2.UZI_MagOutEmpty", t = 1.9},
        {s = "Firearms2.Magpouch_SMG", t = 2.3},
        {s = "Firearms2.UZI_MagInPartial", t = 2.74},
        {s = "Firearms2.Cloth_Movement", t = 2.74},
        {s = "Firearms2.UZI_MagIn", t = 3.2},
        {s = "Firearms2.Cloth_Movement", t = 3.2},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 73/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.UZI_MagRelease", t = 0.5},
        {s = "Firearms2.Cloth_Movement", t = 0.5},
        {s = "Firearms2.UZI_MagOut", t = 0.65},
        {s = "Firearms2.Magpouch_SMG", t = 0.84},
        {s = "Firearms2.UZI_MagInPartial", t = 1.25},
        {s = "Firearms2.Cloth_Movement", t = 1.25},
        {s = "Firearms2.UZI_MagIn", t = 1.37},
        {s = "Firearms2.Cloth_Movement", t = 1.37}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 125/45,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.UZI_BoltBack", t = 0.3},
        {s = "Firearms2.Cloth_Movement", t = 0.3},
        {s = "Firearms2.UZI_BoltForward", t = 0.55},
        {s = "Firearms2.UZI_MagRelease", t = 1.2},
        {s = "Firearms2.Cloth_Movement", t = 1.2},
        {s = "Firearms2.UZI_MagOutEmpty", t = 1.3},
        {s = "Firearms2.Magpouch_SMG", t = 1.6},
        {s = "Firearms2.UZI_MagInPartial", t = 1.8},
        {s = "Firearms2.Cloth_Movement", t = 1.8},
        {s = "Firearms2.UZI_MagIn", t = 2.1},
        {s = "Firearms2.Cloth_Movement", t = 2.1},
		},
    },
}