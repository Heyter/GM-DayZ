SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "Remington 870"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Remington Arms"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1950"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/shotguns/remington870.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/remington870.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 9
SWEP.DamageMin = 9 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 710 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.

SWEP.ShotgunReload = true
SWEP.ManualAction = true
SWEP.NoLastCycle = true

SWEP.Recoil = 7
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 0.03
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.2 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "PUMP",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 70 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 340 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "12 Gauge" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "Firearms2_REM870"
SWEP.ShootDrySound = "fas2/empty_shotguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/bm16.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_shotgun"

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
    Pos = Vector(-1.856, -4.935, 1.919),
    Ang = Angle(0.1, 0.2, 0),
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

SWEP.CrouchPos = Vector(-4, -3, 0.5)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -5, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -5, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(6.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 29

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
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""

    return anim .. nomen
end

SWEP.Hook_SelectInsertAnimation = function(wep, anim)
    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""

    anim.anim = anim.anim .. nomen

    return anim
end

SWEP.Hook_SelectCycleAnimation = function(wep, anim)
    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""
    local iron = (wep:GetState() == ArcCW.STATE_SIGHTS and "_iron") or ""

    return "cycle" .. iron .. nomen
end

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 235/33,
    --     SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.Firemode_Switch", t = 1.2},
    --     {s = "Firearms2.Cloth_Movement", t = 1.2},
    --     {s = "Firearms2.REM870_PumpBack", t = 2.2},
    --     {s = "Firearms2.Cloth_Movement", t = 2.2},
    --     {s = "Firearms2.REM870_PumpForward", t = 3.3},
    --     {s = "Firearms2.Cloth_Movement", t = 3.3},
    --     {s = "Firearms2.REM870_Insert", t = 5.7},
    --     {s = "Firearms2.Cloth_Movement", t = 5.7},
    --     },
    -- },
    ["draw"] = {
        Source = "draw",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire02",
        Time = 15/30,
        MinProgress = 0.5,
    },
    ["fire_iron"] = {
        Source = "fire01_scoped",
        Time = 10/30,
        MinProgress = 0.4,
    },
    ["cycle"] = {
        Source = "pump02",
        Time = 20/30,
        ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        ShellEjectAt = 0.25,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0.1},
        {s = "Firearms2.REM870_PumpForward", t = 0.45},
        },
    },
    ["cycle_iron"] = {
        Source = "pump01_scoped",
        Time = 20/30,
        ShellEjectAt = 0.1,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0.1},
        {s = "Firearms2.REM870_PumpForward", t = 0.45},
        },
    },
    ["cycle_nomen"] = {
        Source = "pump01_nomen",
        Time = 15/30,
        ShellEjectAt = 0.1,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0},
        {s = "Firearms2.REM870_PumpForward", t = 0.3},
        },
    },
    ["cycle_iron_nomen"] = {
        Source = "pump01_nomen_scoped",
        Time = 15/30,
        ShellEjectAt = 0.1,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0},
        {s = "Firearms2.REM870_PumpForward", t = 0.3},
        },
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 15/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "Firearms2.Cloth_Movement", t = 0}},
    },
    ["sgreload_start_empty"] = {
        Source = "reload_start_empty",
        Time = 90/30,
        ShellEjectAt = 0.18,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0.15},
        {s = "Firearms2.M3S90_LoadEjectorPort", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.1},
        {s = "Firearms2.REM870_PumpForward", t = 1.8},
        {s = "Firearms2.Cloth_Movement", t = 1.8},
        },
    },
    ["sgreload_start_nomen"] = {
        Source = "reload_start_nomen",
        Time = 15/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "Firearms2.Cloth_Movement", t = 0}},
    },
    ["sgreload_start_empty_nomen"] = {
        Source = "reload_start_empty_nomen",
        Time = 80/30,
        ShellEjectAt = 0.18,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_PumpBack", t = 0.15},
        {s = "Firearms2.M3S90_LoadEjectorPort", t = 1.1},
        {s = "Firearms2.Cloth_Movement", t = 1.1},
        {s = "Firearms2.REM870_PumpForward", t = 1.85},
        {s = "Firearms2.Cloth_Movement", t = 1.85},
        },
    },
        ["sgreload_insert_nomen"] = {
        Source = "reload_nomen",
        Time = 25/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_Insert", t = 0.2},
        },
    },
    ["sgreload_insert"] = {
        Source = "reload",
        Time = 20/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.REM870_Insert", t = 0.2},
        },
    },
    ["sgreload_finish"] = {
        Source = "reload_end",
        Time = 15/30,
    },
    ["sgreload_finish_nomen"] = {
        Source = "reload_end_nomen",
        Time = 15/30,
        SoundTable = {{s = "Firearms2.Cloth_Movement", t = 0}},
    },
}