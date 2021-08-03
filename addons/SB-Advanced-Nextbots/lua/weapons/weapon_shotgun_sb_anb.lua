AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "#HL2_Shotgun"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.HoldType = "shotgun"
SWEP.Weight = 4

SWEP.PrimaryAmmo = "Buckshot"
SWEP.PrimaryClip = 6
SWEP.PrimaryAuto = nil

SWEP.BulletsPerShoot = 8
SWEP.FullShootDamage = 8
SWEP.MuzzleEffect = true
SWEP.MuzzleFlag = 1

SWEP.ShotSound = Sound("Weapon_Shotgun.NPC_Single")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 1

SWEP.NPCBurstMin = 1
SWEP.NPCBurstMax = 3
SWEP.NPCBurstDelay = 0.7
SWEP.NPCRestMin = 1.2
SWEP.NPCRestMax = 1.5
SWEP.NPCSpread = {5,4,3,2,1} -- Разброс

SWEP.SpreadCone = Vector(0.08716,0.08716,0.08716)

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","0",Color(255,80,0))
end

function SWEP:GetNPCBulletSpread(prof)
	return self.NPCSpread[prof+1]
end