SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 3

SWEP.PrintName = "SKS"
SWEP.Trivia_Class = "Semi-automatic carbine"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Izhevsk Arsenal"
SWEP.Trivia_Calibre = "7.62x39mm"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1945"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/rifles/sks.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/sks.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 36
SWEP.DamageMin = 36 -- damage done at maximum range
SWEP.Range = 400 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 735 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.Recoil = 3.05
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.04
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.15 -- 60 / RPM.
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
SWEP.HipDispersion = 410 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x39mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_SKS"
SWEP.ShootDrySound = "fas2/empty_battlerifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/sks.ogg"
SWEP.ShootSoundSilenced = "Firearms2_SKS_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_1"

SWEP.ShellModel = "models/shells/7_62x39mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.11, -2.652, 1.5),
    Ang = Angle(0, 0.02, 0),
    Magnification = 1.2,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"},
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.35

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(6, -3, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(6, -3, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 30 

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["suppressor"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
        WMBodygroups = {{ind = 2, bg = 2}},
    },
    ["bayonet"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["20rnd"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["30rnd"] = {
        VMBodygroups = {{ind = 4, bg = 2}},
        WMBodygroups = {{ind = 3, bg = 2}},
    },
    ["muzzlebrake"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(20, -0.69, 0),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/muzzlebrake_rifles.mdl",
                Offset = {
                    pos = Vector(38.5, 0.68, -10.22),
                    ang = Angle(-10.393, 0, 180),
                },
                Scale = Vector(1.9, 1.9, 1.9),
            }
        },
    },
    ["flashhider"] = {
        VMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Bone = "Dummy01",
                Offset = {
                    pos = Vector(20, -0.69, 0),
                    ang = Angle(0, 0, 270),
                },
                Scale = Vector(1.1, 1.1, 1.1),
            }
        },
        WMElements = {
            {
                Model = "models/weapons/fas2/attachments/flashhider_rifles.mdl",
                Offset = {
                    pos = Vector(38.5, 0.68, -10.22),
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
        -- Slot = {"fas2_sight", "fas2_scope", "fas2_scope_pso1"},
        Bone = "Dummy01",
        Offset = {
            vpos = Vector(0.65, -1.58, -0.006),
            vang = Angle(0, 0, 270),
            wpos = Vector(5.35, 0.66, -5.9),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0.003, 0, 0.00),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"fas2_muzzle", "fas2_muzzlebrake", "fas2_flashhider", "fas2_bayonet"},
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = {"fas2_sks_mags"}
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

-- SWEP.Hook_SelectReloadAnimation = function(wep, anim)

    -- local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nmc") or ""

    -- if wep.Attachments[3].Installed == "fas2_mag_sks_20rnd" then return anim .. "_20" .. nomen end

    -- if wep.Attachments[3].Installed == "fas2_mag_sks_30rnd" then return anim .. "_30" .. nomen end

    -- if wep:Clip1() <= 2 and wep:Clip1() > 0 then return anim .. wep:Clip1() .. nomen end

	-- if anim == "reload" then
		-- wep:ReloadAmmoEject(0.6, wep:Clip1())
		-- wep:BoltBackEject(2.37)
		-- wep:ReloadClipEject(5.1)
		-- wep:SetClip1(0)
	-- elseif anim == "reload_empty" then
		-- wep:ReloadClipEject(2.85)
	-- elseif anim == "reload_nmc" then
		-- wep:ReloadAmmoEject(0.5, wep:Clip1())
		-- wep:BoltBackEject(2.15)
		-- wep:ReloadClipEject(3.65)
		-- wep:SetClip1(0)
	-- elseif anim == "reload_empty_nmc" then
		-- wep:ReloadClipEject(2)
	-- elseif anim == "reload_20" then
		-- wep:ReloadClipEject(3)
	-- elseif anim == "reload_empty_20" then
		-- wep:ReloadClipEject(2.8)
		-- wep:ReloadClipEject(5.8)
	-- elseif anim == "reload_20_add_nmc" then
		-- wep:ReloadClipEject(2.5)
	-- elseif anim == "reload_20_empty_nmc" then
		-- wep:ReloadClipEject(2.1)
		-- wep:ReloadClipEject(4.3)
	-- end
-- end

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    local nmc = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nmc") or ""

    if wep.Attachments[3].Installed == "fas2_mag_sks_20rnd" then
		anim = anim .. "_20" .. nmc

		if anim == "reload_20" then
			wep:ReloadClipEject(3)
		elseif anim == "reload_empty_20" then
			wep:ReloadClipEject(2.8)
			wep:ReloadClipEject(5.8)
		elseif anim == "reload_20_nmc" then
			wep:ReloadClipEject(2.5)
		elseif anim == "reload_empty_20_nmc" then
			wep:ReloadClipEject(2.1)
			wep:ReloadClipEject(4.3)
		end
		

    elseif wep.Attachments[3].Installed == "fas2_mag_sks_30rnd" then
		anim = anim .. "_30" .. nmc

		if anim == "reload_30" then
			wep:BoltBackEject(0.84)
			wep:SetClip1(wep:Clip1() - 1)
		elseif anim == "reload_30_nmc" then
			wep:BoltBackEject(0.47)
			wep:SetClip1(wep:Clip1() - 1)
		end

    elseif wep:Clip1() <= 2 and wep:Clip1() > 0 then
		anim = anim .. wep:Clip1() .. nmc

		if anim == "reload1" then
			wep:BoltBackEject(0.6)
			wep:ReloadClipEject(3.37)
			wep:SetClip1(0)
		elseif anim == "reload2" then
			wep:BoltBackEject(0.57)
			wep:BoltBackEject(1)
			wep:ReloadClipEject(3.87)
			wep:SetClip1(0)
		elseif anim == "reload1_nmc" then
			wep:BoltBackEject(0.9)
			wep:ReloadClipEject(2.4)
			wep:SetClip1(0)
		elseif anim == "reload2_nmc" then
			wep:BoltBackEject(0.54)
			wep:BoltBackEject(1.1)
			wep:ReloadClipEject(2.9)
			wep:SetClip1(0)
		end

	else
		anim = anim .. nmc
		
		if anim == "reload" then
			wep:ReloadAmmoEject(0.6, wep:Clip1())
			wep:BoltBackEject(2.37)
			wep:ReloadClipEject(5.1)
			wep:SetClip1(0)
		elseif anim == "reload_empty" then
			wep:ReloadClipEject(2.85)
		elseif anim == "reload_nmc" then
			wep:ReloadAmmoEject(0.5, wep:Clip1())
			wep:BoltBackEject(2.15)
			wep:ReloadClipEject(3.65)
			wep:SetClip1(0)
		elseif anim == "reload_empty_nmc" then
			wep:ReloadClipEject(2)
		end
	end


    return anim
end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "Draw",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "Draw_Empty",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "Holster",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "Holster_Empty",
        Time = 15/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["bash"] = {
        Source = "melee",
        Time = 30/45,
        SoundTable = {
        {s = "Firearms2.Cloth_Fast", t = 0},
        {s = "Firearms2.Cloth_Fast", t = 0.37},
        },
    },
    ["bash_empty"] = {
        Source = "melee_empty",
        Time = 30/45,
        SoundTable = {
        {s = "Firearms2.Cloth_Fast", t = 0},
        {s = "Firearms2.Cloth_Fast", t = 0.37},
        },
    },
    ["fire"] = {
        Source = {"Fire1", "Fire2", "Fire3"},
        Time = 60/90,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "Fire_Last",
        Time = 60/90,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "Fire_scoped",
        Time = 60/90,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "Fire_last_scoped",
        Time = 60/90,
        ShellEjectAt = 0,
	},
    ["reload1"] = {
        Source = "reload1",
        Time = 135/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBack", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.SKS_BoltBackLock", t = 0.6},
		{s = "Firearms2.Magpouch", t = 1},
		{s = "Firearms2.SKS_ClipIn", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.SKS_Insert1", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.SKS_Insert2", t = 2.4},
		{s = "Firearms2.SKS_InsertLast", t = 2.9},
		{s = "Firearms2.Cloth_Movement", t = 2.9},
		{s = "Firearms2.SKS_RemoveClip", t = 3.3},
		{s = "Firearms2.Cloth_Movement", t = 3.3},
		{s = "Firearms2.SKS_BoltRelease", t = 3.7},
		{s = "Firearms2.Cloth_Movement", t = 3.7},
		{s = "Firearms2.SKS_BoltForward", t = 3.9},
		},
    },
    ["reload2"] = {
        Source = "reload2",
        Time = 150/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBack", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.SKS_BoltForward", t = 0.6},
		{s = "Firearms2.SKS_BoltBack", t = 0.9},
		{s = "Firearms2.Cloth_Movement", t = 0.9},
		{s = "Firearms2.SKS_BoltBackLock", t = 1.1},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SKS_ClipIn", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		{s = "Firearms2.SKS_Insert1", t = 2.5},
		{s = "Firearms2.Cloth_Movement", t = 2.5},
		{s = "Firearms2.SKS_Insert2", t = 2.9},
		{s = "Firearms2.SKS_InsertLast", t = 3.3},
		{s = "Firearms2.Cloth_Movement", t = 3.3},
		{s = "Firearms2.SKS_RemoveClip", t = 3.8},
		{s = "Firearms2.Cloth_Movement", t = 3.8},
		{s = "Firearms2.SKS_BoltRelease", t = 4.2},
		{s = "Firearms2.Cloth_Movement", t = 4.2},
		{s = "Firearms2.SKS_BoltForward", t = 4.4},
		},
    },
    ["reload1_nmc"] = {
        Source = "Reload1_nmc",
        Time = 101/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.4},
		{s = "Firearms2.SKS_BoltBack", t = 0.6},
		{s = "Firearms2.Cloth_Movement", t = 0.6},
		{s = "Firearms2.SKS_BoltBackLock", t = 0.8},
		{s = "Firearms2.SKS_ClipIn", t = 1.1},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.SKS_InsertNomen", t = 1.6},
		{s = "Firearms2.Cloth_Movement", t = 1.6},
		{s = "Firearms2.SKS_RemoveClip", t = 2.3},
		{s = "Firearms2.Cloth_Movement", t = 2.3},
		{s = "Firearms2.SKS_BoltRelease", t = 2.6},
		{s = "Firearms2.Cloth_Movement", t = 2.6},
		{s = "Firearms2.SKS_BoltForward", t = 2.8},
		},
    },
    ["reload2_nmc"] = {
        Source = "Reload2_nmc",
        Time = 112/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBack", t = 0.3},
		{s = "Firearms2.SKS_BoltForward", t = 0.6},
		{s = "Firearms2.SKS_BoltBack", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SKS_BoltBackLock", t = 1.1},
		{s = "Firearms2.Magpouch", t = 1.4},
		{s = "Firearms2.SKS_ClipIn", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		{s = "Firearms2.SKS_InsertNomen", t = 2.2},
		{s = "Firearms2.Cloth_Movement", t = 2.2},
		{s = "Firearms2.SKS_RemoveClip", t = 2.8},
		{s = "Firearms2.Cloth_Movement", t = 2.8},
		{s = "Firearms2.SKS_BoltRelease", t = 3.1},
		{s = "Firearms2.Cloth_Movement", t = 3.1},
		{s = "Firearms2.SKS_BoltForward", t = 3.3},
		},
    },
    ["reload"] = {
        Source = "Reload3",
        Time = 195/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_LatchOpen", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.SKS_LatchClose", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.SKS_BoltBack", t = 2.2},
		{s = "Firearms2.Cloth_Movement", t = 2.2},
		{s = "Firearms2.SKS_BoltBackLock", t = 2.4},
		{s = "Firearms2.Magpouch", t = 2.7},
		{s = "Firearms2.SKS_ClipIn", t = 3.1},
		{s = "Firearms2.Cloth_Movement", t = 3.1},
		{s = "Firearms2.SKS_Insert1", t = 3.7},
		{s = "Firearms2.SKS_Insert2", t = 4.2},
		{s = "Firearms2.SKS_InsertLast", t = 4.6},
		{s = "Firearms2.Cloth_Movement", t = 4.6},
		{s = "Firearms2.SKS_RemoveClip", t = 5.1},
		{s = "Firearms2.Cloth_Movement", t = 5.1},
		{s = "Firearms2.SKS_BoltRelease", t = 5.5},
		{s = "Firearms2.Cloth_Movement", t = 5.5},
		{s = "Firearms2.SKS_BoltForward", t = 5.7},
		},
    },
    ["reload_empty"] = {
        Source = "Reload_empty",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.SKS_ClipIn", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SKS_Insert1", t = 1.45},
		{s = "Firearms2.Cloth_Movement", t = 1.45},
		{s = "Firearms2.SKS_Insert2", t = 1.9},
		{s = "Firearms2.SKS_InsertLast", t = 2.3},
		{s = "Firearms2.Cloth_Movement", t = 2.3},
		{s = "Firearms2.SKS_RemoveClip", t = 2.8},
		{s = "Firearms2.Cloth_Movement", t = 2.8},
		{s = "Firearms2.SKS_BoltRelease", t = 3.2},
		{s = "Firearms2.Cloth_Movement", t = 3.2},
		{s = "Firearms2.SKS_BoltForward", t = 3.4},
		},
    },
    ["reload_nmc"] = {
        Source = "Reload3_nmc",
        Time = 145/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_LatchOpen", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.SKS_LatchClose", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.7},
		{s = "Firearms2.SKS_BoltBack", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.SKS_BoltBackLock", t = 2.2},
		{s = "Firearms2.SKS_ClipIn", t = 2.5},
		{s = "Firearms2.Cloth_Movement", t = 2.5},
		{s = "Firearms2.SKS_InsertNomen", t = 3},
		{s = "Firearms2.Cloth_Movement", t = 3},
		{s = "Firearms2.SKS_RemoveClip", t = 3.6},
		{s = "Firearms2.Cloth_Movement", t = 3.6},
		{s = "Firearms2.SKS_BoltRelease", t = 3.9},
		{s = "Firearms2.Cloth_Movement", t = 3.9},
		{s = "Firearms2.SKS_BoltForward", t = 4.1},
		},
    },
    ["reload_empty_nmc"] = {
        Source = "reload_empty_nmc",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.2},
		{s = "Firearms2.SKS_ClipIn", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.SKS_InsertNomen", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.3},
		{s = "Firearms2.SKS_RemoveClip", t = 1.9},
		{s = "Firearms2.Cloth_Movement", t = 1.9},
		{s = "Firearms2.SKS_BoltRelease", t = 2.3},
		{s = "Firearms2.Cloth_Movement", t = 2.3},
		{s = "Firearms2.SKS_BoltForward", t = 2.5},
		},
    },
    ["reload_20"] = {
        Source = "Reload_20_add",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBackHalfA", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.1},
		{s = "Firearms2.SKS_BoltBackHalfB", t = 1.2},
		{s = "Firearms2.SKS_ClipIn", t = 1.4},
		{s = "Firearms2.SKS_Insert1", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.SKS_Insert2", t = 2.4},
		{s = "Firearms2.SKS_InsertLast", t = 2.5},
		{s = "Firearms2.Cloth_Movement", t = 2.5},
		{s = "Firearms2.SKS_RemoveClip", t = 2.9},
		{s = "Firearms2.SKS_BoltForwardHalf", t = 3.1},
		{s = "Firearms2.Cloth_Movement", t = 3.1},
		},
    },
    ["reload_empty_20"] = {
        Source = "Reload_20_empty",
        Time = 210/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.3},
		{s = "Firearms2.SKS_ClipIn", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.SKS_Insert1", t = 1.4},
		{s = "Firearms2.Cloth_Movement", t = 1.4},
		{s = "Firearms2.SKS_Insert2", t = 1.9},
		{s = "Firearms2.SKS_InsertLast", t = 2.3},
		{s = "Firearms2.Cloth_Movement", t = 2.3},
		{s = "Firearms2.SKS_RemoveClip", t = 2.8},
		{s = "Firearms2.Cloth_Movement", t = 2.8},
		{s = "Firearms2.Magpouch", t = 3.4},
		{s = "Firearms2.SKS_ClipIn", t = 3.8},
		{s = "Firearms2.Cloth_Movement", t = 3.8},
		{s = "Firearms2.SKS_Insert1", t = 4.5},
		{s = "Firearms2.Cloth_Movement", t = 4.5},
		{s = "Firearms2.SKS_Insert2", t = 4.9},
		{s = "Firearms2.SKS_InsertLast", t = 5.3},
		{s = "Firearms2.Cloth_Movement", t = 5.3},
		{s = "Firearms2.SKS_RemoveClip", t = 5.8},
		{s = "Firearms2.Cloth_Movement", t = 5.8},
		{s = "Firearms2.SKS_BoltRelease", t = 6.2},
		{s = "Firearms2.SKS_BoltForward", t = 6.4},
		{s = "Firearms2.Cloth_Movement", t = 6.4},
		},
	},
	["reload_20_nmc"] = {
        Source = "Reload_20_add_nmc",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.4},
		{s = "Firearms2.SKS_BoltBackHalfA", t = 0.8},
		{s = "Firearms2.SKS_ClipIn", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.SKS_InsertNomen", t = 1.6},
		{s = "Firearms2.SKS_BoltForwardHalf", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.SKS_RemoveClip", t = 2.4},
		},
	},
	["reload_empty_20_nmc"] = {
        Source = "Reload_20_empty_nmc",
        Time = 158/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.Magpouch", t = 0.4},
		{s = "Firearms2.SKS_ClipIn", t = 0.7},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.SKS_InsertNomen", t = 1.3},
		{s = "Firearms2.Cloth_Movement", t = 1.2},
		{s = "Firearms2.SKS_RemoveClip", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.Magpouch", t = 2.6},
		{s = "Firearms2.SKS_ClipIn", t = 3},
		{s = "Firearms2.Cloth_Movement", t = 3	},
		{s = "Firearms2.SKS_InsertNomen", t = 3.5},
		{s = "Firearms2.Cloth_Movement", t = 3.5},
		{s = "Firearms2.SKS_RemoveClip", t = 4.2},
		{s = "Firearms2.Cloth_Movement", t = 4.2},
		{s = "Firearms2.SKS_BoltRelease", t = 4.6},
		{s = "Firearms2.SKS_BoltForward", t = 4.8},
		{s = "Firearms2.Cloth_Movement", t = 4.8},
		},
	},
	["reload_30"] = {
        Source = "Reload_30",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBack", t = 0.7},
		{s = "Firearms2.SKS_BoltBackLock", t = 0.85},
		{s = "Firearms2.SKS_MagOut", t = 1.1},
		{s = "Firearms2.Cloth_Movement", t = 1.1},
		{s = "Firearms2.Magpouch", t = 1.7},
		{s = "Firearms2.SKS_MagIn", t = 2.55},
		{s = "Firearms2.Cloth_Movement", t = 2.55},
		{s = "Firearms2.SKS_BoltRelease", t = 2.7},
		{s = "Firearms2.SKS_BoltForward", t = 2.8},
		{s = "Firearms2.Cloth_Movement", t = 2.8},
		},
	},
	["reload_empty_30"] = {
        Source = "Reload_30_empty",
        Time = 120/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_MagOutEmpty", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.Magpouch", t = 1.5},
		{s = "Firearms2.SKS_MagIn", t = 2.2},
		{s = "Firearms2.Cloth_Movement", t = 2.2},
		{s = "Firearms2.SKS_BoltRelease", t = 3.3},
		{s = "Firearms2.Cloth_Movement", t = 3.3},
		{s = "Firearms2.SKS_BoltForward", t = 3.45},
		},
	},
	["reload_30_nmc"] = {
        Source = "Reload_30_nmc",
        Time = 90/30,
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_BoltBack", t = 0.3},
		{s = "Firearms2.Cloth_Movement", t = 0.3},
		{s = "Firearms2.SKS_MagOut", t = 1},
		{s = "Firearms2.Cloth_Movement", t = 1},
		{s = "Firearms2.Magpouch", t = 1.6},
		{s = "Firearms2.SKS_MagIn", t = 2},
		{s = "Firearms2.Cloth_Movement", t = 2},
		{s = "Firearms2.SKS_BoltForward", t = 2.6},
		},
	},
	["reload_empty_30_nmc"] = {
        Source = "Reload_30_empty_nmc",
        Time = 90/30,
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SKS_MagOutEmpty", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.7},
		{s = "Firearms2.Magpouch", t = 1.1},
		{s = "Firearms2.SKS_MagIn", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		{s = "Firearms2.SKS_BoltRelease", t = 2.4},
		{s = "Firearms2.Cloth_Movement", t = 2.4},
		{s = "Firearms2.SKS_BoltForward", t = 2.6},
		},
	},
}

