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

			if (client:Health() <= dmg_info:GetDamage()) then
				client:BreakLeg(10) -- todo убрать 10
			end
		end

		Schema:PlayerEmitPainSound(client, hit_group)
	end
end

function PLUGIN:Move(client, move_data)
	if (client:GetMoveType() != MOVETYPE_WALK) then return end

	if (client:GetLocalVar("legBroken")) then
		local speed = move_data:GetMaxSpeed() * .4
		move_data:SetMaxSpeed(speed)
		move_data:SetMaxClientSpeed(speed)
	end
end

if (CLIENT) then
	FindMetaTable("Player").BreakLeg = function(self)
		self:SetJumpPower(80)
	end
end