ix.geoip = ix.geoip or {}
ix.geoip.cache = ix.geoip.cache or {}

hook.Add("CharacterLoaded", "GeoIP", function()
	local client = LocalPlayer()

	for _, v in ipairs(player.GetHumans()) do
		if v == client then
			-- TODO: Country codes map for other languages
			ix.option.Set("language", client:GetNetVar("country_code") == "ru" and "russian" or "english", true)
		end

		if (IsValid(v)) then
			ix.geoip:GetMaterial(v)
		end
	end
end)

function ix.geoip:GetMaterial(client)
	if (!IsValid(client)) then return false end

	local id = client:SteamID64()

	if (self.cache[id]) then
		return self.cache[id]
	end

	id = client:GetNetVar("country_code")
	if (!id) then return false end

	self.cache[id] = Material("flags16/" .. id .. ".png", "noclamp smooth")
	return self.cache[id]
end