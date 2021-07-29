SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "KS-23K"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Tulsky Oruzheiny Zavod"
SWEP.Trivia_Calibre = "23×75mmR"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1971"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/shotguns/ks23k.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/ks23k.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 100
SWEP.DamageMin = 100 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 15
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 4 -- DefaultClip is automatically set.

SWEP.ShotgunReload = true
SWEP.ManualAction = true
SWEP.NoLastCycle = true

SWEP.Recoil = 15
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.08
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.2 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
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

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 620 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "23x75MMR" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "Firearms2_KS23"
SWEP.ShootDrySound = "fas2/empty_shotguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ks23k.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_slug"

SWEP.ShellModel = "models/shells/23mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Heavy
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.899, -3.7, 1.19),
    Ang = Angle(0.685, 0.04, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.35

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-3.8, -2, 0)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.5, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.5, -3, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 22

SWEP.AttachmentElements = {
    ["tritium"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Ironsight",
        DefaultAttName = "Ironsight",
        Slot = "fas2_tritium",
    },
    {
        PrintName = "Skills",
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
    ["draw"] = {
        Source = "draw",
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 30/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"fire01", "fire02", "fire03"},
        Time = 15/30,
        MinProgress = 0.45,
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        Time = 15/35,
        MinProgress = 0.37,
    },
    ["cycle"] = {
        Source = "pump",
        Time = 32/40,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        ShellEjectAt = 0.25,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0.125},
        {s = "Firearms2.KS23_PumpForward", t = 0.275},
        },
    },
    ["cycle_iron"] = {
        Source = "pump_iron",
        Time = 25/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        ShellEjectAt = 0.1,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0},
        {s = "Firearms2.KS23_PumpForward", t = 0.4},
        },
    },
    ["cycle_nomen"] = {
        Source = "pump_nomen",
        Time = 32/48,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        ShellEjectAt = 0.2,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0.11},
        {s = "Firearms2.KS23_PumpForward", t = 0.25},
        {s = "Firearms2.Cloth_Movement", t = 0.25},
        },
    },
    ["cycle_iron_nomen"] = {
        Source = "pump_nomen_iron",
        Time = 25/40,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        ShellEjectAt = 0.1,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0},
        {s = "Firearms2.KS23_PumpForward", t = 0.4},
        },
    },
    ["sgreload_start"] = {
        Source = "start",
        Time = 12/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
    },
    ["sgreload_start_empty"] = {
        Source = "start_empty",
        Time = 63/30,
        ShellEjectAt = 0.2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0},
        {s = "Firearms2.Magpouch_Pistol", t = 0.4},
        {s = "Firearms2.KS23_InsertPort", t = 0.6},
        {s = "Firearms2.Cloth_Movement", t = 0.6},
        {s = "Firearms2.KS23_PumpForward", t = 1.3},
        {s = "Firearms2.Cloth_Movement", t = 1.3},
        },
    },
    ["sgreload_start_nomen"] = {
        Source = "start_nomen",
        Time = 12/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
    },
    ["sgreload_start_empty_nomen"] = {
        Source = "start_empty_nomen",
        Time = 63/30,
        ShellEjectAt = 0.2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.KS23_PumpBack", t = 0},
        {s = "Firearms2.Magpouch_Pistol", t = 0.4},
        {s = "Firearms2.KS23_InsertPort", t = 0.6},
        {s = "Firearms2.Cloth_Movement", t = 0.6},
        {s = "Firearms2.KS23_PumpForward", t = 1.3},
        {s = "Firearms2.Cloth_Movement", t = 1.3},
        },
    },
    ["sgreload_insert"] = {
        Source = "insert",
        Time = 30/30,
        SoundTable = {
        {s = "Firearms2.Magpouch_Pistol", t = 0.07},
        {s = "Firearms2.KS23_Insert", t = 0.3},
        {s = "Firearms2.Cloth_Movement", t = 0.3},
        },
    },
    ["sgreload_insert_nomen"] = {
        Source = "insert_nomen",
        Time = 30/40,
        SoundTable = {
        {s = "Firearms2.Magpouch_Pistol", t = 0},
        {s = "Firearms2.KS23_Insert", t = 0.2},
        {s = "Firearms2.Cloth_Movement", t = 0.2},
        },
    },
    ["sgreload_finish"] = {
        Source = "end_nopump",
        Time = 16/30,
    },
    ["sgreload_finish_nomen"] = {
        Source = "end_nopump_nomen",
        Time = 16/40,
    },
    -- END WITH PUMP 
    -- ["sgreload_finish"] = {
    --     Source = "end",
    --     Time = 30/30,
    --     SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.KS23_PumpBack", t = 0.2},
    --     {s = "Firearms2.KS23_PumpForward", t = 0.2},
    --     {s = "Firearms2.Cloth_Movement", t = 0.2},
    --     },
    -- },
}