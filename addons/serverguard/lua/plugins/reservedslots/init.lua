--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]
local plugin = plugin
plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.SHARED)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)
plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.SHARED)
plugin:IncludeFile("cl_panel.lua", SERVERGUARD.STATE.CLIENT)

RESERVED_SLOTS = RESERVED_SLOTS or {}

plugin.config:AddCallback("hide", function(value)
    RunConsoleCommand("sv_visiblemaxplayers", value and (game.MaxPlayers() - plugin.config:GetValue("slots")) or 0)
end)

plugin.config:AddCallback("slots", function(value)
    RunConsoleCommand("sv_visiblemaxplayers", plugin.config:GetValue("hide") and (game.MaxPlayers() - value) or 0)
end)

plugin.config:AddCallback("ranks", function(value)
	if (!istable(value) or table.IsEmpty(value)) then return end

	timer.Create("reservedslots_ranks", 5, 1, function()
		local query = serverguard.mysql:Select("serverguard_users")
			query:WhereIn("rank", table.GetKeys(value))
			query:Callback(function(result)
				if (istable(result)) then
					RESERVED_SLOTS = {}

					for _, v in ipairs(result) do
						RESERVED_SLOTS[v.steam_id] = true
					end
				end
			end)
		query:Execute()
	end)
end)

hook.Add("serverguard.PostLoadConfig", "reservedslots", function()
	local data = plugin.config and plugin.config.entries
	if (!data or !data["ranks"]) then return end

	local query = serverguard.mysql:Select("serverguard_users")
		query:WhereIn("rank", table.GetKeys(data["ranks"].value))
		query:Callback(function(result)
			if (istable(result)) then
				RESERVED_SLOTS = {}

				for _, v in ipairs(result) do
					RESERVED_SLOTS[v.steam_id] = true
				end
			end
		end)
	query:Execute()
end)

-- TODO: проверить работоспособность
hook.Add("CheckPassword", "reservedslots", function(steamID64)
	local steamID32 = util.SteamIDFrom64(steamID64)

    if (!RESERVED_SLOTS[steamID32] and player.GetCount() + (plugin.config:GetValue("slots") or 0) >= game.MaxPlayers()) then
		game.KickID(steamID32, 'Sorry, that slot has been reserved.')
    end
end)

hook.Add("CAMI.PlayerUsergroupChanged", "reservedslots", function(client, _, new)
	local data = plugin.config and plugin.config.entries
	if (!data) then return end

	if (data['ranks'] and data['ranks'].value[new]) then
		RESERVED_SLOTS[client:SteamID()] = true
	end
end)