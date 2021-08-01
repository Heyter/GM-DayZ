AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "AK47 SB ANB"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.HoldType = "smg"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 30
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 6

SWEP.InternalSpreadDegrees = 0
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Weapon_smg1.NPC_Single")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.1

SWEP.NPCSpreadDegrees = 5
SWEP.NPCBurstMin = 2
SWEP.NPCBurstMax = 5
SWEP.NPCBurstDelay = 0.1
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end