ix.currency.Set("", "", "RU", "models/gmodz/misc/dollar.mdl")

ix.config.SetDefault("font", "Jura")
ix.config.SetDefault("genericFont", "Malgun Gothic")
ix.config.SetDefault("music", "music/hl2_song19.mp3")
ix.config.SetDefault("maxAttributes", 0)
ix.config.SetDefault("maxCharacters", 1)
ix.config.SetDefault("allowVoice", true)
ix.config.SetDefault("communityURL", "https://steamcommunity.com/id/meow1337")
ix.config.SetDefault("weaponAlwaysRaised", true)
--ix.config.SetDefault("color", Color(75, 119, 190, 255))
ix.config.SetDefault("thirdperson", true)
ix.config.SetDefault("itemPickupTime", 0)

ix.config.Add("jumpPower", 200, "How high player jumps by default.", function(oldValue, newValue)
	for _, v in ipairs(player.GetAll())	do
		v:SetJumpPower(newValue)
	end
end, {
	data = {min = 0, max = 1024},
	category = "characters"
})

-- unload plugins
local noLoad = {
	saveitems = true,
	recognition = true,
	wepselect = true,
	stamina = true,
	doors = true,
	spawnsaver = true,
	thirdperson = true,
	permakill = true,
	ammosave = true
}

function Schema:InitializedPlugins()
	local unloaded = ix.data.Get("unloaded", {}, true, true)
	local bRestart = nil

	for uniqueID in pairs(noLoad) do
		if (!unloaded[uniqueID]) then
			ix.plugin.SetUnloaded(uniqueID, true)
			bRestart = true
		end
	end

	if (SERVER and bRestart) then
		MsgC(Color(87, 180, 242), "[GMODZ]: ", Color(255, 172, 0), "Plugins unloaded. Restarting server in 5 seconds!", "\n")
		RunConsoleCommand("sv_hibernate_think", "1")

		timer.Simple(5, function()
			RunConsoleCommand("_restart")
		end)

		return
	end
end

Schema.countryIcon = {
	w = 16,
	h = 11
}

-- PreDrawOutlines
Schema.outlineItems = {
	["ix_item"] = true,
	["gmodz_grave"] = true,
	["ix_money"] = true,
	["ix_shipment"] = true,
	["gmodz_npc_loot"] = true,
}

if (CLIENT) then
	ix.option.Add("minimalTooltips", ix.type.bool, true, {
		category = "appearance"
	})

	function Schema:LoadFonts(font, genericFont)
		local function get_scale()
			local sc = math.Clamp(ScrH() / 1080, 0.7, 1)
			if (!th) then
				th = 48 * sc
				m = th * 0.25
			end

			return sc
		end

		surface.CreateFont("GmodZ.Numeric", {
			font = font,
			size = math.min(18, 20 * get_scale()),
			weight = 200
		})

		surface.CreateFont("GmodZ.NormalText", {
			font = font,
			size = 18,
			weight = 550,
			extended = true
		})

		get_scale = nil
	end
end