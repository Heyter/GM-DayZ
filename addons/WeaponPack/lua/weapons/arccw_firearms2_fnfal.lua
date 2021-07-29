SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "FN FAL"
SWEP.Trivia_Class = "Battle Rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "FN Herstal"
SWEP.Trivia_Calibre = "7.62x51mm"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = "1953"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/fnfal.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/fnfal.mdl"
SWEP.ViewModelFOV = 52

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 47
SWEP.DamageMin = 47 -- damage done at maximum range
SWEP.Range = 600 -- in METRES
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 840 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.

SWEP.Recoil = 4
SWEP.RecoilSide = 0.03
SWEP.RecoilRise = 0.04
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.11 -- 60 / RPM.
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
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_FNFAL"
SWEP.ShootDrySound = "fas2/empty_sniperrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/fnfal.ogg"
SWEP.ShootSoundSilenced = "Firearms2_FNFAL_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_6b"

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
    Pos = Vector(-2.369, -2, 1.4),
    Ang = Angle(-0.45, 0.03, 0),
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

SWEP.CrouchPos = Vector(-1, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(4, -2.5, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -2.5, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 30

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["mag"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "SVD Receiver",
        Offset = {
            vpos = Vector(-7.2, -1.38, -0.03),
            vang = Angle(0, 0, 270),
            wpos = Vector(4.7, 0.6, -5.3),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 8.5,
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(-0.004, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "fas2_muzzle",
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = "fas2_fnfalmag",
    },
    {
        PrintName = "Tactical",
        Slot = "fas2_tactical",
        Bone = "SVD Receiver",
        Offset = {
            vpos = Vector(-4.2, -1.38, -0.03),
            vang = Angle(0, 0, 270),
            wpos = Vector(8.9, 0.6, -6.1),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.5, 1.5, 1.5),
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
        Time = 35/53,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 22/66,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "",
    },
    ["fire1"] = {
        Source = "fire",
        Time = 25/60,
        ShellEjectAt = 0,
    },
    ["fire2"] = {
        Source = "fire2",
        Time = 25/62,
        ShellEjectAt = 0,
    },
    ["fire3"] = {
        Source = "fire3",
        Time = 25/58,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 6/60,
        ShellEjectAt = 0,
    },
   ["reload"] = {
        Source = "reload",
        Time = 100/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.FNFAL_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.65},
        {s = "Firearms2.Magpouch", t = 1.3},
        {s = "Firearms2.SVD_MagInPartial", t = 1.7},
		{s = "Firearms2.FNFAL_MagIn", t = 1.96},
		{s = "Firearms2.Cloth_Movement", t = 1.96}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 114/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.FNFAL_MagOut", t = 0.65},
        {s = "Firearms2.Cloth_Movement", t = 0.65},
        {s = "Firearms2.Magpouch", t = 1.3},
        {s = "Firearms2.SVD_MagInPartial", t = 1.7},
        {s = "Firearms2.FNFAL_MagIn", t = 1.96},
        {s = "Firearms2.Cloth_Movement", t = 1.96},
        {s = "Firearms2.FNFAL_BoltBack", t = 2.61},
        {s = "Firearms2.Cloth_Movement", t = 2.61},
        {s = "Firearms2.FNFAL_BoltRelease", t = 2.79}
        },
    },
}