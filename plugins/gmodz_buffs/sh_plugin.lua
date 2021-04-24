local PLUGIN = PLUGIN

PLUGIN.name = "Buffs"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

ix.buff = ix.buff or {}
ix.buff.meta = ix.buff.meta or {}
ix.buff.list = ix.buff.list or {}

ix.util.Include("sv_plugin.lua")
ix.util.Include("meta/sh_buff.lua", "shared")
ix.util.Include("meta/sv_player.lua", "server")

local function RegisterBuff(uniqueID, path, isSingleFile)
	if (!uniqueID) then
		ErrorNoHalt("[GMODZ::Buffs] You tried to register an buff without uniqueID!\n")
		return
	end

	BUFF = ix.buff.list[uniqueID] or setmetatable({}, ix.buff.meta)
	BUFF.uniqueID = uniqueID

	ix.util.Include(isSingleFile and path or path.."/sh_init.lua", "shared")

	for k, v in pairs(BUFF) do
		if (isfunction(v)) then
			HOOKS_CACHE[k] = HOOKS_CACHE[k] or {}
			HOOKS_CACHE[k][BUFF] = v
		end
	end

	ix.buff.list[BUFF.uniqueID] = BUFF
	BUFF = nil
end

function PLUGIN:InitializedPlugins()
	local directory = self.folder .. "/buffs"

	local files, folders = file.Find(directory.."/*", "LUA")

	for _, v in ipairs(folders) do
		RegisterBuff(v, directory.."/"..v)
	end

	for _, v in ipairs(files) do
		RegisterBuff(string.StripExtension(v), directory.."/"..v, true)
	end
end

-- PLAYER META
FindMetaTable("Player").HasBuff = function(self, uniqueID)
	return (self.buffs or {})[uniqueID]
end

if (CLIENT) then
	net.Receive("ixBuffAdd", function()
		local uniqueID = net.ReadString()
		local value = net.ReadType()

		LocalPlayer().buffs = LocalPlayer().buffs or {}
		LocalPlayer().buffs[uniqueID] = value
	end)

	net.Receive("ixBuffRemove", function()
		local uniqueID = net.ReadString()

		LocalPlayer().buffs = LocalPlayer().buffs or {}
		LocalPlayer().buffs[uniqueID] = nil
	end)

	net.Receive("ixBuffClears", function()
		LocalPlayer().buffs = {}
	end)
end