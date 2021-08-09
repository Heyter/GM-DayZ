SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 1

SWEP.PrintName = "Raging Bull"
SWEP.Trivia_Class = "Revolver"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = " Taurus International firearm company"
SWEP.Trivia_Calibre = ".454 Casull"
SWEP.Trivia_Country = "Brazil"
SWEP.Trivia_Year = "1997"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/pistols/ragingbull.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/pistols/ragingbull.mdl"
SWEP.ViewModelFOV = 57

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 80
SWEP.DamageMin = 80 -- damage done at maximum range
SWEP.Range = 550 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 750 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.

SWEP.Recoil = 6
SWEP.RecoilSide = 0.09
SWEP.RecoilRise = 0.05
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.25 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "Cylinder",
    },
    {
        Mode = 0,
    },
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 285 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = ".454 Casull" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_RAGINGBULL"
SWEP.ShootDrySound = nil -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/ragingbull.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_pistol_rbull"

SWEP.ShellModel = "models/shells/454casull.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Pistol
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.219, 1, 0.7),
    Ang = Angle(0.37, 0.0, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.3

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1, 0, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(0.2, -2.5, -1.8)
SWEP.HolsterAng = Angle(38.433, 0, 0)

SWEP.SprintPos = Vector(0.2, -2.5, -1.8)
SWEP.SprintAng = Angle(38.433, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 10, -3)

SWEP.CustomizePos = Vector(1, -3, -0.5)
SWEP.CustomizeAng = Angle(18.149, 30.547, 0)

SWEP.BarrelLength = 16

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_sight", "fas2_leupold_scope"},
        Bone = "RagingBullBase",
        Offset = {
            vpos = Vector(2.025, -1.23, 0.0),
            vang = Angle(0, 0, 270),
            wpos = Vector(7.54, 1.68, -5.8),
            wang = Angle(-10.393, 0, 180)
        },
        ExtraSightDist = 14,
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(1.8, 1.8, 1.8),
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Skill",
        Slot = "fas2_nomen",
    },
}

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    local nomen = (wep:GetBuff_Override("Override_FAS2NomenBackup") and "_nomen") or ""

    local reloadtime = (wep.Primary.ClipSize - wep:Clip1())

    return "reload" .. reloadtime .. nomen
