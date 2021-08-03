AddCSLuaFile()

SWEP.Base = "weapon_sb_anb_base"
SWEP.PrintName = "RPK47 SB ANB"
SWEP.WorldModel = "models/weapons/fas2/world/machineguns/rpk.mdl"
SWEP.HoldType = "ar2"
SWEP.Weight = 3

SWEP.PrimaryAmmo = "SMG1"
SWEP.PrimaryClip = 45
SWEP.PrimaryAuto = true

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 30
SWEP.MuzzleEffect = true

SWEP.ShotSound = Sound("Firearms2_RPK47")
SWEP.ShotSoundLevel = 90
SWEP.NextShootTime = 0.1

SWEP.NPCSpreadDegrees = 50 -- Разброс, чем выше значение тем сильнее.
SWEP.NPCBurstMin = 10
SWEP.NPCBurstMax = 45
SWEP.NPCBurstDelay = 0.1
SWEP.NPCRestMin = 0.75
SWEP.NPCRestMax = 1

if CLIENT then
	killicon.AddFont(SWEP.Folder:sub(9,-1),"HL2MPTypeDeath","/",Color(255,80,0))
end

--Для бандита 3 уровня