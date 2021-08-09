PLUGIN.name = "Enchanced Damage"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Break legs, bleeding, etc..."

ix.bleeding = ix.bleeding or { max_level = 4, min_damage = 15 }

if (CLIENT) then
	function ix.bleeding:Format()
		local level = LocalPlayer():GetNetVar("bleeding")
		if (!level) then return end

		local prefix = L"bleeding_type_mild" -- ЛЕГКОЕ

		if (level == 2) then
			prefix = L"bleeding_type_average" -- СРЕДНЕЕ
		elseif (level == 3) then
			prefix = L"bleeding_type_serious" -- СЕРЬЁЗНОЕ
		elseif (level >= 4) then
			prefix = L"bleeding_type_heavy" -- ТЯЖЕЛОЕ
		end

		prefix = Format("%s %s", prefix, L"bleeding_blood_loss") -- КРОВОТЕЧЕНИЕ

		return prefix, ix.color.LerpHSV(nil, nil, ix.bleeding.max_level, ix.bleeding.max_level - level, 0)
	end
end

ix.util.Include("sv_plugin.lua")

function PLUGIN:ScalePlayerDamage(_, hit_group, dmg_info)
	if (hit_group == HITGROUP_HEAD) then
		dmg_info:ScaleDamage(1.5)
	elseif (hit_group == HITGROUP_CHEST) then
		dmg_info:ScaleDamage(1)
	elseif (hit_group == HITGROUP_STOMACH) then
		dmg_info:ScaleDamage(1)
	elseif (hit_group == HITGROUP_LEFTARM or hit_group == HITGROUP_RIGHTARM) then
		dmg_info:ScaleDamage(2)
	elseif (hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) then
		dmg_info:ScaleDamage(2)
	else
		dmg_info:ScaleDamage(1)
	end
end

function PLUGIN:ScaleNPCDamage(entity, hit_group, dmg_info)
	if (hit_group == HITGROUP_HEAD) then
		dmg_info:ScaleDamage(3)
	elseif (hit_group == HITGROUP_CHEST) then
		dmg_info:ScaleDamage(1)
	elseif (hit_group == HITGROUP_STOMACH) then
		dmg_info:ScaleDamage(1)
	elseif (hit_group == HITGROUP_LEFTARM or hit_group == HITGROUP_RIGHTARM) then
		dmg_info:ScaleDamage(2)
	elseif (hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) then
		dmg_info:ScaleDamage(2)
	else
		dmg_info:ScaleDamage(1)
	end
end

function PLUGIN:Move(client, mv)
	if (!client:GetCharacter() or !client:Alive() or client:GetMoveType() != MOVETYPE_WALK) then return end

	local walkSpeed = mv:GetMaxSpeed()
	local brth = client:GetNetVar("brth", false)

	if (client:HasBuff("adrenaline")) then
		walkSpeed = walkSpeed + 30
	end

	client.playerSpeedModifier = 0
	hook.Run("PlayerSpeedModifier", client, brth)
	walkSpeed = math.max(45, walkSpeed + client.playerSpeedModifier)

	mv:SetMaxSpeed(walkSpeed)
	mv:SetMaxClientSpeed(walkSpeed)

	client.playerJumpModifier = ix.config.Get("jumpPower", 200)
	hook.Run("PlayerJumpModifier", client, brth)

	if (client:GetJumpPower() != client.playerJumpModifier) then
		client:SetJumpPower(client.playerJumpModifier)
	end
end

function PLUGIN:PlayerJumpModifier(client, brth)
	if (client:IsBrokenLeg() and !brth) then
		client.playerJumpModifier = math.max(0, client.playerJumpModifier - 100)
	end
end

function PLUGIN:PlayerSpeedModifier(client, brth)
	if (client:IsBrokenLeg()) then
		client.playerSpeedModifier = client.playerSpeedModifier - 100
	end
end

if (CLIENT) then
	local PLUGIN = PLUGIN

	do
		PLUGIN.EmitSounds = {}
		PLUGIN.EmitSounds["Hurt"] = { head = {}, body = {} }

		for i = 1, 4 do
			PLUGIN.EmitSounds["Hurt"].head[#PLUGIN.EmitSounds["Hurt"].head + 1] = Sound("gmodz/player/headshot" .. i .. ".ogg")
		end

		for i = 1, 16 do
			PLUGIN.EmitSounds["Hurt"].body[#PLUGIN.EmitSounds["Hurt"].body + 1] = Sound("gmodz/player/hit" .. i .. ".wav")
		end

		PLUGIN.EmitSounds["Death"] = {
			female = {
				Sound("vo/npc/female01/no01.wav"),
				Sound("vo/npc/female01/ow01.wav"),
				Sound("vo/npc/female01/ow02.wav"),
				Sound("vo/npc/female01/pain07.wav"),
				Sound("vo/npc/female01/pain08.wav"),
				Sound("vo/npc/female01/pain09.wav"),
				Sound("vo/coast/odessa/female01/nlo_cubdeath02.wav")
			},

			male = {
				Sound("gmodz/player/death1.wav"),
				Sound("gmodz/player/death2.wav"),
				Sound("gmodz/player/death3.wav"),
				Sound("gmodz/player/death4.wav"),
				Sound("gmodz/player/death5.wav"),
				Sound("gmodz/player/death6.wav"),
				Sound("gmodz/player/death7.wav"),
				Sound("gmodz/player/death8.wav"),
				Sound("gmodz/player/death9.wav"),
				Sound("gmodz/player/death10.wav")
			}
		}

		gameevent.Listen("entity_killed")
		function PLUGIN:entity_killed(data)
			local victim = Entity(data.entindex_killed)

			if (IsValid(victim) and victim:IsPlayer()) then
				local deathSounds = victim:IsFemale() and "female" or "male"
				deathSounds = self.EmitSounds["Death"][deathSounds]

				victim:EmitSound(deathSounds[math.random(1, #deathSounds)])
				-- sound.Play(deathSounds[math.random(1, #deathSounds)], victim:GetShootPos(), 90, 100)
			end
		end

		function PLUGIN:EntityEmitSound(data)
			if (data.Entity and data.Entity == LocalPlayer() and data.OriginalSoundName == "Flesh.BulletImpact") then
				return false
			end
		end

		net.Receive("ixHitmarker", function()
			local hurtSounds = net.ReadBool() and "head" or "body"
			hurtSounds = PLUGIN.EmitSounds["Hurt"][hurtSounds]

			LocalPlayer():EmitSound(hurtSounds[math.random(1, #hurtSounds)], 500, 100, 1)
		end)
	end
end

do
	FindMetaTable("Player").IsBrokenLeg = function(self)
		if (self:HasBuff("morphine")) then return false end

		return self:GetLocalVar("legBroken", 0) > CurTime()
	end
end