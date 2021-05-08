PLUGIN.name = "Enchanced Damage"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Break legs, bleeding, etc..."

ix.util.Include("sv_plugin.lua")

function PLUGIN:ScalePlayerDamage(client, hit_group, dmg_info)
	if (client:IsPlayer()) then
		if (hit_group == HITGROUP_HEAD) then
			dmg_info:ScaleDamage(2)
		elseif (hit_group == HITGROUP_STOMACH) then
			dmg_info:ScaleDamage(1)
		elseif (hit_group == HITGROUP_LEFTARM or hit_group == HITGROUP_RIGHTARM) then
			dmg_info:ScaleDamage(0.5)
		elseif (hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) then
			dmg_info:ScaleDamage(0.75)
		end
	end
end

function PLUGIN:Move(client, mv)
	if (client:GetMoveType() != MOVETYPE_WALK) then return end

	local additive, walkSpeed = 0, mv:GetMaxSpeed()

	if (client:HasBuff("adrenaline")) then
		additive = additive + 30
	end

	if (!client:HasBuff("morphine") and client:GetLocalVar("legBroken")) then
		walkSpeed = (additive < 1 and client:GetWalkSpeed() * .8 or walkSpeed * .8) + additive
	elseif (additive > 0) then
		walkSpeed = walkSpeed + additive
	end

	mv:SetMaxSpeed(walkSpeed)
	mv:SetMaxClientSpeed(walkSpeed)
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
				Sound("vo/npc/male01/pain07.wav"),
				Sound("vo/npc/male01/pain08.wav"),
				Sound("vo/npc/male01/pain09.wav"),
				Sound("vo/npc/male01/ow01.wav"),
				Sound("vo/npc/male01/ow02.wav"),
				Sound("vo/npc/male01/no02.wav"),
				Sound("vo/npc/Barney/ba_ohshit03.wav"),
				Sound("vo/npc/Barney/ba_ohshit03.wav"),
				Sound("vo/npc/Barney/ba_no01.wav"),
				Sound("vo/npc/Barney/ba_no02.wav"),
				Sound("vo/coast/odessa/male01/nlo_cubdeath02.wav")
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

		net.Receive("ixHitmarker", function()
			local hurtSounds = net.ReadBool() and "head" or "body"
			hurtSounds = PLUGIN.EmitSounds["Hurt"][hurtSounds]

			LocalPlayer():EmitSound(hurtSounds[math.random(1, #hurtSounds)], 500)
		end)
	end

	FindMetaTable("Player").BreakLeg = function(self)
		self:SetJumpPower(80)
	end
end