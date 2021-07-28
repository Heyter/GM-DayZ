SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "M16A2"
SWEP.Trivia_Class = "Assault rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Colt's Manufacturing Company"
SWEP.Trivia_Calibre = "5.56x45mm"
SWEP.Trivia_Country = "US"
SWEP.Trivia_Year = "1963"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/m16a2.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/m16a2.mdl"
SWEP.ViewModelFOV = 54

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 29
SWEP.DamageMin = 14 -- damage done at maximum range
SWEP.Range = 550 -- in METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 960 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.Recoil = 1.1
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.03
SWEP.RecoilPunch = 1.4
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.081 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = -3,
        PostBurstDelay = 0.1,
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
SWEP.HipDispersion = 420 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "5.56x45mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_M16A2"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m16a2.ogg"
SWEP.ShootSoundSilenced = "Firearms2_M16A2_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_6"

SWEP.ShellModel = "models/shells/5_56x45mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.2715, -3, 0.363),
    Ang = Angle(-0.08, 0, 1.75),
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

SWEP.CrouchPos = Vector(-0.8, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(3.5, -2, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3.5, -2, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(3.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 28

SWEP.RejectAttachments = {
    ["fas2_scope_pso1"] = true
}

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "smdimport",
                Offset = {
                    pos = Vector(0.09, 11, 0.92),
                    ang = Angle(0, -90, 0),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(29.3, 0.7, -8.12),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Bone = "smdimport",
                Offset = {
                    pos = Vector(0.09, 11, 0.92),
                    ang = Angle(0, -90, 0),
                },
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(29.3, 0.7, -8.12),
                    ang = Angle(-10.393, 0, 0),
                },
                Scale = Vector(1.8, 1.8, 1.8),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount", -- print name
        DefaultAttName = "Carryhandle",
        Slot = {"fas2_sight", "fas2_scope"}, -- what kind of attachments can fit here, can be string or table
        Bone = "smdimport", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.1, -3.02, 2.72), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 270, 0),
            wpos = Vector(5.2, 0.68, -6.855),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 4.5,
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(1.3, 1.3, 1.3),
        CorrectivePos = Vector(0, 0.055, 0.001),
        CorrectiveAng = Angle(0, 180, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
        Bone = "smdimport",
    },
    {
        PrintName = "Skills",
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
        Time = 19/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 19/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    -- ["ready"] = { 
    --     Source = "deploy_first",
    --     Time = 100/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --         {s = "Firearms2.Cloth_Movement", t = 0},
    --         {s = "Firearms2.M16A2_MagHousing", t = 1.03},
    --         {s = "Firearms2.Magpouch", t = 1.07},
    --         {s = "Firearms2.M16A2_MagIn", t = 1.27},
    --         {s = "Firearms2.Cloth_Movement", t = 1.27},
    --         {s = "Firearms2.M16A2_ChargeBack", t = 2.07},
    --         {s = "Firearms2.Cloth_Movement", t = 2.07},
    --         {s = "Firearms2.M16A2_ReleaseHandle", t = 2.27},
    --         },
    -- },
    ["holster"] = {
        Source = "holster",
        Time = 25/75,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 25/75,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 18/59,
        ShellEjectAt = 0,
    },
    ["fire"] = {
        Source = "",
        ShellEjectAt = 0,
    },
    ["fire1"] = {
        Source = "fire",
        Time = 18/60,
        ShellEjectAt = 0,
    },
    ["fire2"] = {
        Source = "fire2",
        Time = 18/62,
        ShellEjectAt = 0,
    },
    ["fire3"] = {
        Source = "fire3",
        Time = 18/58,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_scoped",
        Time = 9/60,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 73/30,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M16A2_MagOut", t = 0.42},
		{s = "Firearms2.Magpouch", t = 0.69},
		{s = "Firearms2.M16A2_MagHousing", t = 1.03},
		{s = "Firearms2.Cloth_Movement", t = 1.03},
		{s = "Firearms2.M16A2_MagIn", t = 1.27}
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 100/30,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M16A2_MagOutEmpty", t = 0.35},
		{s = "Firearms2.Magpouch", t = 0.6},
		{s = "Firearms2.M16A2_MagHousing", t = 1.03},
		{s = "Firearms2.Cloth_Movement", t = 1.03},
		{s = "Firearms2.M16A2_MagIn", t = 1.215},
		{s = "Firearms2.M16A2_BoltCatch", t = 2.13},
		{s = "Firearms2.Cloth_Movement", t = 2.13},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 73/37.5,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M16A2_MagOut", t = 0.34},
		{s = "Firearms2.Magpouch", t = 0.5},
		{s = "Firearms2.M16A2_MagHousing", t = 0.83},
		{s = "Firearms2.Cloth_Movement", t = 0.83},
		{s = "Firearms2.M16A2_MagIn", t = 0.98}
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 94/37.5,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.M16A2_MagOut", t = 0.4},
        {s = "Firearms2.Magpouch", t = 0.69},
        {s = "Firearms2.M16A2_MagHousing", t = 0.83},
        {s = "Firearms2.Cloth_Movement", t = 0.83},
        {s = "Firearms2.M16A2_MagIn", t = 0.99},
        {s = "Firearms2.Cloth_Movement", t = 1.55},
        {s = "Firearms2.M16A2_BoltCatch", t = 1.59},
		},
    },
}