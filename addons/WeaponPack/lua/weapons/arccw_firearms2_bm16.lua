SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.ItemData = {
    width = 3,
    height = 1,
    JamCapacity = 200,
    DegradeRate = 0.02,
    price = 200,
    rarity = { weight = 1 },
    iconCam = {
        pos = Vector(0, 200, 0),
        ang = Angle(-1.2, 269.6, 0),
        fov = 17
    }
}

SWEP.PrintName = "BM-16"
SWEP.Trivia_Class = "Double-Barrel"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "N/A"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1956"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/shotguns/bm16.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/bm16.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 10
SWEP.DamageMin = 1 -- damage done at maximum range
SWEP.Range = 40 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 650 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 2 -- DefaultClip is automatically set.

SWEP.Recoil = 4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.15 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "Double-Barrel",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 60 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 295 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "12 Gauge" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_BM16"
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

SWEP.SpeedMult = 0.75
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1.921, -2.721, 1.8),
    Ang = Angle(0.2, 0.01, 0),
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

SWEP.CrouchPos = Vector(-0.5, -2, -0.5)
SWEP.CrouchAng = Angle(0, 0, -25)

SWEP.HolsterPos = Vector(5.5, -4, 0.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(5.5, -4, 0.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(5.824, 0, -1.897)
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
		wep:ReloadShellEject(0.4)
	elseif anim == "reload_empty" then
        wep:ReloadShellEject(0.4)
        wep:ReloadShellEject(0.4)
    end
end 

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if anim == "draw" then
        if wep:Clip1() == 1 then
            return "draw_one"
        end
    end
    if anim == "holster" then
        if wep:Clip1() == 1 then
            return "holster_one"
        end
    end
end

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["draw_one"] = {
        Source = "draw_one",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_one"] = {
        Source = "holster_one",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 25/30,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "fire",
        Time = 22/30,
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 22/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 165/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.TOZ34_OpenStart", t = 0.3},
		{s = "Firearms2.TOZ34_OpenFinish", t = 0.4},
		{s = "Firearms2.M3S90_LoadEjectorPort", t = 1.7},
		{s = "Firearms2.TOZ34_ShellIn", t = 2.2},
		{s = "Firearms2.TOZ34_Close", t = 3.3},
		{s = "Firearms2.TOZ34_HammerPull", t = 4.25}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 165/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.TOZ34_OpenStart", t = 0.3},
        {s = "Firearms2.TOZ34_OpenFinish", t = 0.4},
        {s = "Firearms2.M3S90_LoadEjectorPort", t = 1.7},
        {s = "Firearms2.TOZ34_ShellIn", t = 2.2},
        {s = "Firearms2.TOZ34_Close", t = 3.3},
        {s = "Firearms2.TOZ34_HammerPull", t = 4.25},
        {s = "Firearms2.TOZ34_HammerPull", t = 4.24}
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