ix.steam = ix.steam or {}

if (CLIENT) then
	function ix.steam.GetAvatar(steamID64)
		file.CreateDir("helix/avatars")
		ix.steam.avatars = ix.steam.avatars or {}

		if (ix.steam.avatars[steamID64]) then
			return ix.steam.avatars[steamID64]
		end

		local path = "helix/avatars/"..steamID64..".png"

		if (file.Exists(path, "DATA")) then
			ix.steam.avatars[steamID64] = Material("../data/" .. path, "noclamp smooth")

			return ix.steam.avatars[steamID64]
		end

		http.Fetch("https://steamcommunity.com/profiles/" .. steamID64 .. "?xml=1", function(content)
			local avatar = content:match("<avatarFull><!%[CDATA%[(.-)%]%]></avatarFull>") or "http://i.imgur.com/ovW4MBM.png"

			http.Fetch(avatar, function(body)
				file.Write(path, body)
				ix.steam.avatars[steamID64] = Material("../data/" .. path, "noclamp smooth")

				return ix.steam.avatars[steamID64]
			end)
		end)

		return false
	end

	concommand.Add("ix_flush_avatars", function()
		local root = "helix/avatars/"

		for _, v in pairs(file.Find(root .. "/*.png", "DATA")) do
			file.Delete(root .. "/" .. v)
		end

		ix.steam.avatars = {}
	end)
end