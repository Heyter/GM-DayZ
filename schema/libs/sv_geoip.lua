-- @module ix.geoip

ix.geoip = ix.geoip or {}

ix.geoip.API = "https://freegeoip.app/json/"
ix.geoip.blockedIPs = {
	["loopback"] = true,
	["localhost"] = true,
	["127.0.0.1"] = true,
	["::1"] = true,
	["p2p"] = true
}

ix.geoip.cache = ix.geoip.cache or {}

function ix.geoip:Query(ip, callback)
	ip = string.Explode(":", ip)[1]

	if (self.blockedIPs[ip] or string.StartWith(ip, "192.168")) then
		return
	end

	if (callback and ix.geoip.cache[ip]) then
		callback(ix.geoip.cache[ip])
		return
	end

	http.Fetch(self.API .. ip,
		function(body)
			if (string.Trim(body) != "404 page not found") then
				local data = util.JSONToTable(body)

				if (data) then
					ix.geoip.cache[ip] = {
						country_name = data.country_name,
						country_code = data.country_code,
						-- region_name = data.region_name,
						-- city = data.city
					}

					if (callback) then
						callback(ix.geoip.cache[ip])
					end
				end
			end
		end,

		function() -- error
		end,

		{ -- headers
			["accept"] = 'application/json',
			["content-type"] = 'application/json'
		}
	)
end

hook.Add("LoadData", "GeoIP", function()
	ix.geoip.cache = ix.data.Get("geoipcache", {}, true, true)
end)

hook.Add("SaveData", "GeoIP", function()
	ix.data.Set("geoipcache", ix.geoip.cache, true, true)
end)

-- gameevent.Listen("player_connect")
-- hook.Add("player_connect", "GeoIP", function(data)
	-- local id = data.userid // Same as Player:UserID()

	-- if (!data.bot) then
		-- ix.geoip:Query(data.address, function(data)
			-- if (istable(data)) then
				-- Player(id):SetNetVar("country_code", data.country_code:lower())
			-- end
		-- end)
	-- end
-- end)

hook.Add("PlayerLoadedCharacter", "GeoIP", function(client, character)
	if (client:IsBot()) then return end

	if (character) then
		ix.geoip:Query(client:IPAddress(), function(data)
			if (istable(data)) then
				client:SetNetVar("country_code", data.country_code:lower())
			end
		end)
	end
end)

concommand.Add("ix_flush_geoip", function(client)
	if (IsValid(client)) then return end

	ix.geoip.cache = {}
	ix.data.Set("geoipcache", {}, true, true)

	MsgC(Color(50, 200, 50), "geoipcache.txt flushed!\n")
end)