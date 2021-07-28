SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Firearms: Source 2" -- edit this if you like
SWEP.AdminOnly = false
SWEP.Slot = 4

SWEP.PrintName = "M79"
SWEP.Trivia_Class = "Grenade launcher"
SWEP.Trivia_Desc = ""
SWEP.Trivia_Manufacturer = "Springfield Armory"
SWEP.Trivia_Calibre = "40×46MM Grenade"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1961"

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/fas2/view/explosives/m79.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/explosives/m79.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"
SWEP.DefaultSkin = 0

SWEP.Damage = 34
SWEP.DamageMin = 19 -- damage done at maximum range
SWEP.Range = 375 -- in METRES
SWEP.Penetration = 5
SWEP.ShootEntity = "arccw_firearms2_40mm" -- entity to fire, if any
SWEP.MuzzleVelocity = 1500

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.

SWEP.Recoil = 3
SWEP.RecoilSide = 0.6
SWEP.RecoilRise = 0.4
SWEP.RecoilPunch = 3
SWEP.VisualRecoilMult = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 0.1 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "Break-Action",
    },
    {
        Mode = 0,
    },
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Primary.Ammo = "40MM HE" -- what ammo type the gun uses
SWEP.MagID = "" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "Firearms2_M79"
SWEP.ShootDrySound = "fas2/empty_assaultrifles.wav" -- Add an attachment hook for Hook_GetShootDrySound please!
SWEP.DistantShootSound = "fas2/distant/m79.ogg"
SWEP.FiremodeSound = "Firearms2.Firemode_Switch"

SWEP.MuzzleEffect = "muzzleflash_m79"

SWEP.ShellModel = "models/weapons/fas2/world/explosives/m79_grenade_shell.mdl"
SWEP.ShellScale = 1
SWEP.ShellSounds = ArcCW.Firearms2_Casings_Heavy
SWEP.ShellPitch = 100
SWEP.ShellTime = 1 -- add shell life time

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-3.412, -6.4, -1.338),
    Ang = Angle(7.353, 0, 0),
    Magnification = 1.1,
    SwitchToSound = {"fas2/weapon_sightraise.wav", "fas2/weapon_sightraise2.wav"}, -- sound that plays when switching to this sight
    SwitchFromSound = {"fas2/weapon_sightlower.wav", "fas2/weapon_sightlower2.wav"},
}

SWEP.SightTime = 0.4

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.CanBash = false

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(0, -4, -1.3)
SWEP.CrouchAng = Angle(5, 0, 0)

SWEP.HolsterPos = Vector(4.232, -6, 1)
SWEP.HolsterAng = Angle(-9.633, 36.881, 0)

SWEP.SprintPos = Vector(4.232, -6, 1)
SWEP.SprintAng = Angle(-9.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(4.824, -4, -2.297)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelLength = 22

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "deploy",
        Time = 46/33,
		SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.Firemode_Switch", t = 0.6},
            {s = "Firearms2.Cloth_Movement", t = 1.22},
            },
    },
    ["holster"] = {
        Source = "holster",
        Time = 39/33,
            SoundTable = {
            {s = "Firearms2.Cloth_Movement", t = 0},
            {s = "Firearms2.Firemode_Switch", t = 0.6},
            {s = "Firearms2.Holster", t = 0.9},
            },
    },
    ["fire"] = {
        Source = "shoot",
        Time = 32/30,
    },
    ["fire_iron"] = {
        Source = {"shoot_iron", "shoot_iron2"},
        Time = 15/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 135/30,
        ShellEjectAt = 1.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
		{s = "Firearms2.Cloth_Movement", t = 0},
		{s = "Firearms2.M79_Open", t = 0.8},
		{s = "Firearms2.Cloth_Movement", t = 0.8},
		{s = "Firearms2.M79_ShellOut", t = 1.5},
		{s = "Firearms2.Cloth_Movement", t = 1.5},
		{s = "Firearms2.M79_ShellIn", t = 2.7},
		{s = "Firearms2.Cloth_Movement", t = 2.7},
		{s = "Firearms2.M79_Close", t = 3.5},
		},
    },
}