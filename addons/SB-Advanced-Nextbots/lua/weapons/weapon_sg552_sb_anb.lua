AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "SG552 SB ANB"
SWEP.WorldModel = "models/weapons/fas2/world/rifles/sg552.mdl"
SWEP.HoldType = "ar2"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 20
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 20
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Firearms2_SG552")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.0857

SWEP.NPCSpreadDegrees = 50 -- Разброс, чем выше значение тем сильнее.
SWEP.NPCBurstMin = 10
SWEP.NPCBurstMax = 20
SWEP.NPCBurstDelay = 0.0857
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end

--Для военного 1 уровня