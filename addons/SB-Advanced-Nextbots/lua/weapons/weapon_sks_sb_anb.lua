AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "SKS SB ANB"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/sks.mdl"
SWEP.HoldType = "RPG"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 10
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 20
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Firearms2_SKS")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.15

SWEP.NPCSpreadDegrees = 30 -- Разброс, чем выше значение тем сильнее.
SWEP.NPCBurstMin = 1
SWEP.NPCBurstMax = 10
SWEP.NPCBurstDelay = 0.3
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end

--Для бандита 1 уровня