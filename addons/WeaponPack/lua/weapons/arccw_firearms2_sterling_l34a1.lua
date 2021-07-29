SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "Sterling L34A1"
SWEP.Trivia_Class = "Submachine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Sterling Armaments Company"
SWEP.Trivia_Calibre = "9x19MM"
SWEP.Trivia_Country = "United Kingdom"
SWEP.Trivia_Year = "1953"

SWEP.ViewModel = "models/weapons/fas2/view/smgs/sterling_sil.mdl"
SWEP.WorldModel = "models/weapons/arccw/fas2/smgs/w_sterling_sil.mdl"
SWEP.ViewModelFOV = 47

SWEP.UseHands = false

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 18
SWEP.DamageMin = 18 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 224 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 34 -- DefaultClip is automatically set.

SWEP.Recoil = 0.80224
SWEP.RecoilSide = 0.03
SWEP.RecoilRise = 0.01
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.0866 -- 60 / RPM.
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
SWEP.HipDispersion = 380 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x19mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 70 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.Silencer = true

SWEP.ShootSoundSilenced = "Firearms2_STERLING_S"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_suppressed"

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
    Pos = Vector(-2.266, -2.25, 1.4),
    Ang = Angle(0.05, 0.187, 0),
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
    ["draw"] = {
        Source = "draw",
        Time = 25/50,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        Time = 25/50,
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
    ["fire"] = {
        Source = {"shoot1", "shoot2"},
        Time = 15/40,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_last",
        Time = 15/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0}},
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 15/40,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_last_scoped",
        Time = 15/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0}},
    },
    ["reload"] = {
        Source = "reload",
        Time = 75/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.STERLING_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch_SMG", t = 0.94},
		{s = "Firearms2.STERLING_MagInPartial", t = 1.45},
		{s = "Firearms2.Cloth_Movement", t = 1.45},
		{s = "Firearms2.STERLING_MagIn", t = 1.57},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 95/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_MagOutEmpty", t = 0.6},
        {s = "Firearms2.Cloth_Movement", t = 0.6},
        {s = "Firearms2.Magpouch_SMG", t = 0.94},
        {s = "Firearms2.STERLING_MagInPartial", t = 1.45},
        {s = "Firearms2.Cloth_Movement", t = 1.45},
        {s = "Firearms2.STERLING_MagIn", t = 1.6},
        {s = "Firearms2.STERLING_Boltback", t = 2.3},
        {s = "Firearms2.Cloth_Movement", t = 2.3}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 75/33,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_MagOut", t = 0.5},
        {s = "Firearms2.Cloth_Movement", t = 0.5},
        {s = "Firearms2.Magpouch_SMG", t = 1},
        {s = "Firearms2.STERLING_MagIn", t = 1.5},
        {s = "Firearms2.Cloth_Movement", t = 1.5}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 85/33,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.STERLING_MagOutEmpty", t = 0.5},
        {s = "Firearms2.Cloth_Movement", t = 0.5},
        {s = "Firearms2.Magpouch_SMG", t = 1},
        {s = "Firearms2.STERLING_MagIn", t = 1.5},
        {s = "Firearms2.Cloth_Movement", t = 1.5},
        {s = "Firearms2.STERLING_Boltback", t = 2},
        {s = "Firearms2.Cloth_Movement", t = 2}
		},
    },
}