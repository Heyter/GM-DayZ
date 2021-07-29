SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 1

SWEP.PrintName = "OTs-33 Pernach"
SWEP.Trivia_Class = "Machine pistol"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "KBP Instrument Design Bureau"
SWEP.Trivia_Calibre = "9x18"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "1996"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/pistols/ots33.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/pistols/ots33.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 15
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 330 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 18 -- DefaultClip is automatically set.

SWEP.Recoil = 1.1
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.035
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
        Mode = 0,
    },
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 380 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x18MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 90 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_OTS33"
SWEP.ShootDrySound = "fas2/empty_pistol.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ots33.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_OTS"

SWEP.ShellModel = "models/shells/9x18mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.655, -0.786, 0.63),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1, -3, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(0.4, -5, -2.69)
SWEP.HolsterAng = Angle(38.433, 0, 0)

SWEP.SprintPos = Vector(0.4, -5, -2.69)
SWEP.SprintAng = Angle(38.433, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 10, -3)

SWEP.CustomizePos = Vector(2.824, -4, -1)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 17

SWEP.Attachments = {
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "Draw",
        Time = 15/45,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["draw_empty"] = {
        Source = "Draw_Empty",
        Time = 15/45,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["holster"] = {
        Source = "Holster",
        Time = 15/45,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "Holster_Empty",
        Time = 15/45,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"Fire1", "Fire2", "Fire3"},
        Time = 15/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "Fire_Last",
        Time = 15/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "Fire_Iron",
        Time = 15/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "Fire_Last_Iron",
        Time = 15/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "Reload_Wet",
        Time = 70/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.OTs33_MagOut", t = 0.4},
		{s = "Firearms2.Cloth_Movement", t = 0.4},
		{s = "Firearms2.Magpouch_Pistol", t = 0.6},
		{s = "Firearms2.OTs33_MagInPartial", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.OTs33_MagIn", t = 1.25},
		{s = "Firearms2.Cloth_Movement", t = 1.25},
		},
    },
    ["reload_empty"] = {
        Source = "Reload_Dry",
        Time = 70/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.OTs33_MagOutEmpty", t = 0.4},
        {s = "Firearms2.Cloth_Movement", t = 0.4},
        {s = "Firearms2.Magpouch_Pistol", t = 0.6},
        {s = "Firearms2.OTs33_MagInPartial", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
        {s = "Firearms2.OTs33_MagIn", t = 1.25},
        {s = "Firearms2.Cloth_Movement", t = 1.25},
        {s = "Firearms2.OTs33_SlideRelease", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		},
    },
    ["reload_nomen"] = {
        Source = "Fast_Reload_Wet",
        Time = 50/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.OTs33_MagOut", t = 0.4},
		{s = "Firearms2.Magpouch_Pistol", t = 0.6},
		{s = "Firearms2.OTs33_MagInPartial", t = 0.7},
		{s = "Firearms2.OTs33_MagIn", t = 0.9},
		{s = "Firearms2.Cloth_Movement", t = 0.9},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "Fast_Reload_Dry",
        Time = 60/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.OTs33_MagOutEmpty", t = 0.4},
		{s = "Firearms2.Magpouch_Pistol", t = 0.6},
		{s = "Firearms2.OTs33_MagInPartial", t = 0.7},
		{s = "Firearms2.OTs33_MagIn", t = 0.9},
		{s = "Firearms2.Cloth_Movement", t = 0.9},
		{s = "Firearms2.OTs33_SlideRelease", t = 1.2},
		{s = "Firearms2.Cloth_Movement", t = 1.2},
		},
    },
}