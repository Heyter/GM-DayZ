SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 1

SWEP.PrintName = "P226"
SWEP.Trivia_Class = "Semi-automatic pistol"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "SIG Sauer"
SWEP.Trivia_Calibre = "9x19"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = "1983"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/pistols/p226.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/pistols/p226.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 15
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 350 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 13 -- DefaultClip is automatically set.

SWEP.Recoil = 1.15
SWEP.RecoilSide = 0.04
SWEP.RecoilRise = 0.02
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.135 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0,
    },
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 320 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x19MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 90 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_P226"
SWEP.ShootDrySound = "fas2/empty_pistol.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/p226.ogg"
SWEP.ShootSoundSilenced = "Firearms2_P226_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_OTS"

SWEP.ShellModel = "models/shells/9x19mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.892, -0.78, 0.901),
    Ang = Angle(0, 0.03, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

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

SWEP.CustomizePos = Vector(1.824, -4, -1)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 17

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_pistol.mdl",
                Bone = "Frame",
                Offset = {
                    pos = Vector(-4.7, 1.56, 0.082),
                    ang = Angle(180, 0, 0),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_pistol.mdl",
                Offset = {
                    pos = Vector(12, 1.73, -5.19),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_pistol.mdl",
                Bone = "Frame",
                Offset = {
                    pos = Vector(-4.7, 1.56, 0.082),
                    ang = Angle(180, 0, 0),
                },
                Scale = Vector(1, 1, 1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_pistol.mdl",
                Offset = {
                    pos = Vector(12, 1.73, -5.19),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 15/45,    
        SoundTable = {        
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        Time = 15/45,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["holster"] = {
        Source = "holster",
        Time = 15/45,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 15/45,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire1", "fire2"},
        Time = 22/33.5,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 22/33.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped2",
        Time = 15/40,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_last_iron",
        Time = 15/40,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 70/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.P226_MagOut", t = 0.5},
		{s = "Firearms2.Magpouch_Pistol", t = 0.9},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.P226_MagInPartial", t = 1.45},
		{s = "Firearms2.P226_MagIn", t = 1.65},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 95/37,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.P226_MagOutEmpty", t = 0.3},
        {s = "Firearms2.Magpouch_Pistol", t = 0.5},
        {s = "Firearms2.Cloth_Movement", t = 0.86},
        {s = "Firearms2.P226_MagInPartial", t = 0.9},
		{s = "Firearms2.P226_MagIn", t = 1},
        {s = "Firearms2.Cloth_Movement", t = 1.76},
        {s = "Firearms2.P226_SlideBack", t = 1.8},
        {s = "Firearms2.P226_SlideForward", t = 1.95},
		{s = "Firearms2.P226_SlideStop", t = 2},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 59/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.P226_MagOut", t = 0.5},
		{s = "Firearms2.Magpouch_Pistol", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.P226_MagInPartial", t = 1.15},
		{s = "Firearms2.P226_MagIn", t = 1.35},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 62/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.P226_MagOutEmpty", t = 0.5},
		{s = "Firearms2.Magpouch_Pistol", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.P226_MagInPartial", t = 1.15},
		{s = "Firearms2.P226_MagIn", t = 1.35},
		{s = "Firearms2.P226_SlideForward", t = 1.6},
		{s = "Firearms2.P226_SlideStop", t = 1.65},
		},
    },
}