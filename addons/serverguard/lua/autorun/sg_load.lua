--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]
AddCSLuaFile()

if (SERVER) then
    include("sg_server.lua")
elseif (CLIENT) then
    include("sg_client.lua")
end

if (not serverguard) then
    Msg("!! URGENT !!\nServerGuard failed to load!\n")
end