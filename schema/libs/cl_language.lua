local translate_to = {
	bg        = "Bulgarian",
	cs        = "Czech",
	da        = "Danish",
	de        = "German",
	el        = "Greek",
	["en-pt"] = "Pirate",
	en        = "English",
	es        = "Spanish",
	et        = "Estonian",
	fi        = "Finnish",
	fr        = "French",
	he        = "Hebrew",
	hr        = "Croatian",
	hu        = "Hungarian",
	it        = "Italian",
	ja        = "Japanese",
	ko        = "Korean",
	lt        = "Lithuanian",
	nl        = "Dutch",
	no        = "Norwegian",
	pl        = "Polish",
	["pt-br"] = "Brazilian Portuguese",
	["pt-pt"] = "Portuguese",
	ru        = "Russian",
	sk        = "Slovak",
	["sv-se"] = "Swedish",
	th        = "Thai",
	tr        = "Turkish",
	uk        = "Ukranian",
	vi        = "Vietnamese",
	["zh-cn"] = "Simplified Chinese",
	["zh-tw"] = "Traditional Chinese",
}

hook.Add("InitializedConfig", "native_language.InitializedConfig", function()
	if (!LocalPlayer().native_lang) then
		local langKey = translate_to[GetConVar("gmod_language"):GetString()]
		ix.option.Set("language", langKey and langKey:lower() or "english", true)

		LocalPlayer().native_lang = true
	end
end)