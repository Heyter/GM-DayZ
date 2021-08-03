AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "M4A1 SB ANB"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/m4a1.mdl"
SWEP.HoldType = "ar2"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 30
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 25
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Firearms2_M4A1")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.0667

SWEP.NPCSpreadDegrees = 50 -- Разброс, чем выше значение тем сильнее.
SWEP.NPCBurstMin = 10
SWEP.NPCBurstMax = 30
SWEP.NPCBurstDelay = 0.0667
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end

--Для военного 2 уровня