AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "#HL2_SMG1"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.HoldType = "smg"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 45
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 6
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Weapon_smg1.NPC_Single")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.075

SWEP.NPCBurstMin = 2
SWEP.NPCBurstMax = 5
SWEP.NPCBurstDelay = 0.075
SWEP.NPCRestMin = 0.33
SWEP.NPCRestMax = 0.66
SWEP.NPCSpread = {7,5,10/3,5/3,1} -- Разброс

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end

function SWEP:GetNPCBulletSpread(prof)
	return self.NPCSpread[prof+1]
end