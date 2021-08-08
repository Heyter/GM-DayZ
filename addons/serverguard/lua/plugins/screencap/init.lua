util.AddNetworkString("serverguard.Screencap")
util.AddNetworkString("serverguard.ScreencapRequest")

local plugin = plugin
plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.SHARED)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)

local screencaps = {}

net.Receive("serverguard.Screencap", function(_, client)
    if (serverguard.player:HasPermission(client, "Screencap")) then
		local steamid64 = net.ReadString()
		local quality = net.ReadUInt(7)
        local target = util.FindPlayer(steamid64)

        if (IsValid(target) and (!screencaps[target] or screencaps[target] < CurTime())) then
			screencaps[target] = CurTime() + 30

            net.Start("serverguard.ScreencapRequest")
				net.WriteUInt(quality, 7)
			net.Send(target)
        end
    end
end)

net.Receive("serverguard.ScreencapRequest", function(_, target)
	if (!screencaps[target]) then return end

	local url = net.ReadString()
	if (url:gsub(".+i%.imgur%.com/%w+%.jpg", "") != "") then
		screencaps[target] = nil
		return
	end

	local receivers = {}
	for _, v in ipairs(player.GetHumans()) do
		if (serverguard.player:HasPermission(v, "Screencap")) then
			receivers[#receivers + 1] = v
		end
	end

	if (#receivers > 0) then
		net.Start("serverguard.Screencap")
			net.WriteString(url)
			net.WriteString(target:SteamID64())
		net.Send(receivers)
	end

	receivers, screencaps[target] = nil, nil
end)

hook.Add("PlayerDisconnect", "serverguard.ScreencapDisconnect", function(client)
	screencaps[client] = nil
end)