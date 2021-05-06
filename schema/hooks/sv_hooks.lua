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

do
	local Hit_Sounds = {head = {}, body = {}, death = {}}

	for i = 1, 4 do
		Hit_Sounds.head[#Hit_Sounds.head + 1] = "gmodz/player/headshot" .. i .. ".ogg"
	end

	for i = 1, 16 do
		Hit_Sounds.body[#Hit_Sounds.body + 1] = "gmodz/player/hit" .. i .. ".wav"
	end

	for i = 1, 10 do
		Hit_Sounds.death[#Hit_Sounds.death + 1] = "gmodz/player/death" .. i .. ".wav"
	end

	function Schema:EntityTakeDamage(target, dmg_info)
		if (dmg_info:GetDamage() > 0 and IsValid(target) and (target:IsNPC() or target:IsPlayer()) and dmg_info:IsBulletDamage()) then
			if (target:LastHitGroup() == HITGROUP_HEAD) then
				--target:EmitSound(Hit_Sounds.head[ math.random(1, #Hit_Sounds.head ) ])
				sound.Play(Hit_Sounds.head[ math.random(1, #Hit_Sounds.head) ], target:GetShootPos(), 90, 100)
				-- vol = 40 + math.min(90, dmg_info:GetDamage())
				-- ply:ViewPunch(Angle(math.random(-40, 40), math.random(-40, 40), 0))
			else
				--target:EmitSound(Hit_Sounds.body[ math.random(1, #Hit_Sounds.body ) ])
				sound.Play(Hit_Sounds.body[ math.random(1, #Hit_Sounds.body) ], target:GetShootPos(), 90, 100)
			end
		end
	end

	function Schema:GetPlayerDeathSound(client)
		client:EmitSound(Hit_Sounds.death[ math.random(1, #Hit_Sounds.death) ])
		return false
	end
end