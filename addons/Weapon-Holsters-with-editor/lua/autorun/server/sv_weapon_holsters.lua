--[[
   __  ___        __      __                                
  /  |/  /__ ____/ /__   / /  __ __                         
 / /|_/ / _ `/ _  / -_) / _ \/ // /                         
/_/  /_/\_,_/\_,_/\__/ /_.__/\_, /                          
   ___       __             /___/         ___           __  
  / _ \___  / /_ _____ ___ / /____ ____  / _ \__ ______/ /__
 / ___/ _ \/ / // / -_|_-</ __/ -_) __/ / // / // / __/  '_/
/_/   \___/_/\_, /\__/___/\__/\__/_/   /____/\_,_/\__/_/\_\ 
            /___/                                           
https://steamcommunity.com/profiles/76561198057599363
]]
WepHolster.wepInfo = WepHolster.wepInfo or {}
util.AddNetworkString("sendWHData")
util.AddNetworkString("sendWholeWHData")
util.AddNetworkString("applyWepHolsterData")
util.AddNetworkString("reloadWH")
util.AddNetworkString("deleteWHData")
util.AddNetworkString("reloadWholeWH")
util.AddNetworkString("resetWHDataToDefault")
util.AddNetworkString("resetWholeWHDataToDefault")
util.AddNetworkString("WepHolsters_Settings")

function WepHolster.setWHData(wep, tbl)
	file.Write("wepholster/" .. wep .. ".txt", util.TableToJSON(tbl, true))
	WepHolster.wepInfo[wep] = tbl
end

--[[
local function InitOfInit()
	for k, v in pairs(WepHolster.defData) do
		WepHolster.setWHData(k, v)
	end
end
hook.Add("Initialize", "wepHolstersInit", function()
	if file.IsDir("wepholster", "DATA") then
		local files, dirs = file.Find("wepholster/*.txt", "DATA")

		for k, v in pairs(files) do
			WepHolster.wepInfo[string.sub(v, 1, #v - 4)] = util.JSONToTable(file.Read("wepholster/" .. v))
		end
	else
		file.CreateDir("wepholster", "DATA")
		InitOfInit()
	end
end)
]]
local function checkValidSWEP()
	if not file.IsDir("wepholster", "DATA") then
		file.CreateDir("wepholster", "DATA")

		for k, v in pairs(WepHolster.defData) do
			file.Write("wepholster/" .. k .. ".txt", util.TableToJSON(v, true))
		end
	end

	local files, dirs = file.Find("wepholster/*.txt", "DATA")

	for k, v in pairs(files) do
		local wepclass = string.sub(v, 1, #v - 4)
		local swep = weapons.Get(wepclass)

		if swep or WepHolster.HL2Weps[wepclass] or not WepHolster.defData[wepclass] then
			WepHolster.wepInfo[wepclass] = util.JSONToTable(file.Read("wepholster/" .. v))
		end
	end
end

hook.Add("Initialize", "Initialize Weapon Holsters", checkValidSWEP)

function WepHolster.sendWholeWHData(ply)
	net.Start("sendWholeWHData")
	net.WriteTable(WepHolster.wepInfo)
	net.Send(ply)
end

hook.Add("PlayerInitialSpawn", "sendWholeWHData", WepHolster.sendWholeWHData)

net.Receive("resetWholeWHDataToDefault", function(len, ply)
	if ply:IsSuperAdmin() then
		local files, dirs = file.Find("wepholster/*", "DATA")

		for k, v in pairs(files) do
			file.Delete("wepholster/" .. v)
			--print(v)
		end
		file.Delete("wepholster")
		WepHolster.wepInfo = {}
		checkValidSWEP()
		net.Start("sendWholeWHData")
		net.WriteTable(WepHolster.wepInfo)
		net.Broadcast()
	end
end)

net.Receive("resetWHDataToDefault", function(len, ply)
	if ply:IsSuperAdmin() then
		local class = net.ReadString()

		if WepHolster.defData[class] then
			net.Start("sendWHData")
			net.WriteString(class)
			net.WriteTable(WepHolster.defData[class])
			net.Send(ply)
		end
	end
end)

net.Receive("reloadWholeWH", function(len, ply)
	WepHolster.sendWholeWHData(ply)
end)

net.Receive("applyWepHolsterData", function(len, ply)
	if ply:IsSuperAdmin() then
		local class = net.ReadString()
		local weptbl = net.ReadTable()
		weptbl.notSavedYet = nil
		weptbl.isEditing = nil
		WepHolster.setWHData(class, weptbl)
		net.Start("sendWHData")
		net.WriteString(class)
		net.WriteTable(WepHolster.wepInfo[class])
		net.Broadcast()
	end
end)

net.Receive("reloadWH", function(len, ply)
	if ply:IsSuperAdmin() then
		local class = net.ReadString()

		if WepHolster.wepInfo[class] then
			net.Start("sendWHData")
			net.WriteString(class)
			net.WriteTable(WepHolster.wepInfo[class])
			net.Send(ply)
		end
	end
end)

net.Receive("deleteWHData", function(len, ply)
	if ply:IsSuperAdmin() then
		local class = net.ReadString()
		WepHolster.wepInfo[class] = nil

		if file.Exists("wepholster/" .. class .. ".txt", "DATA") then
			file.Delete("wepholster/" .. class .. ".txt")
		end

		net.Start("sendWHData")
		net.WriteString(class)
		net.WriteTable({})
		net.Broadcast()
	end
end)

function WepHolster.CanEditSetting(ply, con, var)
	if not ply:IsSuperAdmin() then
		ply:PrintMessage(HUD_PRINTCENTER, "You don't have access to server settings.")

		return
	end

	if not ConVarExists(con) then
		return
	end

	print("[Weapon Holsters] " .. ply:Nick() .. " (" .. ply:SteamID() .. ") changed " .. con .. " to " .. tostring(var))
	con = GetConVar(con)
	con:SetString(var)
end

local whitelist = {}
whitelist["sv_weapon_holsters"] = true

net.Receive("WepHolsters_Settings", function(len, ply)
	if not ply then
		return
	end

	if (ply.WH_LAST or 0) > SysTime() then
		return
	end

	ply.WH_LAST = SysTime() + 0.2
	local con = net.ReadString()
	local arg = net.ReadString()

	if not con then
		return
	end

	if not whitelist[con] then
		return
	end

	WepHolster.CanEditSetting(ply, con, arg or nil)
end)