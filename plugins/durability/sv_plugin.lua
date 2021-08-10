local PLUGIN = PLUGIN

function PLUGIN:PlayerTakeDamageClothes(client, info, attacker)
	local weapon = attacker:GetActiveWeapon()

	if (IsValid(weapon) and weapon.ixItem) then
		local durability = (weapon.ixItem:GetData("durability", 100) / 100)
		durability = 0.5 + math.min((0.5 * durability / 0.50), 0.5)

		info:SetDamage(math.Round(info:GetDamage() * durability, 1))
	end
end

function PLUGIN:PlayerSwitchWeapon(client, oldWeapon, newWeapon)
	if (newWeapon.ixItem) then
		client:SetLocalVar("WeaponDurability", newWeapon.ixItem:GetData("durability", 100))
	else
		client:SetLocalVar("WeaponDurability", nil)
	end
end

hook.Add("ArccwSupportPostInit", "durability_weapons.ArccwSupportPostInit", function()
	for _, SWEP in ipairs(weapons.GetList()) do
		local class = SWEP.ClassName

		if (weapons.IsBasedOn(class, "arccw_base")) then
			if (class:find("base") or class:find("nade") or class:find("melee")) then continue end
			local ITEM = ix.item.list[class]

			if (!ITEM) then
				error("unregistered weapon " .. class)
				continue
			end

			function ITEM:OnEquipWeapon(client, weapon)
				if (self.useDurability) then
					if (self.JamCapacity) then
						weapon.HeatCapacity = self.JamCapacity
					end

					client:SetLocalVar("WeaponDurability", self:GetData("durability", 100))
				end

				client:UpdateInventoryAmmo(weapon.Primary.Ammo)
			end

			if (ITEM.useDurability) then
				function ITEM:OnUnequipWeapon(client, weapon)
					if ((weapon.ShotsFired or 0) > 0 and self:GetData("durability", 100) > 0) then
						local durability = math.max(0, self:GetData("durability", 100) - (self.DegradeRate * weapon.ShotsFired))
						weapon.ShotsFired = 0

						self:SetData("durability", durability)
						client:SetLocalVar("WeaponDurability", nil)
					end
				end

				function ITEM:OnSave()
					local weapon = self.player:GetWeapon(self.class)

					if (IsValid(weapon) and (weapon.ShotsFired or 0) > 0 and weapon.ixItem == self and self:GetData("equip")) then
						if (self:GetData("durability", 100) > 0) then
							local durability = math.max(0, self:GetData("durability", 100) - (self.DegradeRate * weapon.ShotsFired))
							weapon.ShotsFired = 0

							self:SetData("durability", durability)
						end
					end
				end
			end

			function SWEP:Hook_PostReload()
				local owner = self:GetOwner()

				ProtectedCall(function()
					local item = self.ixItem

					if (item and item.useDurability) then
						local durability = item:GetData("durability", 100)

						if ((self.ShotsFired or 0) > 0 and durability > 0) then
							durability = math.max(0, math.Round(durability - (item.DegradeRate * self.ShotsFired), 1))

							item:SetData("durability", durability)
							owner:SetLocalVar("WeaponDurability", durability)
						end

						self.MalfunctionMeanCopy = self.MalfunctionMeanCopy or self:MalfunctionMeanCalculate()
						self.MalfunctionMean = math.max(0, self.MalfunctionMeanCopy * (durability / 100))
					end
				end)

				self.ShotsFired = 0

				owner:TakeInventoryAmmo(self.Primary.Ammo, self.LastLoadClip1)
			end

			function SWEP:Hook_PostFireBullets()
				local item = self.ixItem

				self.ShotsFired = (self.ShotsFired or 0) + 1

				if (item and item.useDurability) then
					local durability = item:GetData("durability", 100)

					if (durability > 0) then
						if (durability - (item.DegradeRate * self.ShotsFired) <= 0) then
							item:SetData("durability", 0)

							local owner = self:GetOwner()

							if (IsValid(owner)) then
								owner:SetLocalVar("WeaponDurability", 0)
								owner:NotifyLocalized('DurabilityUnusableTip')
							end

							-- if (item.Unequip) then
								-- item:Unequip(self:GetOwner())
							-- end
						end
					else
						--self:SetJammed(true)
						self.NextMalfunction = 999999
					end
				end
			end
		end
	end
end)