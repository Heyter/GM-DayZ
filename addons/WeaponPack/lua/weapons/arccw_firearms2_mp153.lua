SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "MP-153"
SWEP.Trivia_Class = "Semi-Automatic Shotgun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Kalashnikov Concern"
SWEP.Trivia_Calibre = "12-Gauge"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = "2001"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/shotguns/mp153.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/mp153.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 6
SWEP.DamageMin = 1 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 715 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.

SWEP.ShotgunReload = true

SWEP.Recoil = 1.5
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.09
SWEP.RecoilPunch = 3
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.4 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 60 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 290 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "12 Gauge" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_MP153"
SWEP.ShootDrySound = "fas2/empty_shotguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m3s90.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_M3"

SWEP.ShellModel = "models/shells/12g_buck.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_ShotgunShell
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.27, -1.151, 1.735),
    Ang = Angle(0.4, 0.01, 0),
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

SWEP.CrouchPos = Vector(-4.2, -3, 0.7)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -5, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -5, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 35

SWEP.AttachmentElements = {
    ["incendiary"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
    },
    ["slug"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Ammunition",
        DefaultAttName = "Default Ammunition",
        Slot = "fas2_ammo_shotgun",
    },
}

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 80/30,
    --     SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0.8},
    --     {s = "Firearms2.MP153_BoltBack", t = 1.4},
    --     {s = "Firearms2.MP153_BoltForward", t = 1.6},
    --     {s = "Firearms2.Cloth_Movement", t = 1.6}
    --     },
    -- },
    ["draw"] = {
        Source = "deploy",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire1",
        Time = 28/35,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 28/35,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        Time = 28/35,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "fire_iron_last",
        Time = 28/35,
        ShellEjectAt = 0,
    },
    ["sgreload_start"] = {
        Source = "start",
        Time = 20/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "Firearms2.MP153_Start", t = 0.01}},
    },
    ["sgreload_start_empty"] = {
        Source = "start_empty",
        Time = 73/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
            {s = "Firearms2.MP153_Start", t = 0.01},
            {s = "Firearms2.M3S90_LoadEjectorPort", t = 0.8},
            {s = "Firearms2.Cloth_Movement", t = 0.5},
            {s = "Firearms2.Cloth_Movement", t = 1.2},
            {s = "Firearms2.MP153_BoltForward", t = 1.5},
            {s = "Firearms2.Cloth_Movement", t = 1.6}
            },
    },
    ["sgreload_insert"] = {
        Source = "insert",
        Time = 40/30,
        MinProgress = 1.34,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "Firearms2.MP153_Insert", t = 0.2}},
        SoundTable = {
            {s = "Firearms2.MP153_Insert", t = 0.2},
            {s = "Firearms2.Cloth_Movement", t = 0.2}
            },
    },
    ["sgreload_finish"] = {
        Source = "end",
        Time = 20/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "Firearms2.MP153_End", t = 0.01}},
    },
}
