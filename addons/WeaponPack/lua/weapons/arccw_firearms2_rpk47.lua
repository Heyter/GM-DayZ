SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "RPK-47"
SWEP.Trivia_Class = "Light machine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Vyatskiye Polyany Machine-Building Plant"
SWEP.Trivia_Calibre = "7.62x39mm"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1961"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/machineguns/rpk.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/machineguns/rpk.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 36
SWEP.DamageMin = 36 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 745 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 45 -- DefaultClip is automatically set.

SWEP.Recoil = 1.8
SWEP.RecoilSide = 0.14
SWEP.RecoilRise = 0.03
SWEP.RecoilPunch = 0
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
SWEP.HipDispersion = 530 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x39mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_RPK47"
SWEP.ShootDrySound = "fas2/empty_machineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/rpk47.ogg"
SWEP.ShootSoundSilenced = "Firearms2_RPK47_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"
SWEP.EnterBipodSound = ""
SWEP.ExitBipodSound = ""

SWEP.MuzzleEffect = "muzzleflash_1"

SWEP.ShellModel = "models/shells/7_62x39mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.75
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-1.875, -4.874, 0.587),
    Ang = Angle(0.048, 0.04, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.45

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

SWEP.HolsterPos = Vector(4.532, -3, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -3, 0)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.InBipodPos = Vector(-2, 1, -2)

SWEP.BarrelLength = 37

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
                Bone = "RPK BipodPivot",
                Offset = {
                    pos = Vector(2, 0, 0),
                    ang = Angle(0, 0, 90),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(35, 0.67, -8.85),
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
                Bone = "RPK BipodPivot",
                Offset = {
                    pos = Vector(2, 0, 0),
                    ang = Angle(0, 0, 90),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(35, 0.67, -8.85),
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
        Bone = "RPK BipodPivot", 
        Offset = {
            vpos = Vector(-16, -1.22, 0.02),
            vang = Angle(0, 0, 270),
            wpos = Vector(5.8, 0.7, -5.68),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0.0025, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
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
    -- ["enter_bipod"] = {
    --     Source = "bipod_down",
    --     Time = 25/30,
	-- 	SoundTable = {{s = "Firearms2.Cloth_Movement", t = 0}},
    -- },
    -- ["exit_bipod"] = {
    --     Source = "bipod_up",
    --     Time = 25/30,
	-- 	SoundTable = {{s = "Firearms2.Cloth_Movement", t = 0}},
    -- },
    ["draw"] = {
        Source = "deploy",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 130/30,
	-- 	ProcDraw = true,
    --     SoundTable = {
    --         {s = "Firearms2.Deploy", t = 0},
    --         {s = "Firearms2.Magpouch", t = 0.27},
    --         {s = "Firearms2.RPK47_MagInPartial", t = 0.9},
    --         {s = "Firearms2.RPK47_MagIn", t = 1},
    --         {s = "Firearms2.Cloth_Movement", t = 0.87},
    --         {s = "Firearms2.RPK47_BipodOpen", t = 1.64},
    --         {s = "Firearms2.Cloth_Movement", t = 1.64},
    --         {s = "Firearms2.Cloth_Movement", t = 2.57},
    --         {s = "Firearms2.Firemode_Switch", t = 2.9},
    --         {s = "Firearms2.RPK47_BoltBack", t = 3.34},
    --         {s = "Firearms2.Cloth_Movement", t = 3.34},
    --         {s = "Firearms2.RPK47_BoltForward", t = 3.54}
    --         },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3"},
        Time = 20/60,
        ShellEjectAt = 0,
    },
    ["fire_bipod"] = {
        Source = {"fire1_bipod", "fire2_bipod", "fire3_bipod"},
        Time = 10/60,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire1_scoped", "fire2_scoped", "fire3_scoped"},
        Time = 10/60,
        ShellEjectAt = 0,
    },
    ["fire_bipod_iron"] = {
        Source = {"fire1_bipod_scoped", "fire2_bipod_scoped"},
        Time = 10/60,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 100/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.RPK47_MagOut", t = 0.85},
		{s = "Firearms2.Cloth_Movement", t = 0.85},
		{s = "Firearms2.Magpouch", t = 1.57},
		{s = "Firearms2.RPK47_MagInPartial", t = 2.2},
		{s = "Firearms2.RPK47_MagIn", t = 2.4},
		{s = "Firearms2.Cloth_Movement", t = 2.4}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 165/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.RPK47_MagOutEmpty", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.84},
		{s = "Firearms2.RPK47_MagInPartial", t = 2.9},
		{s = "Firearms2.RPK47_MagIn", t = 3.1},
		{s = "Firearms2.Cloth_Movement", t = 3.1},
		{s = "Firearms2.RPK47_BoltBack", t = 4.45},
		{s = "Firearms2.Cloth_Movement", t = 4.45},
		{s = "Firearms2.RPK47_BoltForward", t = 4.75}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 75/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.6},
		{s = "Firearms2.RPK47_MagOut", t = 1.2},
		{s = "Firearms2.Cloth_Movement", t = 1.2},
		{s = "Firearms2.RPK47_MagInPartial", t = 1.4},
		{s = "Firearms2.RPK47_MagIn", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 95/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.6},
		{s = "Firearms2.RPK47_MagOutEmptyNomen", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.RPK47_MagInPartial", t = 1.4},
		{s = "Firearms2.RPK47_MagIn", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6},
		{s = "Firearms2.RPK47_BoltBack", t = 2.15},
		{s = "Firearms2.RPK47_BoltForward", t = 2.35},
		{s = "Firearms2.Cloth_Movement", t = 2.35},
		},
    },
    -- ["reload_bipod"] = {
    --     Source = "reload_bipod",
    --     Time = 75/30,
    --     TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Cloth_Movement", t = 0},
	-- 	{s = "Firearms2.RPK47_MagOut", t = 0.6},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.6},
	-- 	{s = "Firearms2.Magpouch", t = 1.1},
	-- 	{s = "Firearms2.RPK47_MagIn", t = 1.75},
	-- 	{s = "Firearms2.Cloth_Movement", t = 1.75},
	-- 	},
    -- },
    -- ["reload_empty_bipod"] = {
    --     Source = "reload_empty_bipod",
    --     Time = 110/30,
    --     TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Cloth_Movement", t = 0},
	-- 	{s = "Firearms2.RPK47_MagOutEmpty", t = 0.6},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.6},
	-- 	{s = "Firearms2.Magpouch", t = 1.2},
	-- 	{s = "Firearms2.RPK47_MagIn", t = 1.75},
	-- 	{s = "Firearms2.Cloth_Movement", t = 1.75},
	-- 	{s = "Firearms2.RPK47_BoltBack", t = 3},
	-- 	{s = "Firearms2.Cloth_Movement", t = 3},
	-- 	{s = "Firearms2.RPK47_BoltForward", t = 3.15},
	-- 	},
    -- },
}