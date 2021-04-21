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

function L(key, ...)
	local languages = ix.lang.stored
	local langKey = translate_to[GetConVar("gmod_language"):GetString()]:lower()
	local info = languages[langKey] or languages.english

	return string.format(info and info[key] or languages.english[key] or key, ...)
end

function L2(key, ...)
	local langKey = translate_to[GetConVar("gmod_language"):GetString()]:lower()
	local info = ix.lang.stored[langKey]

	if (info and info[key]) then
		return string.format(info[key], ...)
	end
end

ix.option.Get("language", "english").populate = nil