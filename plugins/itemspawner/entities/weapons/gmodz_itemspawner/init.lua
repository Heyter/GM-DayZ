AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1.5)
end

function SWEP:Reload()
	if (!IsFirstTimePredicted() or (self.next_reload_press or 0) > CurTime()) then
		return
	end

	self.next_reload_press = CurTime() + 2

	self:SetNextPrimaryFire(CurTime() + 1.5)
	self:GetOwner():ConCommand("ix ItemSpawnerList")
end

function SWEP:PrimaryAttack()
	if IsFirstTimePredicted() then
		local location = self:GetOwner():GetEyeTrace().HitPos
		--location.z = location.z + 10

		local plugin = ix.plugin.Get("itemspawner")

		if (plugin) then
			plugin:AddSpawner(self:GetOwner(), location)
		end
    end

    self:SetNextPrimaryFire(CurTime() + .05)
    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end

function SWEP:SecondaryAttack()
	local PLUGIN = ix.plugin.Get("itemspawner")

	if (PLUGIN and PLUGIN.spawner.positions and #PLUGIN.spawner.positions > 0) then
		local client = self:GetOwner()
		if (!IsValid(client)) then return false end

		local location = client:GetEyeTrace().HitPos
		--location.z = location.z + 10

		local index = nil

		for k, v in ipairs(PLUGIN.spawner.positions) do
			if (v.position.x >= location.x - 16 and v.position.x <= (location.x + 16) and v.position.y >= location.y - 16 and v.position.y <= (location.y + 16)) then
				index = k
				break
			end
		end

		if (index) then
			if (PLUGIN:RemoveSpawner(client, index)) then
				net.Start("ixItemSpawnerDelete")
					net.WriteTable(PLUGIN.spawner.positions)
				net.Send(client)

				client:NotifyLocalized("cmdRemoved")
			else
				client:NotifyLocalized("cmdNoRemoved")
			end
		end
	end

	self:SetNextSecondaryFire(CurTime() + .05)
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end