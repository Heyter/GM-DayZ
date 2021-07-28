SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "MC51B Vollmer"
SWEP.Trivia_Class = "Light machine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "FR Ordnance"
SWEP.Trivia_Calibre = "7.62x51mm"
SWEP.Trivia_Country = "United Kingdom"
SWEP.Trivia_Year = "1980"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/machineguns/mc51b.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/machineguns/mc51b.mdl"
SWEP.ViewModelFOV = 50

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 37
SWEP.DamageMin = 22 -- damage done at maximum range
SWEP.Range = 420 -- in METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 900 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.Recoil = 2.02
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.02
SWEP.RecoilPunch = 0.75
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.07945 -- 60 / RPM.
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
SWEP.HipDispersion = 550 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x51mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_VOLLMER"
SWEP.ShootDrySound = "fas2/empty_machineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/vollmer.ogg"
SWEP.ShootSoundSilenced = "Firearms2_VOLLMER_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_vollmer"

SWEP.ShellModel = "models/shells/7_62x51mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.75
SWEP.SightedSpeedMult = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-1.8615, -3.646, 0.775),
    Ang = Angle(0.6, 0.01, 0),    
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

SWEP.CrouchPos = Vector(-0.5, -3, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(5.532, -2, 0.8)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(5.532, -2, 0.8)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 26

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(0.72, -2.08, 0.134),
            vang = Angle(0, 0, 270),
            wpos = Vector(4.42, 0.68, -6.16),
            wang = Angle(-10.393, 0, 180)
        },
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(1.3, 1.3, 1.3),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle"},
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

local fisrtfire = false
SWEP.fisrtfire_starter = true

SWEP.Hook_TranslateAnimation = function(wep, anim)

    if wep:Clip1() <= 7 then return anim .. wep:Clip1() end

    return anim
end

