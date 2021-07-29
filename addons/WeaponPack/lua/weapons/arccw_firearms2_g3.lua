SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "G3A3"
SWEP.Trivia_Class = "Battle rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = "7.62x51mm"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = "1958"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/g3.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/g3.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 46
SWEP.DamageMin = 46 -- damage done at maximum range
SWEP.Range = 400 -- in METRES
SWEP.Penetration = 15
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.Recoil = 1.7
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.04
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.12 -- 60 / RPM.
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
SWEP.HipDispersion = 560 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_G3"
SWEP.ShootDrySound = "fas2/empty_battlerifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/g3.ogg"
SWEP.ShootSoundSilenced = "Firearms2_G3_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_g3"

SWEP.ShellModel = "models/shells/7_62x51mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.75
SWEP.SightedSpeedMult = 0.65

SWEP.IronSightStruct = {
    Pos = Vector(-2, -2.652, 0.18),
    Ang = Angle(0.814, 0.04, 0),
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

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -3, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 33

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
                    pos = Vector(-14, -0.515, 0.24),
                    ang = Angle(0, 180, 90),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(31.7, 0.4, -9.65),
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
                Bone = "frame",
                Offset = {
                    pos = Vector(-14, -0.515, 0.24),
                    ang = Angle(0, 180, 90),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(31.7, 0.4, -9.65),
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
        Bone = "frame",
        Offset = {
            vpos = Vector(2.2, 0.725, 0.245),
            vang = Angle(180, 0, 90),
            wpos = Vector(4.35, 0.42, -6.9),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 1.7,
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0.003, 0.000, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
        Bone = "frame",
    },
    {
        PrintName = "Skills",
        Slot = "fas2_nomen",
    },
}

-- SWEP.Hook_TranslateAnimation = function(wep, anim)
--     if anim != "ready" then return end

--     local dice = util.SharedRandom("ReadyOrNot", 0, 1, CurTime())

--     if dice > 0.5 then
--         return "ready1"
--     else
--         return "ready2"
--     end
-- end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 25/50,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready1"] = { 
    --     Source = {"deploy_first"},
    --     Time = 164/30,
	-- 	SoundTable = {
    --         {s = "Firearms2.Cloth_Movement", t = 0},
    --         {s = "Firearms2.G3_Handle", t = 0.56},
    --         {s = "Firearms2.G3_BoltBack", t = 0.8},
    --         {s = "Firearms2.Cloth_Movement", t = 0.8},
    --         {s = "Firearms2.Magpouch", t = 1.7},
    --         {s = "Firearms2.G3_MagIn", t = 3.1},
    --         {s = "Firearms2.Cloth_Movement", t = 3.1},
    --         {s = "Firearms2.G3_BoltForward", t = 4.1},
    --         {s = "Firearms2.Cloth_Movement", t = 4.1},
    --         },
    -- },
    -- ["ready2"] = {
    --     Source = {"deploy_first2"},
    --     Time = 64/30,
	-- 	SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.7},
    --     {s = "Firearms2.Cloth_Movement", t = 1.33},
    --     {s = "Firearms2.Cloth_Movement", t = 1.56},
    --     },
    -- },
    -- ["ready"] = {
    --     Source = {""},
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire", "fire2", "fire3"},
        Time = 25/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 20/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 85/30,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.G3_MagOut", t = 0.85},
		{s = "Firearms2.Cloth_Movement", t = 0.85},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.G3_MagIn", t = 1.85},
		{s = "Firearms2.Cloth_Movement", t = 1.85}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 137/30,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.G3_Handle", t = 0.27},
		{s = "Firearms2.G3_BoltBack", t = 0.7},
		{s = "Firearms2.G3_MagOutEmpty", t = 2.1},
		{s = "Firearms2.Cloth_Movement", t = 2.1},
		{s = "Firearms2.Magpouch", t = 2.6},
		{s = "Firearms2.G3_MagIn", t = 3.2},
		{s = "Firearms2.Cloth_Movement", t = 3.2},
		{s = "Firearms2.G3_BoltForward", t = 4},
		{s = "Firearms2.Cloth_Movement", t = 4}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 85/35,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Cloth_Movement", t = 0.34},
		{s = "Firearms2.G3_MagOut", t = 0.7},
		{s = "Firearms2.Magpouch", t = 1.2},
		{s = "Firearms2.G3_MagIn", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 2.08}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 115/32,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.G3_MagOutEmpty", t = 0.7},
        {s = "Firearms2.Cloth_Movement", t = 0.7},
        {s = "Firearms2.Magpouch", t = 1.5},
        {s = "Firearms2.G3_MagIn", t = 2},
        {s = "Firearms2.Cloth_Movement", t = 2},
        {s = "Firearms2.G3_Handle", t = 2.5},
        {s = "Firearms2.G3_BoltPullNomen", t = 2.6},
        {s = "Firearms2.Cloth_Movement", t = 2.6},
		},
    },
}