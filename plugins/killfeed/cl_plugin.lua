local PLUGIN = PLUGIN

local fade_time = 8
local KillFeed = {}

net.Receive("killfeed.Message", function()
	local victim = Player(net.ReadUInt(8))
	local attacker = Player(net.ReadUInt(8)) -- Can be NULL Entity

	local is_bleed = net.ReadBool()
	local n = #KillFeed + 1

	KillFeed[n] = {
		victim = victim,
		attacker = attacker,
		is_bleed = is_bleed
	}

	timer.Simple(fade_time, function()
		table.remove(KillFeed, n)
	end)
end)

function PLUGIN:HUDPaint()
	-- WIP
end