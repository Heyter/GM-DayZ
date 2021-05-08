local GM = GM or GAMEMODE

-- Restrict character name
function Schema:AdjustCreationPayload(client, payload, newPayload)
	newPayload.name = client:Name()
end

function Schema:PlayerSpray(client)
	return true
end

function Schema:PostPlayerLoadout(client, reload)
	client:AllowFlashlight(true)
end

function Schema:CanPlayerJoinClass(client, class, classData)
	return false
end

function Schema:CanPlayerAccessDoor(client, door, access)
	return true
end

function Schema:PlayerShouldTakeDamage(client, attacker)
	if (IsValid(attacker) and attacker:IsPlayer()) then
		if (attacker.protection_time or 0) > CurTime() then
			attacker.protection_time = nil -- снимаем защиту, если тот кого-то атаковал.
		elseif (attacker:GetLocalVar("protection")) then
			return false
		end
	end

	if (client:GetLocalVar("protection") or (client.protection_time or 0) > CurTime()) then
		return false
	end
end

function Schema:ShutDown()
	-- save DB space, mate.
	for _, v in ipairs(ents.GetAll()) do
		if (v:GetClass() == "ix_item" or v:GetClass() == "gmodz_grave" or v:GetClass() == "gmodz_npc_loot") then
			v:Remove()
		end

		if (v:GetClass() == "prop_ragdoll" and v.ixInventory) then
			v:Remove()
		end
	end
end

-- Sandbox stuff
function Schema:PlayerSpawnProp(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnRagdoll(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnObject(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnNPC(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnEffect(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnSENT(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnSWEP(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnVehicle(client)
	return client:IsSuperAdmin()
end

function GM:PlayerHurt(client, attacker, health, damage)
	if ((client.ixNextPain or 0) < CurTime() and health > 0) then
		local painSound = hook.Run("GetPlayerPainSound", client) or false --Schema:GetPainSound(client:IsFemale() and "female" or "male", client:LastHitGroup())

		if (painSound != false) then
			client:EmitSound(painSound)
		end

		client.ixNextPain = CurTime() + 0.33
	end

	ix.log.Add(client, "playerHurt", damage, attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass())
end