AddCSLuaFile()

SWEP.DontPickupWeapon = true
SWEP.SB_ANB_WEPBase = true

if SERVER then
	util.AddNetworkString("SB_ANB_WEPBase.muzzle")
end

SWEP.PrintName = ""
SWEP.Spawnable = false
SWEP.Author = "Shadow Bonnie (RUS)"
SWEP.Purpose = "Should only be used internally by advanced nextbots!"

SWEP.WorldModel = nil
SWEP.HoldType = "normal"
SWEP.Weight = 0

SWEP.PrimaryAmmo = ""
SWEP.PrimaryClip = 0
SWEP.PrimaryAuto = false

SWEP.BulletsPerShoot = 1
SWEP.FullShootDamage = 0
SWEP.MuzzleEffect = false
SWEP.MuzzleFlag = 2

SWEP.ShotSound = Sound("")
SWEP.ShotSoundLevel = 0
SWEP.NextShootTime = 0

SWEP.NPCSpreadDegrees = 0
SWEP.NPCBurstMin = 0
SWEP.NPCBurstMax = 0
SWEP.NPCBurstDelay = 0
SWEP.NPCRestMin = 0
SWEP.NPCRestMax = 0

-- Приоритет только голова
SWEP.TrueScope = false

SWEP.Tracer = 1
SWEP.TracerType = "Tracer" -- https://wiki.facepunch.com/gmod/Enums/TRACER

SWEP.Primary = {
	Ammo = "None",
	ClipSize = -1,
	DefaultClip = -1,
}

SWEP.Secondary = {
	Ammo = "None",
	ClipSize = -1,
	DefaultClip = -1,
}

function SWEP:Initialize()
	self.Primary = {
		Ammo = self.PrimaryAmmo,
		ClipSize = self.PrimaryClip,
		DefaultClip = self.PrimaryClip,
		Automatic = self.PrimaryAuto,
	}

	self:SetHoldType(self.HoldType)
	self:SetClip1(self.PrimaryClip)
end

function SWEP:OnReloaded()
	self.Primary.Ammo = self.PrimaryAmmo
	self.Primary.ClipSize = self.PrimaryClip
	self.Primary.DefaultClip = self.PrimaryClip
	self.Primary.Automatic = self.PrimaryAuto

	self:SetHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	return CurTime()>=self:GetNextPrimaryFire() and self:Clip1()>0
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()
	self.InternalSpread = self.InternalSpread or math.sin(math.rad(self:GetNPCBulletSpread(owner:GetCurrentWeaponProficiency())) / 2)
	self.InternalLevel = self.InternalLevel or owner:GetCurrentWeaponProficiency()

	local enemy = owner:GetEnemy()

	local targetPos
	local muzzlePos = self:GetAttachment(1).Pos

	if (enemy != NULL) then
		if (!self.TrueScope) then
			local head = enemy:LookupBone("ValveBiped.Bip01_Head1")

			if (head != 0) then
				targetPos = enemy:GetBonePosition(head)
			else
				targetPos = enemy:EyePos()
			end
		end

		targetPos = (targetPos or enemy:WorldSpaceCenter()) + (enemy:GetVelocity() * 0.25 * math.Rand(0, self.InternalLevel or WEAPON_PROFICIENCY_GOOD))
	end

	targetPos = targetPos or owner:WorldSpaceCenter()
	targetPos = (targetPos - muzzlePos):GetNormalized()

--[[ 	local aim
	local position = owner:WorldSpaceCenter() -- Src
	if (owner:GetEnemy() != NULL) then
		aim = (owner:GetEnemy():WorldSpaceCenter() - position):GetNormalized()
		aim:Add(VectorRand(-self.InternalSpread or 5, self.InternalSpread or 5))  -- Dir
	end ]]

	owner:FireBullets({
		Num = self.BulletsPerShoot,
		Src = muzzlePos,
		Dir = targetPos,
		Spread = self.SpreadCone or VectorRand(-self.InternalSpread, self.InternalSpread),
		AmmoType = self:GetPrimaryAmmoType(),
		Damage = self.FullShootDamage/self.BulletsPerShoot,
		Attacker = owner,
		Tracer = self.Tracer,
		TracerName = self.TracerType
	})

	if SERVER and self.MuzzleEffect then
		net.Start("SB_ANB_WEPBase.muzzle",true)
			net.WriteEntity(self)
		net.SendPVS(self:GetPos())
	end

	sound.Play(self.ShotSound, muzzlePos, self.ShotSoundLevel, math.random(95, 105), 1)

	self:SetClip1(self:Clip1() - 1)
	self:SetNextPrimaryFire(CurTime()+self.NextShootTime)
	self:SetLastShootTime()
end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() then return end
end

function SWEP:Equip()
end

function SWEP:OwnerChanged()
end

function SWEP:Reload()
	self:SetClip1(self.Primary.ClipSize)
end

function SWEP:GetNPCBulletSpread(prof)
	return self.NPCSpreadDegrees/(prof+1)
end

function SWEP:GetNPCBurstSettings()
	return self.NPCBurstMin,self.NPCBurstMax,self.NPCBurstDelay
end

function SWEP:GetNPCRestTimes()
	return self.NPCRestMin,self.NPCRestMax
end

function SWEP:CanBePickedUpByNPCs()
	return true
end

if (SERVER) then
	function SWEP:GetCapabilities()
		return CAP_WEAPON_RANGE_ATTACK1
	end
end

if CLIENT then
	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	net.Receive("SB_ANB_WEPBase.muzzle",function(len)
		local wep = net.ReadEntity()
		if !IsValid(wep) then return end

		local ef = EffectData()
		ef:SetEntity(wep)
		ef:SetAttachment(1)
		ef:SetScale(1)
		ef:SetFlags(wep.MuzzleFlag or 2)
		util.Effect("MuzzleFlash", ef, false)

		if IsValid(wep:GetOwner()) then
			wep:GetOwner():MuzzleFlash()
		else
			wep:MuzzleFlash()
		end
	end)
end