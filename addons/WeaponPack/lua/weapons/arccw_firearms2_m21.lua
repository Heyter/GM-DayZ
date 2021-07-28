SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M21"
SWEP.Trivia_Class = "Sniper rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Rock Island Arsenal"
SWEP.Trivia_Calibre = "7.62x51mm"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1968"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/m21.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/m21.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 55
SWEP.DamageMin = 40 -- damage done at maximum range
SWEP.Range = 822 -- in METRES
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 853 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.Recoil = 1.2
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.07
SWEP.RecoilPunch = 1.5
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.16 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 320 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M21"
SWEP.ShootDrySound = "fas2/empty_sniperrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m21.ogg"
SWEP.ShootSoundSilenced = "Firearms2_M21_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_m14"

SWEP.ShellModel = "models/shells/7_62x51mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.561, -5.354, 1.363),
    Ang = Angle(0, 0.01, 0),
    Magnification = 1.25,
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

SWEP.CrouchPos = Vector(-4.5, -3, 0.3)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -3.5, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -3.5, 0)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 32

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["bayonet"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
        WMBodygroups = {{ind = 2, bg = 2}},
    },
    ["20rnd"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(20.8, -1.38, 0),
                    ang = Angle(0, 0, 90),
                },
                Scale = Vector(1.3, 1.3, 1.3),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(40.5, 0.67, -11.25),
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
                    pos = Vector(20.8, -1.38, 0),
                    ang = Angle(0, 0, 90),
                },
                Scale = Vector(1.3, 1.3, 1.3),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(40.5, 0.67, -11.25),
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
        Slot = {"fas2_sight", "fas2_scope", "fas2_leupold_scope"},
        Bone = "Dummy01", 
        Offset = {
            vpos = Vector(3.15, -2.09, 0),
            vang = Angle(0, 0, 270),
            wpos = Vector(10.5, 0.7, -7.22),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 1.7,
        VMScale = Vector(0.9, 0.9, 0.9),
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider", "fas2_bayonet"},
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = "fas2_m21_20rnd",
    },
    {
        PrintName = "Skills",
        Slot = "fas2_nomen",
    },
}

-- SWEP.Hook_TranslateAnimation = function(wep, anim)
--     if anim != "ready" then return end

--     local dice = util.SharedRandom("ReadyOrNot", 0, 0.99, CurTime())

--     if dice <= 0.33 then
--         return "deploy_first1"
--     elseif dice <= 0.66 then
--         return "deploy_first2"
--     else
--         return "deploy_first3"
--     end
-- end

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "",
    -- },
    -- ["deploy_first1"] = {
    --     Source = "deploy_first1",
    --     Time = 130/30,
    --     SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 1.17},
    --     {s = "Firearms2.M14_Boltpull", t = 1.4},
    --     {s = "Firearms2.M14_Check", t = 2.24},
    --     {s = "Firearms2.Cloth_Movement", t = 2.24},
    --     },
    -- },
    -- ["deploy_first2"] = {
    --     Source = "deploy_first2",
    --     Time = 80/30,
    --     SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 1},
    --     {s = "Firearms2.M14_Boltpull", t = 1.24},
    --     },
    -- },
    -- ["deploy_first3"] = {
    --     Source = "deploy_first3",
    --     Time = 65/30,
    --     SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Firemode_Switch", t = 0.8},
    --     {s = "Firearms2.Cloth_Movement", t = 0.8},
    --     },
    -- },
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
    ["bash"] = {
        Source = "melee",
        Time = 20/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Fast", t = 0},
        {s = "Firearms2.Cloth_Fast", t = 0.37},
        },
    },
    ["bash_empty"] = {
        Source = "melee_empty",
        Time = 20/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Fast", t = 0},
        {s = "Firearms2.Cloth_Fast", t = 0.37},
        },
    },
    ["fire"] = {
        Source = {"shoot", "shoot2", "shoot3"},
        Time = 60/60,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_last",
        Time = 60/60,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_scoped",
        Time = 30/60,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_last_scoped",
        Time = 30/60,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = {"reload", "reload2"},
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M21_Magout", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.M21_Magin", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9}
		},
    },
    ["reload_empty"] = {
        Source = {"reload_empty", "reload_empty2"},
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M21_MagoutEmpty", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1.34},
		{s = "Firearms2.M21_Magin", t = 1.95},
		{s = "Firearms2.Cloth_Movement", t = 1.95},
		{s = "Firearms2.M14_BoltRelease", t = 3.15},
		{s = "Firearms2.Cloth_Movement", t = 3.15},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 67/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M21_Magout", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.Magpouch", t = 1},
		{s = "Firearms2.M21_Magin", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M21_MagoutEmpty", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.Magpouch", t = 1.2},
		{s = "Firearms2.M21_Magin", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		{s = "Firearms2.M14_BoltRelease", t = 2.3},
		{s = "Firearms2.Cloth_Movement", t = 2.3},
		},
    },
}