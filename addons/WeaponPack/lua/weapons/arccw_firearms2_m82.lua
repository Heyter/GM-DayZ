SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M82"
SWEP.Trivia_Class = "Anti-materiel precision rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Barrett Firearms Manufacturing"
SWEP.Trivia_Calibre = ".50 BMG"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1982"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/m82.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/m82.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 150
SWEP.DamageMin = 150 -- damage done at maximum range
SWEP.Range = 1800 -- in METRES
SWEP.Penetration = 70
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 853 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.Recoil = 12
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.8
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.8 -- 60 / RPM.
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
SWEP.HipDispersion = 445 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = ".50 BMG" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M82"
SWEP.ShootDrySound = "fas2/empty_sniperrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m82.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_M82"

SWEP.ShellModel = "models/shells/50bmg.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Heavy
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.6
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-2.126, -4, 0.72),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.55

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4.2, -1, 0.7)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(3.532, -4, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3.532, -4, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 40

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = "fas2_leupold_scope",
        Bone = "M82_Body",
        Offset = {
            vpos = Vector(0, -1.33, 1.9),
            vang = Angle(0, 270, 0),
            wpos = Vector(8.05, 0.68, -8.1),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 1.7,
        Installed = "fas2_scope_leupold",
        Integral = true,
        VMScale = Vector(0.87, 0.87, 0.87),
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Skills",
        Slot = "fas2_nomen",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 54/35,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 22/36,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire", "fire_2", "fire_3"},
        Time = 40/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 173/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.M82_MagRelease", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.M82_MagOut", t = 1.8},
		{s = "Firearms2.Cloth_Movement", t = 1.8},
		{s = "Firearms2.Magpouch_MachineGun", t = 2.6},
		{s = "Firearms2.M82_MagIn", t = 3},
		{s = "Firearms2.Cloth_Movement", t = 3},
		{s = "Firearms2.Cloth_Movement", t = 3.65}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 234/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Cloth_Movement", t = 0.6},
        {s = "Firearms2.M82_MagRelease", t = 1.3},
        {s = "Firearms2.Cloth_Movement", t = 1.3},
        {s = "Firearms2.M82_MagOutEmpty", t = 1.8},
        {s = "Firearms2.Cloth_Movement", t = 1.8},
        {s = "Firearms2.Magpouch_MachineGun", t = 2.6},
        {s = "Firearms2.M82_MagIn", t = 3},
        {s = "Firearms2.Cloth_Movement", t = 3},
        {s = "Firearms2.Cloth_Movement", t = 3.65},
        {s = "Firearms2.M82_BoltBack", t = 4.8},
        {s = "Firearms2.Cloth_Movement", t = 4.8},
        {s = "Firearms2.M82_BoltForward", t = 5.1},
        {s = "Firearms2.Cloth_Movement", t = 5.5}
        },
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 117/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Magpouch_MachineGun", t = 0.6},
        {s = "Firearms2.M82_MagRelease", t = 1},
        {s = "Firearms2.Cloth_Movement", t = 1},
        {s = "Firearms2.M82_MagOut", t = 1.05},
        {s = "Firearms2.M82_MagIn", t = 1.65},
        {s = "Firearms2.Cloth_Movement", t = 1.65},
        {s = "Firearms2.Cloth_Movement", t = 2.35}
        },
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 163/35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Magpouch_MachineGun", t = 0.6},
        {s = "Firearms2.M82_MagRelease", t = 1},
        {s = "Firearms2.Cloth_Movement", t = 1},
        {s = "Firearms2.M82_MagOut", t = 1.05},
        {s = "Firearms2.M82_MagIn", t = 1.65},
        {s = "Firearms2.Cloth_Movement", t = 1.65},
        {s = "Firearms2.M82_BoltBack", t = 2.7},
        {s = "Firearms2.Cloth_Movement", t = 2.7},
        {s = "Firearms2.M82_BoltForward", t = 3},
        {s = "Firearms2.Cloth_Movement", t = 3.45}
        },
    },
}