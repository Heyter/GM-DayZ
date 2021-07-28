SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M60E3"
SWEP.Trivia_Class = "General-purpose machine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Saco Defense"
SWEP.Trivia_Calibre = "7.62x51mm"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1957"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/machineguns/m60e3.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/machineguns/m60e3.mdl"
SWEP.ViewModelFOV = 58

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 42
SWEP.DamageMin = 27 -- damage done at maximum range
SWEP.Range = 1100 -- in METRES
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 900 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.

SWEP.Recoil = 1.45585
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 1.098
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.09111 -- 60 / RPM.
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
SWEP.HipDispersion = 510 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M60E3"
SWEP.ShootDrySound = "fas2/empty_machineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m60e3.ogg"
SWEP.ShootSoundSilenced = "Firearms2_M60E3_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_5"

SWEP.ShellModel = "models/shells/7_62x51mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.6
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-2.835, -5.474, 1.8),
    Ang = Angle(0.1, 0, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.5

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

SWEP.HolsterPos = Vector(5, -3, 1)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(5, -3, 1)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 28

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["mount"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Bone20",
        Offset = {
            vpos = Vector(2.4, 0.59, 0.01),
            vang = Angle(180, 0, 90),
            wpos = Vector(3.1, 0.68, -7.85),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0.003, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle"},
    },
    {
        PrintName = "Skills",
        Slot = "fas2_nomen",
    },
}

local fisrtfire = false
SWEP.fisrtfire_starter = true

SWEP.Hook_TranslateAnimation = function(wep, anim)

    if wep:Clip1() == wep:GetMaxClip1() then return anim .. "_unfired" end

    if wep:Clip1() <= 7 then return anim .. wep:Clip1() end

    return anim
end

SWEP.Hook_SelectFireAnimation = function(wep, anim)

    if wep:Clip1() + 1 == wep:GetMaxClip1() then return anim .. "_first" end

    if wep:Clip1() <= 7 then return anim .. "_last" .. wep:Clip1() end

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

SWEP.Hook_SelectReloadAnimation = function(wep, anim)

    wep.fisrtfire_starter = true

    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""

    if wep:Clip1() <= 7 then return anim .. wep:Clip1() .. nomen end

    return anim .. nomen
end

SWEP.Animations = {
    ["idle"] = false,
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
        Source = "deploy00",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw1"] = {
        Source = "deploy01",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw2"] = {
        Source = "deploy02",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw3"] = {
        Source = "deploy03",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw4"] = {
        Source = "deploy04",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw5"] = {
        Source = "deploy05",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw6"] = {
        Source = "deploy06",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw7"] = {
        Source = "deploy07",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = { 
    --     Source = "deploy_first",
    --     Time = 360/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --         {s = "Firearms2.M60_carryinghandle", t = 1.07},
    --         {s = "Firearms2.M60_charge", t = 1.9},
    --         {s = "Firearms2.M60_open", t = 2.9},
    --         {s = "Firearms2.M60_feeding_mechanism", t = 3.47},
    --         {s = "Firearms2.M60_feeding_mechanism", t = 3.77},
    --         {s = "Firearms2.M60_feeding_tray", t = 4.44},
    --         {s = "Firearms2.M60_belt_insert", t = 5.67},
    --         {s = "Firearms2.M60_belt", t = 6.24},
    --         {s = "Firearms2.M60_close", t = 7.2},
    --         {s = "Firearms2.M60_flipsights", t = 7.67},
    --         {s = "Firearms2.M60_bipod", t = 8.34},
    --         {s = "Firearms2.M60_shoulderrest", t = 9.5},
    --         {s = "Firearms2.M60_bipod", t = 10.84},
    --         },
    -- },
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
        Source = "holster00",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster1"] = {
        Source = "holster01",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster2"] = {
        Source = "holster02",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster3"] = {
        Source = "holster03",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster4"] = {
        Source = "holster04",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster5"] = {
        Source = "holster05",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster6"] = {
        Source = "holster06",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster7"] = {
        Source = "holster07",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire_first"] = {
        Source = "fire_first",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_startertab", t = 0}},
    },
    ["fire"] = {
        Source = "",
        Time = 1/1,
    },
    ["fire1"] = {
        Source = "fire1",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire2"] = {
        Source = "fire2",
        Time = 30/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire3"] = {
        Source = "fire3",
        Time = 30/40,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire_dry"] = {
        Source = "fire_last00",
        SoundTable = {{s = "Firearms2.M60_fire_empty", t = 0}},
        Time = 30/35,
    },
    ["fire_last0"] = {
        Source = "fire_last01",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_last1"] = {
        Source = "fire_last02",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_last2"] = {
        Source = "fire_last03",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_last3"] = {
        Source = "fire_last04",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_last4"] = {
        Source = "fire_last05",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire_last5"] = {
        Source = "fire_last06",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire_last6"] = {
        Source = "fire_last07",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["fire_last7"] = {
        Source = "fire_last08",
        Time = 30/35,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.M60_belt", t = 0}},
    },
    ["reload0"] = {
        Source = "reload_fired00",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_charge", t = 1.03},
        {s = "Firearms2.M60_velcro_rip", t = 2.39},
        {s = "Firearms2.M60_cardboard_remove", t = 2.99},
        {s = "Firearms2.M60_cardboard_insert", t = 4.43},
        {s = "Firearms2.M60_cardboard_rip", t = 4.89},
        {s = "Firearms2.M60_belt_insert", t = 5.53},
        {s = "Firearms2.M60_velcro_close", t = 6.89},
        {s = "Firearms2.M60_close", t = 7.43},
		},
    },
    ["reload1"] = {
        Source = "reload01",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
		},
    },
    ["reload2"] = {
        Source = "reload02",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
		},
    },
    ["reload3"] = {
        Source = "reload03",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
        },
    },
    ["reload4"] = {
        Source = "reload04",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
        },
    },
    ["reload5"] = {
        Source = "reload05",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt_remove", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
        },
    },
    ["reload6"] = {
        Source = "reload06",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt_remove", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
        },
    },
    ["reload7"] = {
        Source = "reload07",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt_remove", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.43},
        },
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/33.13,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.37},
        {s = "Firearms2.M60_belt_remove", t = 1},
        {s = "Firearms2.M60_velcro_rip", t = 2.33},
        {s = "Firearms2.M60_cardboard_remove_full", t = 2.9},
        {s = "Firearms2.M60_cardboard_insert", t = 4.35},
        {s = "Firearms2.M60_cardboard_rip", t = 4.83},
        {s = "Firearms2.M60_belt_insert", t = 5.47},
        {s = "Firearms2.M60_velcro_close", t = 6.86},
        {s = "Firearms2.M60_close", t = 7.37},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove_full", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
		},
    },
    ["reload7_nomen"] = {
        Source = "reload07_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove_full", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload6_nomen"] = {
        Source = "reload06_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove_full", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload5_nomen"] = {
        Source = "reload05_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload4_nomen"] = {
        Source = "reload04_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload3_nomen"] = {
        Source = "reload03_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_belt_remove", t = 0.8},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload2_nomen"] = {
        Source = "reload02_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload1_nomen"] = {
        Source = "reload01_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_velcro_rip", t = 1.86},
        {s = "Firearms2.M60_cardboard_remove", t = 2.32},
        {s = "Firearms2.M60_cardboard_insert", t = 3.48},
        {s = "Firearms2.M60_cardboard_rip", t = 3.87},
        {s = "Firearms2.M60_belt_insert", t = 4.38},
        {s = "Firearms2.M60_velcro_close", t = 5.49},
        {s = "Firearms2.M60_close", t = 5.95},
        },
    },
    ["reload0_nomen"] = {
        Source = "reload_fired00_nomen",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 265/41.41,
		SoundTable = {
        {s = "Firearms2.M60_open", t = 0.29},
        {s = "Firearms2.M60_charge", t = 0.89},
        {s = "Firearms2.M60_velcro_rip", t = 1.91},
        {s = "Firearms2.M60_cardboard_remove", t = 2.4},
        {s = "Firearms2.M60_cardboard_insert", t = 3.55},
        {s = "Firearms2.M60_cardboard_rip", t = 3.92},
        {s = "Firearms2.M60_belt_insert", t = 4.42},
        {s = "Firearms2.M60_velcro_close", t = 5.51},
        {s = "Firearms2.M60_close", t = 5.95},
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
    ed:SetScale(1)
    ed:SetEntity(self)
    ed:SetNormal(ang:Forward())
    ed:SetMagnitude(100)

    local efov = {}
    efov.eff = "arccw_shelleffect"
    efov.fx  = ed

    if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

    util.Effect("arccw_shelleffect", ed)

    if not self.fisrtfire_starter then

        local att = vm:GetAttachment(3) or att

        local pos, ang = att.Pos, att.Ang

        local ed = EffectData()
        ed:SetOrigin(pos)
        ed:SetAngles(ang)
        ed:SetAttachment(3)
        ed:SetScale(1)
        ed:SetEntity(self)
        ed:SetNormal(ang:Forward())
        ed:SetMagnitude(100)

        local efov = {}
        efov.eff = "arccw_firearms2_m60_link"
        efov.fx  = ed

        util.Effect("arccw_firearms2_m60_link", ed)

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
        efov.eff = "arccw_firearms2_m60_starter"
        efov.fx  = ed

        util.Effect("arccw_firearms2_m60_starter", ed)
    end
end