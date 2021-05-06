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
	FindMetaTable("Player").BreakLeg = function(self)
		self:SetJumpPower(80)
	end
end