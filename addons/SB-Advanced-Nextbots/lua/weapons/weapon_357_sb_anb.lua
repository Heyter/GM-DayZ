AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "#HL2_357"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.HoldType = "revolver"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "357"
SWEP.PrimaryClip = 6
SWEP.PrimaryAuto = nil

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 40
SWEP.MuzzleEffect = true
SWEP.MuzzleFlag = 6

SWEP.ShotSound = Sound("Weapon_357.Single")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.1

SWEP.NPCBurstMin = 1
SWEP.NPCBurstMax = 1
SWEP.NPCBurstDelay = 0.75
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 0.75
SWEP.NPCSpread = {3,2.5,2,1.5,1} -- Разброс

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath",".",Color(255,80,0))
end

function SWEP:GetNPCBulletSpread(prof)
	return self.NPCSpread[prof+1]
end