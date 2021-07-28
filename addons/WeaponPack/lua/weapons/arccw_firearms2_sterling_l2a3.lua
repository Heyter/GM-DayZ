SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "Sterling L2A3"
SWEP.Trivia_Class = "Submachine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Sterling Armaments Company"
SWEP.Trivia_Calibre = "9x19MM"
SWEP.Trivia_Country = "United Kingdom"
SWEP.Trivia_Year = "1953"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/sterling.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/sterling.mdl"
SWEP.ViewModelFOV = 47

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 22
SWEP.DamageMin = 7 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 350 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 34 -- DefaultClip is automatically set.

SWEP.Recoil = 0.9
SWEP.RecoilSide = 0.07
SWEP.RecoilRise = 0.02
SWEP.RecoilPunch = 1.05
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.0799 -- 60 / RPM.
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
SWEP.HipDispersion = 450 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x19mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_STERLING"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/sterling.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_smg"

SWEP.ShellModel = "models/shells/9x19mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.036, -2.25, 1.655),
    Ang = Angle(0.05, 0.015, 0),
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

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -3.5, 1.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -3.5, 1.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 22

SWEP.Attachments = {
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 135/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 0.4},
    --     {s = "Firearms2.STERLING_Boltback", t = 0.75},
    --     {s = "Firearms2.Cloth_Movement", t = 1.2},
    --     {s = "Firearms2.STERLING_StockUnfold", t = 1.6},
    --     {s = "Firearms2.Cloth_Movement", t = 2.2},
    --     {s = "Firearms2.Cloth_Movement", t = 3.2},
    --     {s = "Firearms2.Cloth_Movement", t = 3.7}
    --     },
    -- },
    ["draw"] = {
        Source = "draw",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 10/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 10/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2"},
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_last",
        Time = 30/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0.1}},
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 30/40,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_last_scoped",
        Time = 30/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0.1}},
    },
    ["reload"] = {
        Source = "reload",
        Time = 75/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.STERLING_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.65},
		{s = "Firearms2.Magpouch_SMG", t = 1.1},
		{s = "Firearms2.Cloth_Movement", t = 1.44},
		{s = "Firearms2.STERLING_MagInPartial", t = 1.55},
		{s = "Firearms2.STERLING_MagIn", t = 1.67},
		{s = "Firearms2.Cloth_Movement", t = 1.77}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_Boltback", t = 0.47},
        {s = "Firearms2.Cloth_Movement", t = 0.84},
        {s = "Firearms2.STERLING_MagOutEmpty", t = 1.14},
        {s = "Firearms2.Magpouch_SMG", t = 1.64},
        {s = "Firearms2.Cloth_Movement", t = 1.84},
        {s = "Firearms2.STERLING_MagInPartial", t = 2},
        {s = "Firearms2.STERLING_MagIn", t = 2.14},
        {s = "Firearms2.Cloth_Movement", t = 2.4}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 75/45,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_MagOut", t = 0.38},
        {s = "Firearms2.Cloth_Movement", t = 0.38},
        {s = "Firearms2.Magpouch_SMG", t = 0.72},
        {s = "Firearms2.Cloth_Movement", t = 0.96},
        {s = "Firearms2.STERLING_MagInPartial", t = 1},
        {s = "Firearms2.STERLING_MagIn", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.1}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 90/45,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_Boltback", t = 0.32},
        {s = "Firearms2.Cloth_Movement", t = 0.56},
        {s = "Firearms2.STERLING_MagOutEmpty", t = 0.76},
        {s = "Firearms2.Magpouch_SMG", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.23},
        {s = "Firearms2.STERLING_MagInPartial", t = 1.34},
        {s = "Firearms2.STERLING_MagIn", t = 1.43},
        {s = "Firearms2.Cloth_Movement", t = 1.6}
		},
    },
}