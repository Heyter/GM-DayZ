util.AddNetworkString('ixDeathNotice')

function PLUGIN:DoPlayerDeath(victim, attacker, dmg_info)
	local inflictor = dmg_info:GetInflictor()

	if (IsValid(victim.bleeding_att) and (victim.DeathMsg or "") == "bledout") then
		attacker = victim.bleeding_att
	else
		if (inflictor == attacker and inflictor != victim) then
			local weapon = attacker.GetActiveWeapon and attacker:GetActiveWeapon() or nil

			if (IsValid(weapon)) then
				inflictor = weapon
			end
		end
	end

	if (IsValid(attacker) and attacker:IsPlayer() and attacker != victim) then
		attacker:AddFrags(1)
	end

	net.Start("ixDeathNotice")
		net.WriteEntity(victim)
		net.WriteEntity(attacker)
		net.WriteString(inflictor:GetClass())
		net.WriteString(victim.DeathMsg or "")
	net.Broadcast()
end

FindMetaTable("Player").KillFeed = function(self, reason)
	self.DeathMsg = reason
	self:Kill()
end