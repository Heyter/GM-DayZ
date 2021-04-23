local PLUGIN = PLUGIN

local gap = 4
local fade_time = 8
local KillFeed = {}

local visuals = {}

net.Receive("killfeed.Message", function()
	local victim = net.ReadString()
	local attacker = net.ReadString() .. " "

	local weapon = net.ReadString()

	local is_bleed = net.ReadBool()
	local n = #KillFeed + 1

	KillFeed[n] = {
		victim = victim,
		attacker = attacker,

		weapon = weapon == "NULL" and "мир" or weapon,
		is_bled = is_bled
	}

	timer.Simple(fade_time, function()
		table.remove(KillFeed, n)
	end)
end)

-- Here dark magic to set sizes
-- TODO: Refactoring
local function DrawMessage(i, info)
	local attacker = info.attacker
	local weapon = "["..info.weapon.."] "
	local victim = info.victim

	local attacker_w = (attacker == " ") and 0 or surface.GetTextSize(attacker .. " ")
	local weapon_w = surface.GetTextSize(weapon .. " ")

	local text =  attacker .. (attacker == " " and "" or " ") ..  weapon .. victim

	local sw, sh = ScrW(), ScrH()

	local w, h = surface.GetTextSize(text .. " ")
		w = w + visuals.space_size + visuals.space_size
		h = h * 1.2

	local x, y = sw-w*1.1, h*1.2 + (i * h + gap)

	surface.SetDrawColor(0,0,0,200)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(color_white)
	surface.DrawOutlinedRect(x, y, w, h)

	draw.SimpleText(attacker, "nutDHUDFont", x + visuals.space_size, y + h/2.2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.SimpleText(weapon, "nutDHUDFont", x + visuals.space_size + attacker_w, y + h/2.2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.SimpleText(victim, "nutDHUDFont", x + visuals.space_size + attacker_w + weapon_w, y + h/2.2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function PLUGIN:HUDPaint()
	surface.SetFont("nutDHUDFont")
	if not visuals.space_size then visuals.space_size = surface.GetTextSize(" ") end -- Idk. It can be different?

	for k, v in ipairs(KillFeed) do
		DrawMessage(k, v)
	end
end