function SWEP:ReloadAmmoEject(time, clip)
    timer.Simple(time or 1.8, function()

        if not IsValid(self) then return end

        local owner = self:GetOwner()

        if !IsValid(owner) then return end

        local vm = self

        if !owner:IsNPC() then owner:GetViewModel() end

        local att = vm:GetAttachment(3)

        if !att then return end

        local pos, ang = att.Pos, att.Ang

		for i = 1, (clip - 1 or 1) do

			local ed = EffectData()
			ed:SetOrigin(pos)
			ed:SetAngles(ang)
			ed:SetAttachment(3)
			ed:SetScale(1.5)
			ed:SetEntity(self)
			ed:SetNormal(ang:Forward())
			ed:SetMagnitude(0)

			local efov = {}
			efov.eff = "arccw_firearms2_762_round"
			efov.fx  = ed

			if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

			util.Effect("arccw_firearms2_762_round", ed)
		end
    end)
end

function SWEP:BoltBackEject(time)
    timer.Simple(time or 1.8, function()

        if not IsValid(self) then return end

        local owner = self:GetOwner()

        if !IsValid(owner) then return end

        local vm = self

        if !owner:IsNPC() then owner:GetViewModel() end

        local att = vm:GetAttachment(2)

        if !att then return end

        local pos, ang = att.Pos, att.Ang

		local ed = EffectData()
		ed:SetOrigin(pos)
		ed:SetAngles(ang)
		ed:SetAttachment(2)
		ed:SetScale(1.5)
		ed:SetEntity(self)
		ed:SetNormal(ang:Forward())
		ed:SetMagnitude(70)

		local efov = {}
		efov.eff = "arccw_firearms2_762_round"
		efov.fx  = ed

		if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

		util.Effect("arccw_firearms2_762_round", ed)
    end)
