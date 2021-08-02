AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "TOZ34 SB ANB"
SWEP.WorldModel = "models/weapons/fas2/world/shotguns/toz34.mdl"
SWEP.HoldType = "ar2"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 2
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 12
SWEP.FullShootDamage = 35
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Firearms2_TOZ34")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 1

SWEP.NPCSpreadDegrees = 100 -- Разброс, чем выше значение тем сильнее.
SWEP.NPCBurstMin = 1
SWEP.NPCBurstMax = 1
SWEP.NPCBurstDelay = 0.2
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end