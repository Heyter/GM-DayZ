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
		phys:ApplyForceCenter(-client:GetAimVector() * 1000)
		phys:AddAngleVelocity(VectorRand() * 200)
	end
end

function PLUGIN:PlayerTakeDamage(client, damageInfo)
	local attacker = damageInfo:GetAttacker()

	if (IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC())) then
		if (attacker:IsPlayer() and hook.Run("PlayerShouldTakeDamage", client, attacker) == false) then return end

		local hit_group = client:LastHitGroup()
		local damage = damageInfo:GetDamage()
		local item = client:GetClothesItem()

		if (hit_group == HITGROUP_HEAD) then
			item = item["hat"]
		end

		if (item and istable(item.damageReduction)) then
			damage = damage - ((item.damageReduction[hit_group] or 0) * damage)

			if (damage == 0) then
				damageInfo:SetDamage(0)
				return
			else
				damageInfo:SetDamage(damage)
			end

			local durability = math.max(0, item:GetData("durability", item.defDurability or 100) - damage)

			if (client:GetHealth() - damage <= 0) then
				item:SetData("durability", durability, false)
				return
			end

			if (durability <= 0) then
				if (item.dropHat) then
					item:SetData("durability", durability, false)

					local success = item:RemovePart(client, true)

					if (success and ix.item.instances[item.id]) then
						DropHat(client, item.model, item.id)
					end
				else
					item:SetData("durability", durability)
					item:RemovePart(client)
				end
			else
				item:SetData("durability", durability)
			end
		end
	end
end

function PLUGIN:OnPlayerGraveCreate(client)
	client.ixClothes = {}
end

FindMetaTable("Player").SetClothesItem = function(self, category, item)
	self.ixClothes = self.ixClothes or {}
	self.ixClothes[category] = item
end

FindMetaTable("Player").GetClothesItem = function(self)
	return (self.ixClothes or {})
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