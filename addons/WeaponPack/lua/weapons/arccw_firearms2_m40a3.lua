SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M40A3"
SWEP.Trivia_Class = "Sniper Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Remington Arms"
SWEP.Trivia_Calibre = "7.62x51MM"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1966"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/m40a3.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/m40a3.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 59
SWEP.DamageMin = 44 -- damage done at maximum range
SWEP.Range = 800 -- in METRES
SWEP.Penetration = 5
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 777 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.

SWEP.ManualAction = true
SWEP.NoLastCycle = true

SWEP.Recoil = 2.5
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.18
SWEP.RecoilPunch = 2.2
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.2 -- 60 / RPM.
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
SWEP.HipDispersion = 210 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M40A3"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m40a3.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

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

SWEP.CrouchPos = Vector(-4.5, -2, 0.5)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -4, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -4, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 35

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = "fas2_leupold_scope",
        Bone = "Dummy04",
        Offset = {
            vpos = Vector(-1.3, -1.51   , 0.01),
            vang = Angle(0, 0, 270),
            wpos = Vector(11.29, 0.68, -7.3),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 1.7,
        Installed = "fas2_scope_leupold",
        Integral = true,
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(1.7, 1.7, 1.7),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = {"draw1", "draw2"},
        Time = 16/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = {
    --     Source = "draw_first",
    --     Time = 36/30,
	-- 	SoundTable = {{s = "Firearms2.M24_Boltdown_Nomen", t = 0.6}},
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 15/30,
        MinProgress = 0.5,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 10/30,
        MinProgress = 0.5,
    },
    ["cycle"] = {
        Source = "cock1",
        Time = 40/30,
        ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        ShellEjectAt = 0.45,
        SoundTable = {
        {s = "Firearms2.M24_Boltup_Nomen", t = 0.35},
        {s = "Firearms2.M24_Boltback_Nomen", t = 0.45},
        {s = "Firearms2.M24_Boltforward_Nomen", t = 0.75},   
        {s = "Firearms2.M24_Boltdown_Nomen", t = 0.9},   
        },
    },
    ["cycle_iron"] = {
        Source = "cock1_scoped",
        Time = 40/30,
        ShellEjectAt = 0.45,
        SoundTable = {
        {s = "Firearms2.M24_Boltup_Nomen", t = 0.35},
        {s = "Firearms2.M24_Boltback_Nomen", t = 0.45},
        {s = "Firearms2.M24_Boltforward_Nomen", t = 0.75},   
        {s = "Firearms2.M24_Boltdown_Nomen", t = 0.9},   
        },
    },
    ["reload"] = {
        Source = "reload",
        Time = 105/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.STERLING_MagInPartial", t = 0.45},
		{s = "Firearms2.STERLING_MagOut", t = 1},
		{s = "Firearms2.Magpouch", t = 2.2},
		{s = "Firearms2.STERLING_MagIn", t = 2.6}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 130/30,
        ShellEjectAt = 0.75,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.M24_Boltup_Nomen", t = 0.55},
		{s = "Firearms2.M24_Boltback_Nomen", t = 0.75},
		{s = "Firearms2.STERLING_MagOutEmpty", t = 1.5},
		{s = "Firearms2.Magpouch", t = 2.4},
		{s = "Firearms2.STERLING_MagIn", t = 2.9},
		{s = "Firearms2.M24_Boltforward_Nomen", t = 3.65},
		{s = "Firearms2.M24_Boltdown_Nomen", t = 3.9}
		},
    },
}