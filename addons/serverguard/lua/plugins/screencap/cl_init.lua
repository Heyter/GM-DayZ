--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]
local plugin = plugin
plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.CLIENT)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)

net.Receive("serverguard.ScreencapRequest", function()
	local quality = net.ReadUInt(7)
	local renderID = tostring(math.random(1000, 9999) + math.random(1000, 9999))

	hook.Add("PostRender", renderID, function()
		local nick, steamid = LocalPlayer():Nick(), LocalPlayer():SteamID64()
		local data = render.Capture({
			format = "jpeg",
			quality = quality or 75,
			x = 0,
			y = 0,
			w = ScrW(),
			h = ScrH(),
		})

		data = util.Base64Encode(data)

		HTTP{
			["method"] = "POST",
			["url"] = "https://api.imgur.com/3/image",
			["parameters"] = {
				["title"] = ("%s - %s"):format(nick, steamid),
				["name"] = tostring(os.time()),
				["description"] = ("%s (%s) :: %s"):format(nick, steamid, os.date("%d/%m/%Y at %H:%M")),
				["image"] = data,
				["type"] = "base64"
			},
			["headers"] = {
				[ "Authorization" ] = "Client-ID 62f1e31985e240b"
			},
			success = function(code, body)
				if code != 200 then
					return
				end

				body = util.JSONToTable(body)
				if (!body or !istable(body) or !body.data.link and body.data.error) then
					return
				end

				net.Start("serverguard.ScreencapRequest")
					net.WriteString(body.data.link)
				net.SendToServer()
			end
		}

		data = nil
		hook.Remove("PostRender", renderID)
	end)
end)

net.Receive("serverguard.Screencap", function()
	local link = net.ReadString()
	local steamid = net.ReadString()

	screencap[steamid] = link
end)