SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "SG 551"
SWEP.Trivia_Class = "Automatic Carbine"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Swiss Arms AG"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "Switzerland"
SWEP.Trivia_Year = "1998"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/sg551.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/sg551.mdl"
SWEP.ViewModelFOV = 62

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 32
SWEP.DamageMin = 32 -- damage done at maximum range
SWEP.Range = 400 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 860 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.Recoil = 1.355
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.04
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.125865 -- 60 / RPM.
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
SWEP.HipDispersion = 325 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_SG550"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/sg551.ogg"
SWEP.ShootSoundSilenced = "Firearms2_SG550_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"
SWEP.MeleeSwingSound = "Firearms2.Magpouch"

SWEP.MuzzleEffect = "muzzleflash_1"

SWEP.ShellModel = "models/shells/5_56x45mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.653, -1.5, -0.05),
    Ang = Angle(0, 0, 0),
    Magnification = 1.2,
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

SWEP.CrouchPos = Vector(-0.4, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -2, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -2, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(3.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 32

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["30rnd"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "",
        DefaultAttName = "",
        Slot = "firearms2_sg551",
        Bone = "weapon_main",
        Offset = {
            vpos = Vector(0.015, -2.111, 2.366),
            vang = Angle(0, -90, 0),
            wpos = Vector(13.5, 0.739, -8.9),
            wang = Angle(-10, 0, 180)
        },
    Installed = "fas2_scope_sg551",
    Integral = true,
    CorrectivePos = Vector(0, 0, 0),
    CorrectiveAng = Angle(0, 180, 0),
    },	
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle"},
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = {"fas2_sg55x_30rnd"}
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },	
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 33/34,
		SoundTable = {
            {s = "Firearms2.Deploy", t = 0},
            {s = "Firearms2.Cloth_Movement", t = 0.3},
            },
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 33/34,
		SoundTable = {
        {s = "Firearms2.Deploy", t = 0},
        {s = "Firearms2.Cloth_Movement", t = 0.3},
        },
    },
    -- ["ready"] = {
    --     Source = "draw",
    --     Time = 136/32,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Magpouch", t = 0.5},
    --     {s = "Firearms2.Cloth_Movement", t = 0.69},
    --     {s = "Firearms2.SG550_MagIn", t = 1.5},
    --     {s = "Firearms2.Cloth_Movement", t = 1.75},
    --     {s = "Firearms2.SG550_BoltBack", t = 2.45},
    --     {s = "Firearms2.Cloth_Movement", t = 2.56},
    --     {s = "Firearms2.SG550_BoltForward", t = 2.8},
    --     {s = "Firearms2.Cloth_Movement", t = 3.6},
    --     },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 22/34,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 22/34,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["bash"] = {
        Source = "melee",
        Time = 51/35,
		SoundTable = {
            {s = "Firearms2.Cloth_Fast", t = 0},
            {s = "Firearms2.Cloth_Fast", t = 0.37},
            },
    },
    ["bash_empty"] = {
        Source = "melee_empty",
        Time = 51/35,
		SoundTable = {
            {s = "Firearms2.Cloth_Fast", t = 0},
            {s = "Firearms2.Cloth_Fast", t = 0.37},
            },
    },
    ["fire"] = {
        Source = {"fire", "fire2", "fire3"},
        Time = 20/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 20/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire_scoped", "fire_scoped2", "fire_scoped3"},
        Time = 10/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_scoped_last",
        Time = 10/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 110/34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Firemode_Switch", t = 0.39},
		{s = "Firearms2.SG550_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.68},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SG550_MagIn", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 2.61},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 140/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Firemode_Switch", t = 0.39},
		{s = "Firearms2.SG550_MagOutEmpty", t = 0.65},
        {s = "Firearms2.Cloth_Movement", t = 0.68},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SG550_MagIn", t = 2.1},
		{s = "Firearms2.Cloth_Movement", t = 2.55},
		{s = "Firearms2.SG550_BoltForward", t = 2.86},
		{s = "Firearms2.Cloth_Movement", t = 3.43}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 89/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.Firemode_Switch", t = 0.55},
		{s = "Firearms2.SG550_MagOut", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SG550_MagIn", t = 1.25},
		{s = "Firearms2.Cloth_Movement", t = 1.28},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 100/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.Firemode_Switch", t = 0.55},
		{s = "Firearms2.SG550_MagOutEmpty", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SG550_MagIn", t = 1.25},
		{s = "Firearms2.Cloth_Movement", t = 1.28},
		{s = "Firearms2.SG550_BoltForward", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 2.29},
		},
    },
}