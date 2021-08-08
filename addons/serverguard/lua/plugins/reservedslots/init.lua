--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]
local plugin = plugin
plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.SHARED)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)

local bypassRanks = { -- TODO: вынести в меню с добавлением групп
	["admin"] = true,
	["superadmin"] = true,
	["founder"] = true
}

plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.SHARED)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)

local function kickID(uniqueID, reason)
    RunConsoleCommand("kickid", tostring(uniqueID), reason)
end

plugin.config:AddCallback("hide", function(value)
    RunConsoleCommand("sv_visiblemaxplayers", value and (game.MaxPlayers() - plugin.config:GetValue("slots")) or 0)
end)

plugin.config:AddCallback("slots", function(value)
    RunConsoleCommand("sv_visiblemaxplayers", plugin.config:GetValue("hide") and (game.MaxPlayers() - value) or 0)
end)

plugin:Hook("PlayerAuthed", "reservedslots.PlayerAuthed", function(ply, steamID, uniqueID)
    if (player.GetCount() + plugin.config:GetValue("slots") >= game.MaxPlayers()) then
        local queryObj = serverguard.mysql:Select("serverguard_users")
        queryObj:Select("rank")
        queryObj:Where("steam_id", steamID)
        queryObj:Callback(function(result, status, lastID)
            local rank = "user"

            if (istable(result) and #result > 0) then
                rank = result[1].rank
            end

			if (!bypassRanks[rank]) then
                kickID(uniqueID, "Sorry, that slot has been reserved.")

                return
            end

--[[             local kickablePlayer, shortestTime = nil, math.huge

            for _, client in ipairs(player.GetAll()) do
                local vrank = serverguard.player:GetRank(client)
                local timeConnected = client:TimeConnected()

                if (timeConnected < shortestTime and !bypassRanks[vrank]) then
                    kickablePlayer, timeConnected = client, timeConnected
                end
            end

            if (kickablePlayer and IsValid(kickablePlayer)) then
                kickablePlayer:Kick("Sorry, freeing up slots for reserved slots.")
            end ]]
        end)

        queryObj:Execute()
    end
end)