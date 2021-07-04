ix.currency.symbol = ""
ix.currency.singular = ""
ix.currency.plural = "RU"

ix.config.SetDefault("font", "Jura")
ix.config.SetDefault("genericFont", "Malgun Gothic")
ix.config.SetDefault("music", "music/hl2_song19.mp3")
ix.config.Set("maxAttributes", 0)
ix.config.Set("maxCharacters", 1)
ix.config.Set("allowVoice", true)
ix.config.SetDefault("communityURL", "https://steamcommunity.com/id/meow1337")
ix.config.Set("weaponAlwaysRaised", true)
ix.config.SetDefault("color", Color(75, 119, 190, 255))
ix.config.Set("thirdperson", true)

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
end