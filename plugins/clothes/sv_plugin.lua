local v1 = Vector(0, 0, 1200)
local v2 = Vector(0, 0, 700)
local function DropHat(client, model, dir)
	local entity = ents.Create("prop_physics")
	entity:SetModel(model)
	entity:Spawn()

	entity:PhysicsInit(SOLID_VPHYSICS)
	entity:SetSolid(SOLID_VPHYSICS)
	entity:SetMoveType(MOVETYPE_VPHYSICS)
	entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)

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
		phys:SetVelocityInstantaneous(client:GetVelocity())

		if (!dir) then
			phys:ApplyForceCenter(v1)
		else
			phys:ApplyForceCenter(v2 + dir * 500)
		end

		phys:AddAngleVelocity(VectorRand() * 200)
		phys:Wake()
	end

	timer.Simple(7, function()
		if (IsValid(entity)) then
			entity:Remove()
		end
	end)
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

		if (item and item.damageReduction) then
			damage = damage - (item.damageReduction * damage)

			if (damage == 0) then
				damageInfo:SetDamage(0)
				return
			else
				damageInfo:SubtractDamage(damage)
			end

			local durability = math.max(0, item:GetData("durability", item.defDurability or 100) - damage)

			if (durability <= 0) then
				if (item.dropHat) then
					if (item:RemovePart(client, true)) then
						DropHat(client, item.model)
					end
				else
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