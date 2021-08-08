--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]
resource.AddWorkshop("685130934")

serverguard = {
    RconEnabled = false -- Toggles ServerGuard's 'rcon' command. Only change this if you know what you're doing.
    
}

SERVERGUARD = {}
local folders = {}

function serverguard.AddFolder(path)
    table.insert(folders, path)
end

AddCSLuaFile("sg_client.lua")
AddCSLuaFile("sg_shared.lua")
include("sg_shared.lua")

--
--
--
hook.Add("Initialize", "serverguard.Initialize", function()
    file.CreateDir("serverguard")

    for i = 1, #folders do
        file.CreateDir("serverguard/" .. folders[i])
    end

    hook.Call("serverguard.Initialize", nil)
end)

--
-- Load a players data.
--
hook.Add("PlayerInitialSpawn", "serverguard.PlayerInitialSpawn", function(client)
    client.serverguard = {}
    serverguard.ranks:SendInitialRanks(client)
    serverguard.player:Load(client)

    if (serverguard.GetCurrentVersion() ~= serverguard.GetLatestVersion() and client:IsAdmin()) then
        serverguard.netstream.Start(client, "sgUpdateNotification", serverguard.GetLatestVersion())
    end

    hook.Call("serverguard.LoadPlayerData", nil, client, steamID, uniqueID)
end)

--
-- Needed to update in a local server
--
hook.Add("serverguard.RanksLoaded", "serverguard.RanksLoaded", function()
    serverguard.ranks:SendInitialRanks()
end)

--
-- Reset ServerGuard.
--
local SG_IN_RESET, SG_RESET_TOKEN = nil, nil

local function RecursiveRemove(directory)
    if (not SG_IN_RESET) then return end

    if (string.sub(directory, -1) ~= "/") then
        directory = directory .. "/"
    end

    local files, folders = file.Find(directory .. "*", "DATA")

    for k, v in ipairs(files) do
        file.Delete(directory .. v)
    end

    for k, v in ipairs(folders) do
        if (v ~= ".." and v ~= ".") then
            RecursiveRemove(directory .. v)
        end
    end

    file.Delete(directory)
end

concommand.Add("serverguard_reset", function(client, command, arguments)
    if (not IsValid(client)) then
        if (not SG_IN_RESET) then
            SG_RESET_TOKEN = math.random(1000, 9999)
            MsgC(Color(255, 0, 0), "CAUTION: This will reset ServerGuard and remove ALL data.\n")
            MsgC(Color(255, 255, 0), "We recommend you take a backup of the current data before confirming your reset.\n")
            MsgC(Color(255, 255, 0), "You will need to enter the following command to confirm your reset: ")
            MsgN("serverguard_reset " .. tostring(SG_RESET_TOKEN))
            MsgC(Color(255, 255, 0), "The server will restart when the reset is complete.\n")
            SG_IN_RESET = true
        elseif (SG_RESET_TOKEN ~= nil) then
            if (tonumber(arguments[1]) == SG_RESET_TOKEN) then
                RecursiveRemove("serverguard/")
                serverguard.mysql:Drop("serverguard_bans"):Execute()
                serverguard.mysql:Drop("serverguard_ranks"):Execute()
                serverguard.mysql:Drop("serverguard_reports"):Execute() -- backwards compatibility
                serverguard.mysql:Drop("serverguard_users"):Execute()
                hook.Call("serverguard.mysql.DropTables", nil)
                RunConsoleCommand("changelevel", game.GetMap())
            else
                MsgC(Color(255, 255, 0), "You have entered an incorrect reset code.\n")
                MsgC(Color(255, 255, 0), "The reset process has been aborted. You can restart it by entering the command: ")
                MsgN("serverguard_reset")
                SG_IN_RESET, SG_RESET_TOKEN = nil, nil
            end
        end
    end
end)