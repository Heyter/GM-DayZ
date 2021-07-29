SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "TOZ-34"
SWEP.Trivia_Class = "Double-Barrel"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Tulsky Oruzheiny Zavod"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1964"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/shotguns/toz34.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/toz34.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 10
SWEP.DamageMin = 10 -- damage done at maximum range
SWEP.Range = 40 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 650 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 2 -- DefaultClip is automatically set.

SWEP.Recoil = 7
SWEP.RecoilSide = 0.21
SWEP.RecoilRise = 0.06
SWEP.RecoilPunch = 1
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.15 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "Break-Action",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 65 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 320 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "12 Gauge" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_TOZ34"
SWEP.ShootDrySound = "fas2/empty_shotguns.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/saiga12k.ogg"
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
    Pos = Vector(-1.995, -3.586, 1.682),
    Ang = Angle(1, 0, 0),
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

SWEP.CrouchPos = Vector(-0.5, -2, 0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(3, -3, 1.8)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(3, -3, 1.8)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.4)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 30

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

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
	if anim == "reload" then
		wep:ReloadShellEject(1.8)
	elseif anim == "reload_empty" then
        wep:ReloadShellEject(1)
        wep:ReloadShellEject(1)
    end
end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 45/30,
		SoundTable = {
        {s = "Firearms2.Deploy", t = 0},
        {s = "Firearms2.M79_Close", t = 0.4},
        },
    },
    ["holster"] = {
        Source = "holster",
        Time = 29/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire01",
        Time = 25/30,
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        Time = 14/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 180/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.TOZ34_OpenStart", t = 0.65},
		{s = "Firearms2.Magpouch", t = 1.15},
		{s = "Firearms2.M3S90_GetAmmo", t = 1.5},
		{s = "Firearms2.M3S90_LoadEjectorPort", t = 3.6},
		{s = "Firearms2.TOZ34_Close", t = 4.7}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 150/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.TOZ34_OpenStart", t = 0.7},
        {s = "Firearms2.TOZ34_OpenFinish", t = 0.8},
        {s = "Firearms2.M3S90_LoadEjectorPort", t = 2.65},
        {s = "Firearms2.TOZ34_ShellIn", t = 2.7},
        {s = "Firearms2.SR25_Magslap", t = 2.9},
        {s = "Firearms2.TOZ34_Close", t = 3.65}
        },
    },
}

function SWEP:ReloadShellEject(time)
    timer.Simple(time, function()

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
		ed:SetMagnitude(0)

		local efov = {}
		efov.eff = "arccw_shelleffect"
		efov.fx  = ed

		if self:GetBuff_Hook("Hook_PreDoEffects", efov) == true then return end

		util.Effect("arccw_shelleffect", ed)
    end)
end