end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "Draw",
        Time = 10/30,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["draw_empty"] = {
        Source = "Draw_Empty",
        Time = 10/30,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            },
    },
    ["holster"] = {
        Source = "Holster",
        Time = 10/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "Holster_Empty",
        Time = 10/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = {"Fire01", "Fire02", "Fire03"},
        Time = 30/30,
    },
    ["fire_iron"] = {
        Source = "Fire_Scoped01",
        Time = 30/30,
    },
    ["fire_dry"] = {
        Source = "DryFire",
		SoundTable = {{s = "fas2/empty_revolver.wav", t = 0}},
        Time = 30/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
    },
    ["fire_dry_iron"] = {
        Source = "DryFire_scoped",
        SoundTable = {{s = "fas2/empty_revolver.wav", t = 0}},
        Time = 30/30,
    },
    ["reload1"] = {
        Source = "Reload1",
        Time = 90/30,
        ShellEjectAt = 1.05,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.4},
            {s = "Firearms2.RBULL_Remove", t = 1},
            {s = "Firearms2.RBULL_Jiggle", t = 1.65},
            {s = "Firearms2.RBULL_Insert", t = 1.85},
            {s = "Firearms2.RBULL_CylinderClose", t = 2.3},
            },
    },

    ["reload2"] = {
        Source = "Reload2",
        Time = 105/30,
        ShellEjectAt = 0.7,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.4},
            {s = "Firearms2.RBULL_Remove", t = 0.7},
            {s = "Firearms2.RBULL_Remove", t = 0.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.5},
            {s = "Firearms2.RBULL_Insert", t = 1.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.9},
            {s = "Firearms2.RBULL_Insert", t = 2.2},
            {s = "Firearms2.RBULL_CylinderClose", t = 2.9},
            },
    },

    ["reload3"] = {
        Source = "Reload3",
        Time = 120/30,
        ShellEjectAt = 0.8,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.4},
            {s = "Firearms2.RBULL_Remove", t = 0.7},
            {s = "Firearms2.RBULL_Remove", t = 0.75},
            {s = "Firearms2.RBULL_Remove", t = 0.8},
            {s = "Firearms2.RBULL_Jiggle", t = 1.5},
            {s = "Firearms2.RBULL_Insert", t = 1.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.9},
            {s = "Firearms2.RBULL_Insert", t = 2.2},
            {s = "Firearms2.RBULL_Jiggle", t = 2.4},
            {s = "Firearms2.RBULL_Insert", t = 2.7},
            {s = "Firearms2.RBULL_CylinderClose", t = 3.4},
         },
    },

    ["reload4"] = {
        Source = "Reload4",
        Time = 135/30,
        ShellEjectAt = 0.9,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.4},
            {s = "Firearms2.RBULL_Remove", t = 0.7},
            {s = "Firearms2.RBULL_Remove", t = 0.75},
            {s = "Firearms2.RBULL_Remove", t = 0.8},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Jiggle", t = 1.5},
            {s = "Firearms2.RBULL_Insert", t = 1.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.9},
            {s = "Firearms2.RBULL_Insert", t = 2.2},
            {s = "Firearms2.RBULL_Jiggle", t = 2.4},
            {s = "Firearms2.RBULL_Insert", t = 2.7},
            {s = "Firearms2.RBULL_Jiggle", t = 2.9},
            {s = "Firearms2.RBULL_Insert", t = 3.2},
            {s = "Firearms2.RBULL_CylinderClose", t = 3.8},
         },
    },

    ["reload5"] = {
        Source = "Reload5",
        Time = 150/30,
        ShellEjectAt = 0.9,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.4},
            {s = "Firearms2.RBULL_Extractor", t = 0.85},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Remove", t = 0.85},
            {s = "Firearms2.RBULL_Extractor", t = 1.2},
            {s = "Firearms2.RBULL_Jiggle", t = 1.5},
            {s = "Firearms2.RBULL_Insert", t = 1.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.9},
            {s = "Firearms2.RBULL_Insert", t = 2.2},
            {s = "Firearms2.RBULL_Jiggle", t = 2.4},
            {s = "Firearms2.RBULL_Insert", t = 2.7},
            {s = "Firearms2.RBULL_Jiggle", t = 2.9},
            {s = "Firearms2.RBULL_Insert", t = 3.2},
            {s = "Firearms2.RBULL_Jiggle", t = 3.4},
            {s = "Firearms2.RBULL_Insert", t = 3.6},
            {s = "Firearms2.RBULL_CylinderClose", t = 4.4},
         },
    },
    ["reload1_nomen"] = {
        Source = "Reload1_nomen",
        Time = 90/40,
        ShellEjectAt = 0.775,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.175},
            {s = "Firearms2.RBULL_Remove", t = 0.625},
            {s = "Firearms2.RBULL_Jiggle", t = 1.15},
            {s = "Firearms2.RBULL_Insert", t = 1.35},
            {s = "Firearms2.RBULL_CylinderClose", t = 1.65},
            },
    },

    ["reload2_nomen"] = {
        Source = "Reload2",
        Time = 105/40,
        ShellEjectAt = 0.65,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.2},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.625},
            {s = "Firearms2.RBULL_Jiggle", t = 1.25},
            {s = "Firearms2.RBULL_Insert", t = 1.45},
            {s = "Firearms2.RBULL_Jiggle", t = 1.55},
            {s = "Firearms2.RBULL_Insert", t = 1.65},
            {s = "Firearms2.RBULL_CylinderClose", t = 2.1},
            },
    },

    ["reload3_nomen"] = {
        Source = "Reload3_nomen",
        Time = 120/40,
        ShellEjectAt = 0.65,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.2},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.625},
            {s = "Firearms2.RBULL_Remove", t = 0.65},
            {s = "Firearms2.RBULL_Jiggle", t = 1.35},
            {s = "Firearms2.RBULL_Insert", t = 1.55},
            {s = "Firearms2.RBULL_Jiggle", t = 1.65},
            {s = "Firearms2.RBULL_Insert", t = 1.75},
            {s = "Firearms2.RBULL_Jiggle", t = 1.85},
            {s = "Firearms2.RBULL_Insert", t = 1.95},
            {s = "Firearms2.RBULL_CylinderClose", t = 2.5},
         },
    },

    ["reload4_nomen"] = {
        Source = "Reload4_nomen",
        Time = 135/40,
        ShellEjectAt = 0.65,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.2},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.625},
            {s = "Firearms2.RBULL_Remove", t = 0.65},
            {s = "Firearms2.RBULL_Remove", t = 0.675},
            {s = "Firearms2.RBULL_Jiggle", t = 1.35},
            {s = "Firearms2.RBULL_Insert", t = 1.55},
            {s = "Firearms2.RBULL_Jiggle", t = 1.7},
            {s = "Firearms2.RBULL_Insert", t = 1.8},
            {s = "Firearms2.RBULL_Jiggle", t = 2},
            {s = "Firearms2.RBULL_Insert", t = 2.1},
            {s = "Firearms2.RBULL_Jiggle", t = 2.3},
            {s = "Firearms2.RBULL_Insert", t = 2.4},
            {s = "Firearms2.RBULL_CylinderClose", t = 2.85},
         },
    },

    ["reload5_nomen"] = {
        Source = "Reload5_nomen",
        Time = 150/37.33,
        ShellEjectAt = 0.6,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.RBULL_CylinderOpen", t = 0.2},
            {s = "Firearms2.RBULL_Extractor", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Remove", t = 0.6},
            {s = "Firearms2.RBULL_Jiggle", t = 1.2},
            {s = "Firearms2.RBULL_Insert", t = 1.4},
            {s = "Firearms2.RBULL_Jiggle", t = 1.5},
            {s = "Firearms2.RBULL_Insert", t = 1.6},
            {s = "Firearms2.RBULL_Jiggle", t = 1.8},
            {s = "Firearms2.RBULL_Insert", t = 2},
            {s = "Firearms2.RBULL_Jiggle", t = 2.2},
            {s = "Firearms2.RBULL_Insert", t = 2.3},
            {s = "Firearms2.RBULL_Jiggle", t = 2.5},
            {s = "Firearms2.RBULL_Insert", t = 2.6},
            {s = "Firearms2.RBULL_CylinderClose", t = 3.4},
         },
    },

}

function SWEP:DoShellEject()
    local owner = self:GetOwner()

    if !IsValid(owner) then return end

    local vm = self

    if !owner:IsNPC() then owner:GetViewModel() end

    for i = 1, (self:GetMaxClip1() - self:Clip1()) do
        local att = vm:GetAttachment(self:GetBuff_Override("Override_CaseEffectAttachment") or i + 1)

        if !att then return end

        local pos, ang = att.Pos, att.Ang

        local ed = EffectData()
        ed:SetOrigin(pos)
        ed:SetAngles(ang)
        ed:SetAttachment(self:GetBuff_Override("Override_CaseEffectAttachment") or self.CaseEffectAttachment or 2)
        ed:SetScale(1.5)
        ed:SetEntity(self)
        ed:SetNormal(ang:Forward())
        ed:SetMagnitude(60)

        local efov = {}
        efov.eff = "arccw_shelleffect"
        efov.fx  = ed

        if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

        util.Effect("arccw_shelleffect", ed)
    end
end