SWEP.Hook_SelectFireAnimation = function(wep, anim)

    if wep:Clip1() + 1 == wep:GetMaxClip1() then return anim .. "_first" end

    if wep:Clip1() <= 7 then return anim .. "_last" .. wep:Clip1() end

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
    ["draw0"] = {
        Source = "deploy01",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw1"] = {
        Source = "deploy02",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw2"] = {
        Source = "deploy03",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw3"] = {
        Source = "deploy04",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw4"] = {
        Source = "deploy05",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw5"] = {
        Source = "deploy06",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw6"] = {
        Source = "deploy07",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw7"] = {
        Source = "deploy08",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = { 
    --     Source = "deploy_first",
    --     Time = 200/35,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --         {s = "Firearms2.Vollmer_stock", t = 0.43},
    --         {s = "Firearms2.Cloth_Movement", t = 0.8},
    --         {s = "Firearms2.Vollmer_boltback", t = 1.7},
    --         {s = "Firearms2.Vollmer_open", t = 2.72},
    --         {s = "Firearms2.Vollmer_beltpull", t = 3.18},
    --         {s = "Firearms2.Vollmer_Belt", t = 3.6},
    --         {s = "Firearms2.Vollmer_beltload", t = 4.28},
    --         {s = "Firearms2.Vollmer_boltforward", t = 5.18},
    --         },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster0"] = {
        Source = "holster01",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster1"] = {
        Source = "holster02",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster2"] = {
        Source = "holster03",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster3"] = {
        Source = "holster04",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster4"] = {
        Source = "holster05",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster5"] = {
        Source = "holster06",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster6"] = {
        Source = "holster07",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster7"] = {
        Source = "holster08",
        Time = 20/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire_first"] = {
        Source = "fire_first",
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_StarterTab", t = 0}},
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3"},
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_Belt", t = 0}},
    },
    ["fire_last0"] = {
        Source = "fire_last02",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_last1"] = {
        Source = "fire_last03",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_last2"] = {
        Source = "fire_last04",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_last3"] = {
        Source = "fire_last05",
        Time = 30/30,
        ShellEjectAt = 0,
    },
    ["fire_last4"] = {
        Source = "fire_last06",
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_Belt", t = 0}},
    },
    ["fire_last5"] = {
        Source = "fire_last07",
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_Belt", t = 0}},
    },
    ["fire_last6"] = {
        Source = "fire_last08",
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_Belt", t = 0}},
    },
    ["fire_last7"] = {
        Source = "fire_last09",
        Time = 30/30,
        ShellEjectAt = 0,
        SoundTable = {{s = "Firearms2.Vollmer_Belt", t = 0}},
    },
    ["reload0"] = {
        Source = "reload01",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 240/32.14,
		SoundTable = {
		{s = "Firearms2.Vollmer_boltback", t = 0.38},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.Vollmer_open", t = 1.25},
        {s = "Firearms2.Vollmer_boxout", t = 1.8},
        {s = "Firearms2.Vollmer_box", t = 3.49},
		{s = "Firearms2.Vollmer_rip", t = 3.8},
		{s = "Firearms2.Vollmer_beltpull", t = 4.33},
		{s = "Firearms2.Vollmer_boxin", t = 4.95},
		{s = "Firearms2.Vollmer_close", t = 5.57},
		{s = "Firearms2.Vollmer_belt", t = 6.15},
		{s = "Firearms2.Vollmer_beltload", t = 6.26},
		{s = "Firearms2.Vollmer_boltforward", t = 6.85},
		},
    },
    ["reload1"] = {
        Source = "reload02",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
        {s = "Firearms2.Vollmer_boxout", t = 1.25},
        {s = "Firearms2.Vollmer_box", t = 2.96},
		{s = "Firearms2.Vollmer_rip", t = 3.3},
		{s = "Firearms2.Vollmer_beltpull", t = 3.77},
		{s = "Firearms2.Vollmer_boxin", t = 4.49},
		{s = "Firearms2.Vollmer_close", t = 5.11},
		{s = "Firearms2.Vollmer_belt", t = 5.6},
		{s = "Firearms2.Vollmer_beltload", t = 5.73},
		},
    },
    ["reload2"] = {
        Source = "reload03",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
        {s = "Firearms2.Vollmer_boxout", t = 1.25},
        {s = "Firearms2.Vollmer_box", t = 2.96},
		{s = "Firearms2.Vollmer_rip", t = 3.3},
		{s = "Firearms2.Vollmer_beltpull", t = 3.77},
		{s = "Firearms2.Vollmer_boxin", t = 4.49},
		{s = "Firearms2.Vollmer_close", t = 5.11},
		{s = "Firearms2.Vollmer_belt", t = 5.6},
		{s = "Firearms2.Vollmer_beltload", t = 5.73},
		},
    },
    ["reload3"] = {
        Source = "reload04",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
        {s = "Firearms2.Vollmer_boxout", t = 1.25},
        {s = "Firearms2.Vollmer_box", t = 2.96},
		{s = "Firearms2.Vollmer_rip", t = 3.3},
		{s = "Firearms2.Vollmer_beltpull", t = 3.77},
		{s = "Firearms2.Vollmer_boxin", t = 4.49},
		{s = "Firearms2.Vollmer_close", t = 5.11},
		{s = "Firearms2.Vollmer_belt", t = 5.6},
		{s = "Firearms2.Vollmer_beltload", t = 5.73},
		},
    },
    ["reload4"] = {
        Source = "reload05",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
		{s = "Firearms2.Vollmer_belt", t = 0.69},
        {s = "Firearms2.Vollmer_boxout", t = 1.25},
        {s = "Firearms2.Vollmer_box", t = 2.96},
		{s = "Firearms2.Vollmer_rip", t = 3.3},
		{s = "Firearms2.Vollmer_beltpull", t = 3.77},
		{s = "Firearms2.Vollmer_boxin", t = 4.49},
		{s = "Firearms2.Vollmer_close", t = 5.11},
		{s = "Firearms2.Vollmer_belt", t = 5.6},
		{s = "Firearms2.Vollmer_beltload", t = 5.73},
		},
    },
    ["reload5"] = {
        Source = "reload06",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
		{s = "Firearms2.Vollmer_belt", t = 0.69},
        {s = "Firearms2.Vollmer_boxout", t = 1.25},
        {s = "Firearms2.Vollmer_box", t = 2.96},
		{s = "Firearms2.Vollmer_rip", t = 3.3},
		{s = "Firearms2.Vollmer_beltpull", t = 3.77},
		{s = "Firearms2.Vollmer_boxin", t = 4.49},
		{s = "Firearms2.Vollmer_close", t = 5.11},
		{s = "Firearms2.Vollmer_belt", t = 5.6},
		{s = "Firearms2.Vollmer_beltload", t = 5.73},
		},
    },
    ["reload6"] = {
        Source = "reload07",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/32.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_open", t = 0.53},
		{s = "Firearms2.Vollmer_belt", t = 1.09},
        {s = "Firearms2.Vollmer_boxout", t = 1.78},
        {s = "Firearms2.Vollmer_box", t = 3.4},
		{s = "Firearms2.Vollmer_rip", t = 3.77},
		{s = "Firearms2.Vollmer_beltpull", t = 4.24},
		{s = "Firearms2.Vollmer_boxin", t = 4.92},
		{s = "Firearms2.Vollmer_close", t = 5.57},
		{s = "Firearms2.Vollmer_belt", t = 6.1},
		{s = "Firearms2.Vollmer_beltload", t = 6.2},
		},
    },
    ["reload7"] = {
        Source = "reload08",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/32.14,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.53},
        {s = "Firearms2.Vollmer_belt", t = 1.09},
        {s = "Firearms2.Vollmer_boxout", t = 1.78},
        {s = "Firearms2.Vollmer_box", t = 3.4},
        {s = "Firearms2.Vollmer_rip", t = 3.77},
        {s = "Firearms2.Vollmer_beltpull", t = 4.24},
        {s = "Firearms2.Vollmer_boxin", t = 4.92},
        {s = "Firearms2.Vollmer_close", t = 5.57},
        {s = "Firearms2.Vollmer_belt", t = 6.1},
        {s = "Firearms2.Vollmer_beltload", t = 6.2},
		},
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/32.14,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_beltremove", t = 0.6},
        {s = "Firearms2.Vollmer_open", t = 1.22},
        {s = "Firearms2.Vollmer_boxout", t = 1.78},
        {s = "Firearms2.Vollmer_box", t = 3.4},
        {s = "Firearms2.Vollmer_rip", t = 3.77},
        {s = "Firearms2.Vollmer_beltpull", t = 4.24},
        {s = "Firearms2.Vollmer_boxin", t = 4.92},
        {s = "Firearms2.Vollmer_close", t = 5.57},
        {s = "Firearms2.Vollmer_belt", t = 6.1},
        {s = "Firearms2.Vollmer_beltload", t = 6.2},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Vollmer_beltremove", t = 0.48},
		{s = "Firearms2.Vollmer_open", t = 0.98},
        {s = "Firearms2.Vollmer_boxout", t = 1.43},
        {s = "Firearms2.Vollmer_box", t = 2.72},
		{s = "Firearms2.Vollmer_rip", t = 3.02},
		{s = "Firearms2.Vollmer_beltpull", t = 3.39},
		{s = "Firearms2.Vollmer_boxin", t = 3.94},
		{s = "Firearms2.Vollmer_close", t = 4.46},
		{s = "Firearms2.Vollmer_belt", t = 4.75},
		{s = "Firearms2.Vollmer_beltload", t = 4.95},
		},
    },
    ["reload7_nomen"] = {
        Source = "reload08_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_belt", t = 0.88},
        {s = "Firearms2.Vollmer_boxout", t = 1.43},
        {s = "Firearms2.Vollmer_box", t = 2.72},
		{s = "Firearms2.Vollmer_rip", t = 3.02},
		{s = "Firearms2.Vollmer_beltpull", t = 3.39},
		{s = "Firearms2.Vollmer_boxin", t = 3.94},
		{s = "Firearms2.Vollmer_close", t = 4.46},
		{s = "Firearms2.Vollmer_belt", t = 4.75},
		{s = "Firearms2.Vollmer_beltload", t = 4.95},
		},
    },
    ["reload6_nomen"] = {
        Source = "reload07_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 225/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_belt", t = 0.88},
        {s = "Firearms2.Vollmer_boxout", t = 1.43},
        {s = "Firearms2.Vollmer_box", t = 2.72},
		{s = "Firearms2.Vollmer_rip", t = 3.02},
		{s = "Firearms2.Vollmer_beltpull", t = 3.39},
		{s = "Firearms2.Vollmer_boxin", t = 3.94},
		{s = "Firearms2.Vollmer_close", t = 4.46},
		{s = "Firearms2.Vollmer_belt", t = 4.75},
		{s = "Firearms2.Vollmer_beltload", t = 4.95},
		},
    },
    ["reload5_nomen"] = {
        Source = "reload06_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_belt", t = 0.55},
        {s = "Firearms2.Vollmer_boxout", t = 1},
        {s = "Firearms2.Vollmer_box", t = 2.37},
		{s = "Firearms2.Vollmer_rip", t = 2.65},
		{s = "Firearms2.Vollmer_beltpull", t = 3.02},
		{s = "Firearms2.Vollmer_boxin", t = 3.57},
		{s = "Firearms2.Vollmer_close", t = 4.08},
		{s = "Firearms2.Vollmer_belt", t = 4.5},
		{s = "Firearms2.Vollmer_beltload", t = 4.59},
		},
    },
    ["reload4_nomen"] = {
        Source = "reload05_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_belt", t = 0.55},
        {s = "Firearms2.Vollmer_boxout", t = 1},
        {s = "Firearms2.Vollmer_box", t = 2.37},
		{s = "Firearms2.Vollmer_rip", t = 2.65},
		{s = "Firearms2.Vollmer_beltpull", t = 3.02},
		{s = "Firearms2.Vollmer_boxin", t = 3.57},
		{s = "Firearms2.Vollmer_close", t = 4.08},
		{s = "Firearms2.Vollmer_belt", t = 4.5},
		{s = "Firearms2.Vollmer_beltload", t = 4.59},
		},
    },
    ["reload3_nomen"] = {
        Source = "reload04_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_boxout", t = 1},
        {s = "Firearms2.Vollmer_box", t = 2.37},
		{s = "Firearms2.Vollmer_rip", t = 2.65},
		{s = "Firearms2.Vollmer_beltpull", t = 3.02},
		{s = "Firearms2.Vollmer_boxin", t = 3.57},
		{s = "Firearms2.Vollmer_close", t = 4.08},
		{s = "Firearms2.Vollmer_belt", t = 4.5},
		{s = "Firearms2.Vollmer_beltload", t = 4.59},
		},
    },
    ["reload2_nomen"] = {
        Source = "reload03_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_boxout", t = 1},
        {s = "Firearms2.Vollmer_box", t = 2.37},
		{s = "Firearms2.Vollmer_rip", t = 2.65},
		{s = "Firearms2.Vollmer_beltpull", t = 3.02},
		{s = "Firearms2.Vollmer_boxin", t = 3.57},
		{s = "Firearms2.Vollmer_close", t = 4.08},
		{s = "Firearms2.Vollmer_belt", t = 4.5},
		{s = "Firearms2.Vollmer_beltload", t = 4.59},
		},
    },
    ["reload1_nomen"] = {
        Source = "reload02_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 210/40.14,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.Vollmer_open", t = 0.43},
        {s = "Firearms2.Vollmer_boxout", t = 1},
        {s = "Firearms2.Vollmer_box", t = 2.37},
		{s = "Firearms2.Vollmer_rip", t = 2.65},
		{s = "Firearms2.Vollmer_beltpull", t = 3.02},
		{s = "Firearms2.Vollmer_boxin", t = 3.57},
		{s = "Firearms2.Vollmer_close", t = 4.08},
		{s = "Firearms2.Vollmer_belt", t = 4.5},
		{s = "Firearms2.Vollmer_beltload", t = 4.59},
		},
    },
    ["reload0_nomen"] = {
        Source = "reload01_NOMEN",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 240/40.14,
		SoundTable = {
		{s = "Firearms2.Vollmer_boltback", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.42},
        {s = "Firearms2.Vollmer_open", t = 1},
        {s = "Firearms2.Vollmer_boxout", t = 1.45},
        {s = "Firearms2.Vollmer_box", t = 2.8},
		{s = "Firearms2.Vollmer_rip", t = 3.04},
		{s = "Firearms2.Vollmer_beltpull", t = 3.47},
		{s = "Firearms2.Vollmer_boxin", t = 3.97},
		{s = "Firearms2.Vollmer_close", t = 4.46},
		{s = "Firearms2.Vollmer_belt", t = 4.9},
		{s = "Firearms2.Vollmer_beltload", t = 5.01},
		{s = "Firearms2.Vollmer_boltforward", t = 5.49},
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
        efov.eff = "arccw_firearms2_mc51_link"
        efov.fx  = ed

        util.Effect("arccw_firearms2_mc51_link", ed)

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
        efov.eff = "arccw_firearms2_mc51_starter"
        efov.fx  = ed

        util.Effect("arccw_firearms2_mc51_starter", ed)
    end
end