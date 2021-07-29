SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 2

SWEP.PrintName = "MP5A5"
SWEP.Trivia_Class = "Submachine gun"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = "9x19MM"
SWEP.Trivia_Country = "West Germany"
SWEP.Trivia_Year = "1966"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/smgs/mp5a5.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/smgs/mp5a5.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 20
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 15 -- DefaultClip is automatically set.

SWEP.Recoil = 1.3
SWEP.RecoilSide = 0.03
SWEP.RecoilRise = 0.01
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.075 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
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
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "9x19MM" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_MP5"
SWEP.ShootDrySound = "fas2/empty_submachineguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/mp5a5.ogg"
SWEP.ShootSoundSilenced = "Firearms2_MP5k_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_mp5"

SWEP.ShellModel = "models/shells/9x19mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.962, -3.449, 0.958),
    Ang = Angle(0, 0.05, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-3.8, -3, 0)
SWEP.CrouchAng = Angle(0, 0, -45)

SWEP.HolsterPos = Vector(4.532, -3.5, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4.532, -3.5, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 25

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["grip"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["30rnd"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
        ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(9.28, -0.48, 0),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_smg.mdl",
                Offset = {
                    pos = Vector(20.65, 0.6, -7.2),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.9, 1.9, 1.9),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(9.28, -0.51, 0),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_smg.mdl",
                Offset = {
                    pos = Vector(20.65, 0.6, -7.2),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.9, 1.9, 1.9),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_scope"},
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(1.55, -1.55, 0),
            vang = Angle(0, 0, 270),
            wpos = Vector(7.2, 0.66, -6.65),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0.003, 0, 0.00),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider"},
    },
    {
        PrintName = "Handguard",
        DefaultAttName = "Standard Handguard",
        Slot = {"fas2_grip"}
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = {"fas2_mp5_30rnd"}
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)

    if wep.Attachments[3].Installed == "fas2_extra_foregrip" then return anim .. "_grip" end

end

SWEP.Hook_SelectFireAnimation = function(wep, anim)

    if wep.Attachments[3].Installed == "fas2_extra_foregrip" then return anim .. "_grip" end

end

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""

    if wep.Attachments[3].Installed == "fas2_extra_foregrip" then return anim .. nomen .. "_grip" end

end

-- SWEP.Hook_TranslateAnimation = function(wep, anim)
--     if anim != "ready" then return end

--     local dice = util.SharedRandom("ReadyOrNot", 0, 0.7, CurTime())

--     if dice <= 0.3 then
--         return "deploy_first1"
--     elseif dice <= 0.4 then
--         return "deploy_first"
--     elseif dice <= 0.5 then
--         return "deploy_first2"
--     elseif dice <= 0.6 then
--         return "deploy_first3"
--     else
--         return "deploy_first4"
--     end
-- end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle1",
        Time = 0/1,
    },
    ["idle_grip"] = {
        Source = "idle1_grip",
        Time = 0/1,
    },
    -- ["deploy_first"] = {
    --     Source = "deploy_first",
    --     Time = 50/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.2},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.65},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.65},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.8},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.95},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.95},
	-- 	},
    -- },
    -- ["deploy_first1"] = {
    --     Source = "deploy_first1",
    --     Time = 115/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.MP5_BoltBack", t = 0.55},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.55},
	-- 	{s = "Firearms2.MP5_MagIn", t = 2.35},
	-- 	{s = "Firearms2.Cloth_Movement", t = 2.35},
	-- 	{s = "Firearms2.MP5_BoltForward", t = 3.15},
	-- 	{s = "Firearms2.Cloth_Movement", t = 3.15},
	-- 	},
    -- },
    -- ["deploy_first2"] = {
    --     Source = "deploy_first2",
    --     Time = 60/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.2},
	-- 	{s = "Firearms2.MP5_Stock", t = 0.8},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.8},
	-- 	},
    -- },
    -- ["deploy_first3"] = {
    --     Source = "deploy_first3",
    --     Time = 30/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 0.2},
    --     {s = "Firearms2.MP5_Stock", t = 0.7},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.7},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.8},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.9},
    --     {s = "Firearms2.Cloth_Movement", t = 0.9},
	-- 	},
    -- },
    -- ["deploy_first4"] = {
    --     Source = "deploy_first4",
    --     Time = 20/30,
    --     ProcDraw = true,
    --     SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    -- },

    -- ["deploy_first_grip"] = {
    --     Source = "deploy_first_grip",
    --     Time = 50/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.2},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.65},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.65},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.8},
	-- 	{s = "Firearms2.MP5_SelectorSwitch", t = 0.95},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.95},
	-- 	},
    -- },
    -- ["deploy_first1_grip"] = {
    --     Source = "deploy_first1_grip",
    --     Time = 115/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.MP5_BoltBack", t = 0.55},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.55},
	-- 	{s = "Firearms2.MP5_MagIn", t = 2.35},
	-- 	{s = "Firearms2.Cloth_Movement", t = 2.35},
	-- 	{s = "Firearms2.MP5_BoltForward", t = 3.15},
	-- 	{s = "Firearms2.Cloth_Movement", t = 3.15},
	-- 	},
    -- },
    -- ["deploy_first2_grip"] = {
    --     Source = "deploy_first2_grip",
    --     Time = 60/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
	-- 	{s = "Firearms2.Deploy", t = 0},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.2},
	-- 	{s = "Firearms2.MP5_Stock", t = 0.8},
	-- 	{s = "Firearms2.Cloth_Movement", t = 0.8},
	-- 	},
    -- },
    -- ["deploy_first3_grip"] = {
    --     Source = "deploy_first3_grip",
    --     Time = 30/30,
	-- 	ProcDraw = true,
	-- 	SoundTable = {
    --     {s = "Firearms2.Deploy", t = 0},
    --     {s = "Firearms2.Cloth_Movement", t = 0.2},
    --     {s = "Firearms2.MP5_Stock", t = 0.7},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.7},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.8},
    --     {s = "Firearms2.MP5_SelectorSwitch", t = 0.9},
    --     {s = "Firearms2.Cloth_Movement", t = 0.9},
	-- 	},
    -- },
    -- ["deploy_first4_grip"] = {
    --     Source = "deploy_first4_grip",
    --     Time = 20/30,
    --     ProcDraw = true,
    --     SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    -- },  
    -- ["ready"] = {
    --     Source = "",
    -- },
    ["draw"] = {
        Source = "deploy",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "deploy_empty",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["draw_grip"] = {
        Source = "deploy_grip",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty_grip"] = {
        Source = "deploy_empty_grip",
        Time = 20/40,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster_grip"] = {
        Source = "holster_grip",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty_grip"] = {
        Source = "holster_empty_grip",
        Time = 20/60,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"shoot", "shoot2", "shoot3"},
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_last",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_scoped",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_last_scoped",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_grip"] = {
        Source = {"shoot_grip", "shoot2_grip", "shoot3_grip"},
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_empty_grip"] = {
        Source = "shoot_last_grip",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_iron_grip"] = {
        Source = "shoot_scoped_grip",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty_grip"] = {
        Source = "shoot_last_scoped_grip",
        Time = 30/35,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch_SMG", t = 1.2},
		{s = "Firearms2.MP5_MagIn", t = 2.15},
		{s = "Firearms2.Cloth_Movement", t = 2.15},
		},
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 105/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_BoltBack", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.MP5_MagOutEmpty", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch_SMG", t = 1.6},
		{s = "Firearms2.MP5_MagIn", t = 2.2},
		{s = "Firearms2.Cloth_Movement", t = 2.2},
		{s = "Firearms2.MP5_BoltForward", t = 2.9},
		{s = "Firearms2.Cloth_Movement", t = 2.9},
		},
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 67/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_MagOut", t = 0.45},
		{s = "Firearms2.Cloth_Movement", t = 0.45},
		{s = "Firearms2.Magpouch_SMG", t = 1},
		{s = "Firearms2.MP5_MagIn", t = 1.55},
		{s = "Firearms2.Cloth_Movement", t = 1.55},
		},
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 79/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch_SMG", t = 0.5},
		{s = "Firearms2.MP5_MagOutEmpty", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.MP5_MagIn", t = 1.1},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.MP5_BoltPull", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		},
    },

    ["reload_grip"] = {
        Source = "reload_grip",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_MagOut", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.Magpouch_SMG", t = 1.2},
		{s = "Firearms2.MP5_MagIn", t = 2.15},
		{s = "Firearms2.Cloth_Movement", t = 2.15},
		},
    },
    ["reload_empty_grip"] = {
        Source = "reload_empty_grip",
        Time = 105/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_BoltBack", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.MP5_MagOutEmpty", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch_SMG", t = 1.6},
		{s = "Firearms2.MP5_MagIn", t = 2.2},
		{s = "Firearms2.Cloth_Movement", t = 2.2},
		{s = "Firearms2.MP5_BoltForward", t = 2.9},
		{s = "Firearms2.Cloth_Movement", t = 2.9},
		},
    },
    ["reload_nomen_grip"] = {
        Source = "reload_nomen_grip",
        Time = 67/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.MP5_MagOut", t = 0.45},
		{s = "Firearms2.Cloth_Movement", t = 0.45},
		{s = "Firearms2.Magpouch_SMG", t = 1},
		{s = "Firearms2.MP5_MagIn", t = 1.55},
		{s = "Firearms2.Cloth_Movement", t = 1.55},
		},
    },
    ["reload_empty_nomen_grip"] = {
        Source = "reload_empty_nomen_grip",
        Time = 79/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch_SMG", t = 0.5},
		{s = "Firearms2.MP5_MagOutEmpty", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.MP5_MagIn", t = 1.1},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.MP5_BoltPull", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		},
    },
}