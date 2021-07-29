SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M249"
SWEP.Trivia_Class = "Light machine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "FN Herstal"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1970"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/machineguns/m249.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/machineguns/m249.mdl"
SWEP.ViewModelFOV = 50

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 32
SWEP.DamageMin = 32 -- damage done at maximum range
SWEP.Range = 800 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 915 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.

SWEP.Recoil = 2
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 0.04
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.089 -- 60 / RPM.
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
SWEP.HipDispersion = 410 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M249"
SWEP.DistantShootSound = "fas2/distant/m249.ogg"
SWEP.ShootSoundSilenced = "Firearms2_M249_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_6b"

SWEP.ShellModel = "models/shells/5_56x45mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.65
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-3.516, -3.5, 2.015),
    Ang = Angle(0.5, 0.01, 0),
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

SWEP.HolsterPos = Vector(6, -3, 1.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(6, -3, 1.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(6.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 27

SWEP.RejectAttachments = {
    ["fas2_muzzle_muzzlebrake"] = true,
    ["fas2_muzzle_flashhider"] = true
}

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["200mag"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["stanag"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
        WMBodygroups = {{ind = 2, bg = 2}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Lid",
        Offset = {
            vpos = Vector(-3.35, -0.375, 0),
            vang = Angle(0, 0, 270),
            wpos = Vector(5.75, 0.7, -7.22),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0, 0, 0.004),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle"},
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = {"fas2_m249_200rnd", "fas2_stanag"}
    },
}

local fisrtfire = false
SWEP.fisrtfire_starter = true

SWEP.Hook_TranslateAnimation = function(wep, anim)

    if wep:Clip1() == wep:GetMaxClip1() then return anim .. "_unfired" end

    if wep:Clip1() <= 10 then return anim .. wep:Clip1() end

    return anim
end

local stanag_installed = false

SWEP.Hook_SelectFireAnimation = function(wep, anim)
    stanag_installed = wep.Attachments[3].Installed == "fas2_mag_stanag"

    local iron = (wep:GetState() == ArcCW.STATE_SIGHTS and "_iron") or ""

    if wep:Clip1() <= 10 then return anim .. "_last" .. wep:Clip1() end

    return anim
end

SWEP.Hook_SelectReloadAnimation = function(wep, anim)

    wep.fisrtfire_starter = true

    local empty = (wep:Clip1() == 0 and "_empty") or ""
    if stanag_installed then 
        return anim .. empty .. "_stanag" 
    else
        if wep:Clip1() == 0 then 
            wep:ReloadLinkEject(1.8) 
        end
    end

    if wep:Clip1() <= 10 then return anim .. wep:Clip1() end

    return anim
end

SWEP.Animations = {
    ["idle"] = false,
    -- ["ready"] = { 
    --     Source = "",
    -- },

    -- ["deploy_first01"] = { 
    -- Source = "deploy_first01",
    -- Time = 60/30,
	-- ProcDraw = true,
	-- SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.M24_Butt", t = 0.8},
    --     {s = "Firearms2.M24_Butt", t = 1.17},
    --     {s = "Firearms2.Cloth_Movement", t = 1.3},
    --     },
    -- },

    -- ["deploy_first02"] = { 
    --     Source = "deploy_first02",
    --     Time = 135/30,
    --     ProcDraw = true,
    --     SoundTable = {
    --         {s = "Firearms2.Cloth_Movement", t = 0},
    --         {s = "Firearms2.M249_Lidopen", t = 0.65},
    --         {s = "Firearms2.M60_feeding_mechanism", t = 1.6},
    --         {s = "Firearms2.M60_feeding_mechanism", t = 1.9},
    --         {s = "Firearms2.M60_feeding_tray", t = 2.5},
    --         {s = "Firearms2.M249_Lidclose", t = 3.7},
    --         },
    --     },
    ["draw"] = {
        Source = "deploy",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_unfired"] = {
        Source = "deploy_unfired",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw0"] = {
        Source = "deploy_last0",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw1"] = {
        Source = "deploy_last1",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw2"] = {
        Source = "deploy_last2",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw3"] = {
        Source = "deploy_last3",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw4"] = {
        Source = "deploy_last4",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw5"] = {
        Source = "deploy_last5",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw6"] = {
        Source = "deploy_last6",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw7"] = {
        Source = "deploy_last7",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw8"] = {
        Source = "deploy_last8",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw9"] = {
        Source = "deploy_last9",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw10"] = {
        Source = "deploy_last10",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_unfired"] = {
        Source = "holster_unfired",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster0"] = {
        Source = "holster_last0",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster1"] = {
        Source = "holster_last1",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster2"] = {
        Source = "holster_last2",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster3"] = {
        Source = "holster_last3",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster4"] = {
        Source = "holster_last4",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster5"] = {
        Source = "holster_last5",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster6"] = {
        Source = "holster_last6",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster7"] = {
        Source = "holster_last7",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster8"] = {
        Source = "holster_last8",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster9"] = {
        Source = "holster_last9",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster10"] = {
        Source = "holster_last10",
        Time = 20/30,
        SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire_dry"] = {
        Source = "fire_empty",
    	SoundTable = {{s = "fas2/m249/m249_fire_empty.wav", t = 0}},
        Time = 45/50,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
    },
    ["fire_dry_iron"] = {
        Source = "fire_empty_scoped",
    	SoundTable = {{s = "fas2/m249/m249_fire_empty.wav", t = 0}},
        Time = 45/50,
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3"},
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire1_scoped", "fire2_scoped", "fire3_scoped"},
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last0"] = {
        Source = "fire1_last1",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last1"] = {
        Source = "fire1_last2",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last2"] = {
        Source = "fire1_last3",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last3"] = {
        Source = "fire1_last4",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last4"] = {
        Source = "fire1_last5",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last5"] = {
        Source = "fire1_last6",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last6"] = {
        Source = "fire1_last7",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last7"] = {
        Source = "fire1_last8",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last8"] = {
        Source = "fire1_last9",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last9"] = {
        Source = "fire1_last10",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_last10"] = {
        Source = "fire1_last11",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last0"] = {
        Source = "fire1_last1_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last1"] = {
        Source = "fire1_last2_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last2"] = {
        Source = "fire1_last3_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last3"] = {
        Source = "fire1_last4_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last4"] = {
        Source = "fire1_last5_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last5"] = {
        Source = "fire1_last6_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last6"] = {
        Source = "fire1_last7_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last7"] = {
        Source = "fire1_last8_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last8"] = {
        Source = "fire1_last9_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last9"] = {
        Source = "fire1_last10_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_iron_last10"] = {
        Source = "fire1_last11_scoped",
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_stanag"] = {
        Source = {"fire1_stanag", "fire2_stanag", "fire3_stanag"},
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["fire_stanag_iron"] = {
        Source = {"fire1_stanag_scoped", "fire2_stanag_scoped", "fire3_stanag_scoped"},
        Time = 45/55,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload10"] = {
        Source = "reload_last10",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload9"] = {
        Source = "reload_last9",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload8"] = {
        Source = "reload_last8",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload7"] = {
        Source = "reload_last7",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload6"] = {
        Source = "reload_last6",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload5"] = {
        Source = "reload_last5",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Beltremove", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload4"] = {
        Source = "reload_last4",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Belt4", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload3"] = {
        Source = "reload_last3",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Belt4", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload2"] = {
        Source = "reload_last2",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Belt5", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload1"] = {
        Source = "reload_last1",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 270/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Lidopen", t = 0.45},
        {s = "Firearms2.M249_Belt6", t = 1},
        {s = "Firearms2.M249_Boxremove", t = 2.375},
        {s = "Firearms2.M249_Boxinsert", t = 3.7},
        {s = "Firearms2.M249_Beltpull", t = 4.375},
        {s = "Firearms2.M249_Beltload", t = 5},
        {s = "Firearms2.M249_Lidclose", t = 5.625},
        },
    },
    ["reload0"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 300/40,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Charge", t = 0.35},
        {s = "Firearms2.M249_Lidopen", t = 1.2},
        {s = "Firearms2.M249_Belt6", t = 1.8},
        {s = "Firearms2.M249_Boxremove", t = 3.125},
        {s = "Firearms2.M249_Boxinsert", t = 4.45},
        {s = "Firearms2.M249_Beltpull", t = 5.125},
        {s = "Firearms2.M249_Beltload", t = 5.75},
        {s = "Firearms2.M249_Lidclose", t = 6.375},
        },
    },
    ["reload_stanag"] = {
        Source = "reload_stanag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 90/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M16A2_MagOut", t = 0.84},
        {s = "Firearms2.Magpouch", t = 1.44},
        {s = "Firearms2.M16A2_MagHousing", t = 2},
        {s = "Firearms2.M16A2_MagIn", t = 2.2},
        },
    },
    ["reload_empty_stanag"] = {
        Source = "reload_stanag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 120/30,
        SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M249_Charge", t = 0.34},
        {s = "Firearms2.M16A2_MagOut", t = 1.84},
        {s = "Firearms2.Magpouch", t = 2.4},
        {s = "Firearms2.M16A2_MagHousing", t = 3},
        {s = "Firearms2.M16A2_MagIn", t = 3.17},
        },
    },
}

