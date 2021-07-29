SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "Sterling MK7A4"
SWEP.Trivia_Class = "Submachine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Sterling Armaments Company"
SWEP.Trivia_Calibre = "9x19MM"
SWEP.Trivia_Country = "United Kingdom"
SWEP.Trivia_Year = "1953"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/mk7a4.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/mk7a4.mdl"
SWEP.ViewModelFOV = 49

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 20
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 152 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 15 -- DefaultClip is automatically set.

SWEP.Recoil = 1.2
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.03
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.0688 -- 60 / RPM.
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
SWEP.HipDispersion = 480 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x19mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_MK7A4"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/mk7a4.ogg"
SWEP.ShootSoundSilenced = "Firearms2_MK7A4_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_smg"

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
    Pos = Vector(-2.86, -2.25, 1.44),
    Ang = Angle(0.05, 0.02, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4.5, -2, 1.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.5, -2, 1.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 18

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
        ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Bone = "Sterling01",
                Offset = {
                    pos = Vector(0.005, -3.1, 0.178),
                    ang = Angle(0, 90, 0),
                },
                Scale = Vector(0.9, 0.9, 0.9),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(13, 0.67, -4.02),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.65, 1.65, 1.65),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Bone = "Sterling01",
                Offset = {
                    pos = Vector(0.005, -3.1, 0.195),
                    ang = Angle(0, 90, 0),
                },
                Scale = Vector(0.9, 0.9, 0.9),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(13, 0.67, -4.05),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.65, 1.65, 1.65),
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

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if anim != "fire" then return end

    local dice = util.SharedRandom("FireOrNot", 0, 0.99, CurTime())

    if dice <= 0.33 then
        return "fire1"
    elseif dice <= 0.66 then
        return "fire2"
    else
        return "fire3"
    end
end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 24/72,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 24/72,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 17/51,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 17/51,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
    },
    ["fire1"] = {
        Source = "fire",
        Time = 29/60,
        ShellEjectAt = 0,
    },
    ["fire2"] = {
        Source = "fire2",
        Time = 29/62,
        ShellEjectAt = 0,
    },
    ["fire3"] = {
        Source = "fire3",
        Time = 29/58,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 29/59,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0}},
    },
    ["fire_iron"] = {
        Source = "shoot_scoped",
        Time = 7/60,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_last_scoped",
        Time = 29/59,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.STERLING_Boltforward", t = 0}},
    },
    ["reload"] = {
        Source = "reload",
        Time = 75/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MK7A4_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.65},
		{s = "Firearms2.Magpouch_SMG", t = 1},
		{s = "Firearms2.MK7A4_MagIn", t = 1.45},
		{s = "Firearms2.Cloth_Movement", t = 1.45}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 113/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.MK7A4_MagOutEmpty", t = 0.65},
        {s = "Firearms2.Cloth_Movement", t = 0.65},
        {s = "Firearms2.Magpouch_SMG", t = 1},
        {s = "Firearms2.MK7A4_MagIn", t = 1.45},
        {s = "Firearms2.Cloth_Movement", t = 1.45},
        {s = "Firearms2.MK7A4_MagSlap", t = 1.95},
        {s = "Firearms2.Cloth_Movement", t = 1.95},
        {s = "Firearms2.STERLING_Boltback", t = 2.55},
        {s = "Firearms2.Cloth_Movement", t = 2.55}
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 66/37.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.MK7A4_MagOut", t = 0.35},
        {s = "Firearms2.Cloth_Movement", t = 0.35},
        {s = "Firearms2.Magpouch_SMG", t = 0.8},
        {s = "Firearms2.MK7A4_MagIn", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.1}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 89/37.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.MK7A4_MagOut", t = 0.35},
        {s = "Firearms2.Cloth_Movement", t = 0.35},
        {s = "Firearms2.Magpouch_SMG", t = 0.8},
        {s = "Firearms2.MK7A4_MagIn", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.1},
        {s = "Firearms2.STERLING_Boltback", t = 1.65},
        {s = "Firearms2.Cloth_Movement", t = 1.65}
		},
    },
}