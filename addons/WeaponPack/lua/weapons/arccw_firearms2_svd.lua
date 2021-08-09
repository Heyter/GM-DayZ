SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "SVD"
SWEP.Trivia_Class = "Designated marksman rifle"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Kalashnikov Concern"
SWEP.Trivia_Calibre = "7.62x54mm"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1963"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/snipers/svd.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/snipers/svd.mdl"
SWEP.ViewModelFOV = 52

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 65
SWEP.DamageMin = 65 -- damage done at maximum range
SWEP.Range = 800 -- in METRES
SWEP.Penetration = 20
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 830 -- projectile or phys bullet muzzle velocity

SWEP.TracerNum = 0 -- tracer every X

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.Recoil = 4.15552
SWEP.RecoilSide = 0.06
SWEP.RecoilRise = 0.07
SWEP.RecoilPunch = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.19 -- 60 / RPM.
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
SWEP.HipDispersion = 310 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "7.62x54mm" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = nil

SWEP.ShootSound = "Firearms2_SVD"
SWEP.ShootDrySound = "fas2/empty_sniperrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/svd.ogg"
SWEP.ShootSoundSilenced = "Firearms2_SVD_S"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_svd"

SWEP.ShellModel = "models/shells/7_62x54mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Rifle
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-2.388, -4.2, 1.47),
    Ang = Angle(0.05, 0.035, 0),
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

SWEP.HolsterPos = Vector(4, -3, 1.5)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.SprintPos = Vector(4, -3, 1.5)
SWEP.SprintAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, 0, -1.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 28

SWEP.AttachmentElements = {
    ["suppressor"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Mount",
        DefaultAttName = "Ironsight",
        Slot = {"fas2_scope_pso1"},
        Bone = "SVD Receiver", 
        Offset = {
            vpos = Vector(-5.3, -1.57, -0.05),
            vang = Angle(0, 0, 270),
            wpos = Vector(7.1, 0.94, -5.08),
            wang = Angle(-10.393, 0, 180)
        },
        WMScale = Vector(1.6, 1.6, 1.6),
        CorrectivePos = Vector(0, 0, 0.001),
        CorrectiveAng = Angle(0, 0.11, 0)
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
    -- ["ready"] = {
    --     Source = "deploy_first",
    --     Time = 94/30,
	-- 	SoundTable = {
    --     {s = "Firearms2.Cloth_Movement", t = 0},
    --     {s = "Firearms2.Firemode_Switch", t = 1.25},
    --     {s = "Firearms2.Cloth_Movement", t = 1.25},
    --     {s = "Firearms2.SVD_BoltBack", t = 1.9},
    --     {s = "Firearms2.Cloth_Movement", t = 1.9},
    --     {s = "Firearms2.SVD_BoltForward", t = 2.2}
    --     },
    -- },
    ["draw"] = {
        Source = "deploy",
        Time = 35/53,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 22/66,
		SoundTable = {{s = "Firearms2.Holster", t = 0}},
    },
    ["fire"] = {
        Source = "",
    },
    ["fire1"] = {
        Source = "fire",
        Time = 25/60,
        ShellEjectAt = 0,
    },
    ["fire2"] = {
        Source = "fire2",
        Time = 25/62,
        ShellEjectAt = 0,
    },
    ["fire3"] = {
        Source = "fire3",
        Time = 25/58,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_scoped",
        Time = 6/60,
        ShellEjectAt = 0,
    },
   ["reload"] = {
        Source = "reload",
        Time = 100/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SVD_MagOut", t = 0.65},
		{s = "Firearms2.Cloth_Movement", t = 0.65},
		{s = "Firearms2.Magpouch", t = 1.3},
		{s = "Firearms2.SVD_MagInPartial", t = 1.7},
		{s = "Firearms2.Cloth_Movement", t = 1.7},
		{s = "Firearms2.SVD_MagIn", t = 2}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 159/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
        {s = "Firearms2.Cloth_Movement", t = 0},
        {s = "Firearms2.SVD_MagOut", t = 0.65},
        {s = "Firearms2.Cloth_Movement", t = 0.65},
        {s = "Firearms2.Magpouch", t = 1.3},
        {s = "Firearms2.SVD_MagInPartial", t = 1.7},
        {s = "Firearms2.Cloth_Movement", t = 1.7},
        {s = "Firearms2.SVD_MagIn", t = 2},
        {s = "Firearms2.Cloth_Movement", t = 2.6},
        {s = "Firearms2.Cloth_Movement", t = 3},
        {s = "Firearms2.SVD_BoltBack", t = 3.75},
        {s = "Firearms2.Cloth_Movement", t = 3.75},
        {s = "Firearms2.SVD_BoltForward", t = 4},
        {s = "Firearms2.Cloth_Movement", t = 4.4}
        },
    },
    ["reload_nomen"] = {
        Source = "reload_nomen",
        Time = 100/37.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.SVD_MagOut", t = 0.5},
		{s = "Firearms2.Cloth_Movement", t = 0.5},
		{s = "Firearms2.Magpouch", t = 1.1},
		{s = "Firearms2.SVD_MagInPartial", t = 1.4},
		{s = "Firearms2.Cloth_Movement", t = 1.4},
		{s = "Firearms2.SVD_MagIn", t = 1.55}
        },
    },
    ["reload_nomen_empty"] = {
        Source = "reload_empty_nomen",
        Time = 139/30.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.SVD_MagoutEmpty", t = 0.5},
            {s = "Firearms2.Cloth_Movement", t = 0.5},
            {s = "Firearms2.Cloth_Fast", t = 0.65},
            {s = "Firearms2.Cloth_Movement", t = 0.92},
            {s = "Firearms2.Magpouch", t = 1.2},
            {s = "Firearms2.SVD_MagInNomen", t = 1.8},
            {s = "Firearms2.Cloth_Movement", t = 1.8},
            {s = "Firearms2.Cloth_Movement", t = 2.5},
            {s = "Firearms2.SVD_BoltBack", t = 3.15},
            {s = "Firearms2.Cloth_Movement", t = 3.15},
            {s = "Firearms2.SVD_BoltForward", t = 3.4},
            {s = "Firearms2.Cloth_Movement", t = 3.8}
            },
    },
}