function SWEP:DoShellEject()
    local owner = self:GetOwner()

    if !IsValid(owner) then return end

    local vm = self

    if !owner:IsNPC() then owner:GetViewModel() end

    local att = vm:GetAttachment(self:GetBuff_Override("Override_CaseEffectAttachment") or self.CaseEffectAttachment or 2)

    if !att then return end

    local pos, ang = att.Pos, att.Ang

    local ed = EffectData()
    ed:SetOrigin(pos)
    ed:SetAngles(ang)
    ed:SetAttachment(self:GetBuff_Override("Override_CaseEffectAttachment") or self.CaseEffectAttachment or 2)
    ed:SetScale(1.5)
    ed:SetEntity(self)
    ed:SetNormal(ang:Forward())
    ed:SetMagnitude(100)

    local efov = {}
    efov.eff = "arccw_shelleffect"
    efov.fx  = ed

    if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

    util.Effect("arccw_shelleffect", ed)

    if not stanag_installed then
        if not self.fisrtfire_starter then

            local att = vm:GetAttachment(3) or att

            local pos, ang = att.Pos, att.Ang

            local ed = EffectData()
            ed:SetOrigin(pos)
            ed:SetAngles(ang)
            ed:SetAttachment(3)
            ed:SetScale(1.5)
            ed:SetEntity(self)
            ed:SetNormal(ang:Forward())
            ed:SetMagnitude(100)

            local efov = {}
            efov.eff = "arccw_firearms2_m27_link"
            efov.fx  = ed

            util.Effect("arccw_firearms2_m27_link", ed)

        else
            self.fisrtfire_starter = false

            local ed = EffectData()
            ed:SetOrigin(pos)
            ed:SetAngles(ang)
            ed:SetAttachment(3)
            ed:SetScale(1.5)
            ed:SetEntity(self)
            ed:SetNormal(ang:Forward())
            ed:SetMagnitude(100)

            local efov = {}
            efov.eff = "arccw_firearms2_m27_starter"
            efov.fx  = ed

            util.Effect("arccw_firearms2_m27_starter", ed)
        end
    end
end

function SWEP:ReloadLinkEject(time)
    timer.Simple(time or 1.8, function()

        if not IsValid(self) then return end

        local owner = self:GetOwner()

        if !IsValid(owner) then return end

        local vm = self

        if !owner:IsNPC() then owner:GetViewModel() end

        local att = vm:GetAttachment(4)

        if !att then return end

        local pos, ang = att.Pos, att.Ang

        local ed = EffectData()
        ed:SetOrigin(pos)
        ed:SetAngles(ang)
        ed:SetAttachment(4)
        ed:SetScale(1.5)
        ed:SetEntity(self)
        ed:SetNormal(ang:Forward())
        ed:SetMagnitude(100)

        local efov = {}
        efov.eff = "arccw_firearms2_m27_link"
        efov.fx  = ed

        if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

        util.Effect("arccw_firearms2_m27_link", ed)
    end)
end