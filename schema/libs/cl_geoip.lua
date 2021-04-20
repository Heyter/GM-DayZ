ix.geoip = ix.geoip or {}
ix.geoip.cache = ix.geoip.cache or {}

hook.Add("CharacterLoaded", "GeoIP", function()
	for _, v in ipairs(player.GetHumans()) do
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