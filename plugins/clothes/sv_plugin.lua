util.AddNetworkString("ixClothesSet")
util.AddNetworkString("ixClothesClear")

local function DropHat(client, model, itemID, dir)
	local entity = ents.Create("ix_item")
	entity:Spawn()
	entity:SetItem(itemID)

	if (IsValid(client)) then
		entity.ixSteamID = client:SteamID()
		entity.ixCharID = client:GetCharacter():GetID()
		entity:SetNetVar("owner", entity.ixCharID)
	end

	local boneIndex = client:LookupBone("ValveBiped.Bip01_Head1")

	if (boneIndex) then
		local pos, ang = client:GetBonePosition(boneIndex)
		entity:SetPos(pos)
		entity:SetAngles(ang)
	else
		local pos = client:GetPos()
		pos.z = pos.z + 68

		entity:SetPos(pos)
	end

	local phys = entity:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:SetMass(10)

		if (dir) then
			phys:ApplyForceCenter(dir * 1000)
		else
			phys:ApplyForceCenter(-client:GetAimVector() * 1000)
		end

		phys:AddAngleVelocity(VectorRand() * 200)
	end
end

function PLUGIN:PlayerTakeDamage(client, damageInfo)
	local attacker = damageInfo:GetAttacker()

	if (IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC() or attacker:IsNextBot())) then
		local hit_group = client:LastHitGroup()
		local is_head = hit_group == HITGROUP_HEAD

		hook.Run("PlayerTakeDamageClothes", client, damageInfo, attacker)
		local damage = damageInfo:GetDamage()

		for k, v in pairs(client:GetClothesItem()) do
			if (is_head and k == "hat") then
				client:EmitSound("physics/metal/metal_solid_impact_bullet1.wav")

				local eyePos = client:EyePos()
				local effect = EffectData()
					effect:SetOrigin(eyePos)
					effect:SetNormal(eyePos)
					effect:SetMagnitude(1)
					effect:SetScale(1)
					effect:SetRadius(1)
				util.Effect("Sparks", effect)

				eyePos, effect = nil, nil
			end

			if (damage > 0) then
				if (istable(v.damageReduction)) then
					damage = math.max(0, damage - ((v.damageReduction[hit_group] or 0) * damage))
				else
					damage = math.max(0, damage - ((v.damageReduction or 0) * damage))
				end

				-- TODO: переделать (установку durability) как на оружие
				if (v.useDurability) then
					local durability = math.max(0, v:GetData("durability", v.defDurability or 100) - damage)

					if (client:GetHealth() - damage <= 0) then
						v:SetData("durability", durability, false)
						return
					end

					if (durability <= 0) then
						if (v.dropHat) then
							v:SetData("durability", durability, false)

							local success = v:RemovePart(client, true)

							if (success and ix.item.instances[v.id]) then
								DropHat(client, v.model, v.id, attacker:GetAimVector())
							end
						else
							v:SetData("durability", durability)
							v:RemovePart(client)
						end
					else
						v:SetData("durability", durability)
					end
				end
			else
				break
			end
		end

		if (damage == 0) then
			damageInfo:SetDamage(0)
			return
		else
			damageInfo:SetDamage(damage)
		end
	end
end

function PLUGIN:PlayerDeath(client)
	client.ixClothes = {}

	-- hook LocalPlayerDeath
--[[ 	net.Start("ixClothesClear")
	net.Send(client) ]]
end

FindMetaTable("Player").SetClothesItem = function(self, category, item)
	self.ixClothes = self.ixClothes or {}
	self.ixClothes[category] = item

	net.Start("ixClothesSet")
		net.WriteString(category)
		if (item) then
			net.WriteUInt(item.id, 32)
		end
	net.Send(self)
end

--[[ concommand.Add("bot_ads", function()
	if (!IsValid(Entity(2))) then return end

	local inventory = Entity(2):GetCharacter():GetInventory()
	inventory:Add("low_helmet")

	timer.Simple(1, function()
		local items = Entity(2):GetItems()
		for k, v in pairs(items) do
			if (v.uniqueID == "low_helmet") then
				ix.item.PerformInventoryAction(Entity(2), "Equip", v:GetID(), v.invID, {})
				break
			end
		end
	end)
end) ]]