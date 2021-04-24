PLUGIN.name = "Thirdperson Fix"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then return end

function PLUGIN:PlayerBindPress(_, bind, pressed)
	if (bind and bind == "gm_showhelp" and pressed) then
		if (ix.config.Get("thirdperson")) then
			local bEnabled = !ix.option.Get("thirdpersonEnabled", false)

			ix.option.Set("thirdpersonEnabled", bEnabled)
		end
	end
end

do
	local blocked_att = Material("hud/atts/default.png", "mips smooth") -- ArcCW asset
	local icon_size = 32
	local red = Color(200, 50, 50)

	function PLUGIN:HUDPaint()
		if (ix.config.Get("thirdperson") and ix.option.Get("thirdpersonEnabled", false)) then
			surface.SetDrawColor(red)
			surface.SetMaterial(blocked_att)
			surface.DrawTexturedRect(ScrW() / 2 - icon_size / 2, ScrH() / 2 - icon_size / 2, icon_size, icon_size)
		end
	end
end

do
	local keyBlacklist = IN_ATTACK + IN_ATTACK2

	function PLUGIN:StartCommand(client, command)
		if (ix.config.Get("thirdperson") and ix.option.Get("thirdpersonEnabled", false)) then
			command:RemoveKey(keyBlacklist)
		end
	end
end