end

function SWEP:ReloadClipEject(time)
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
		ed:SetMagnitude(70)

		local efov = {}
		efov.eff = "arccw_firearms2_sks_clip"
		efov.fx  = ed

		if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

		util.Effect("arccw_firearms2_sks_clip", ed)
    end)
end

function SWEP:SKSCheck()
    if self:GetClass() ~= "arccw_firearms2_sks" then --Why? Or it should be in base?
        return true
    elseif self.Attachments[3].Installed == "fas2_mag_sks_30rnd" then
        return true
    else
        return not (self:Clip1() > 10)
    end
end

function SWEP:SKSReload()
    if self:GetClass() ~= "arccw_firearms2_sks" then
        self:RestoreAmmo()
        return
    end

-- self.Attachments[3].Installed == "fas2_mag_sks_30rnd"

    if self:Clip1() == 0 or self.Attachments[3].Installed == "fas2_mag_sks_30rnd" then
        self:RestoreAmmo()
    else
        if self:Clip1() <= 10 then
            self:RestoreAmmo(10)
        else
            self:RestoreAmmo()
        end
    end
end

function SWEP:Reload()
	if self:GetOwner():IsNPC() then
		return
	end

	if self:GetInUBGL() then
		if self:GetNextSecondaryFire() > CurTime() then return end
			self:ReloadUBGL()
		return
	end

	if self:GetNextPrimaryFire() >= CurTime() then return end
	--if self:GetNextSecondaryFire() > CurTime() then return end
		-- don't succumb to
				-- californication

	-- if !game.SinglePlayer() and !IsFirstTimePredicted() then return end

	if self.Throwing then return end
	if self.PrimaryBash then return end

	if self:HasBottomlessClip() then return end
	
	if not self:SKSCheck() then return end -- SKS RELOAD CHECK 

    -- Don't accidently reload when changing firemode
    if self:GetOwner():GetInfoNum("arccw_altfcgkey", 0) == 1 and self:GetOwner():KeyDown(IN_USE) then return end

    if self:Ammo1() <= 0 then return end

    self:GetBuff_Hook("Hook_PreReload")

    self.LastClip1 = self:Clip1()

    local reserve = self:Ammo1()

    reserve = reserve + self:Clip1()

    local clip = self:GetCapacity()

    local chamber = math.Clamp(self:Clip1(), 0, self:GetChamberSize())

    local load = math.Clamp(clip + chamber, 0, reserve)

    if load <= self:Clip1() then return end
    self.LastLoadClip1 = load - self:Clip1()

    -- self:SetReqEnd(false)
    self:SetBurstCount(0)

    local shouldshotgunreload = self.ShotgunReload

    if self:GetBuff_Override("Override_ShotgunReload") then
        shouldshotgunreload = true
    end

    if self:GetBuff_Override("Override_ShotgunReload") == false then
        shouldshotgunreload = false
    end

    if self.HybridReload or self:GetBuff_Override("Override_HybridReload") then
        if self:Clip1() == 0 then
            shouldshotgunreload = false
        else
            shouldshotgunreload = true
        end
    end

    local mult = self:GetBuff_Mult("Mult_ReloadTime")

    if shouldshotgunreload then
        local anim = "sgreload_start"
        local insertcount = 0

        local empty = (self:Clip1() == 0) or self:GetNeedCycle()

        if self.Animations.sgreload_start_empty and empty then
            anim = "sgreload_start_empty"
            empty = false

            insertcount = (self.Animations.sgreload_start_empty or {}).RestoreAmmo or 1
        else
            insertcount = (self.Animations.sgreload_start or {}).RestoreAmmo or 0
        end

        anim = self:GetBuff_Hook("Hook_SelectReloadAnimation", anim) or anim

        self:GetOwner():SetAmmo(self:Ammo1() - insertcount, self.Primary.Ammo)
        self:SetClip1(self:Clip1() + insertcount)

        self:PlayAnimation(anim, mult, true, 0, true, nil, true)

        self:SetTimer(self:GetAnimKeyTime(anim) * mult,
        function()
            self:ReloadInsert(empty)
        end)
    else
        local anim = self:SelectReloadAnimation()

        -- Yes, this will cause an issue in mag-fed manual action weapons where
        -- despite an empty casing being in the chamber, you can load +1 and 
        -- cycle an empty shell afterwards.
        -- No, I am !in the correct mental state to fix this. - 8Z
        if self:Clip1() == 0 then
            self:SetNeedCycle(false)
        end

        if !self.Animations[anim] then print("Invalid animation \"" .. anim .. "\"") return end

        self:PlayAnimation(anim, mult, true, 0, true, nil, true)
        
        if self.Animations[anim].MinProgress then
            reloadtime = self.Animations[anim].MinProgress * mult
        else
            reloadtime = self:GetAnimKeyTime(anim) * mult
        end

        self:SetNextPrimaryFire(CurTime() + self:GetAnimKeyTime(anim) * mult)
            
        self:SetTimer(reloadtime * 0.95,
        function()
            self:SetReloading(false)
            -- if self:GetOwner():KeyDown(IN_ATTACK2) then
            --     self:EnterSights()
			-- end
			
			self:SKSReload()

            -- self:RestoreAmmo()
        end)
        self.CheckpointAnimation = anim
        self.CheckpointTime = 0

        if self.RevolverReload then
            self.LastClip1 = load
        end
    end

    self:SetReloading(true)

    for i, k in pairs(self.Attachments) do
        if !k.Installed then continue end
        local atttbl = ArcCW.AttachmentTable[k.Installed]

        if atttbl.DamageOnReload then
            self:DamageAttachment(i, atttbl.DamageOnReload)
        end
    end

    if !self.ReloadInSights then
        self:ExitSights()
        self.Sighted = false
    end

    self:GetBuff_Hook("Hook_PostReload")
end