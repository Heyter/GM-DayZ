util.AddNetworkString("killfeed.Message")

local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(player, attacker, dmg)
	net.Start("killfeed.Message")
		net.WriteUInt(player:UserID(), 8)
		net.WriteUINt(attacker:IsPlayer() and attacker:UserID() or 0, 8)
		net.WriteBool(player:GetNetVar("bleeding", false))
	net.Broadcast()
end