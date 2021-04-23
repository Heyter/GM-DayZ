util.AddNetworkString("killfeed.Message")

local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(player, attacker, dmg)
	local weapon = attacker.GetActiveWeapon and attacker:GetActiveWeapon() or nil
	local attacker = attacker:GetName()

	net.Start("killfeed.Message")
		net.WriteString(player:GetName())
		net.WriteString(attacker)
		net.WriteString(weapon and weapon:GetName() or "NULL")

		net.WriteBool(player:GetNetVar("bleeding", false))
	net.Broadcast()
end