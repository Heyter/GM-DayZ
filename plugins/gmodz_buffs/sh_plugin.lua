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

function ix.buff.Register(uniqueID, path, isSingleFile)
	if (!uniqueID) then
		ErrorNoHalt("[GMODZ::Buffs] You tried to register an buff without uniqueID!\n")
		return
	end

	uniqueID = uniqueID:lower()

	if (isSingleFile) then
		uniqueID = uniqueID:match("sh_([_%w]+)%.lua")

		if (!uniqueID) then
			ErrorNoHalt("[GMODZ::Buffs] Item at '"..path.."' follows invalid naming convention!\n")
			return
		end
	end

	BUFF = ix.buff.list[uniqueID] or setmetatable({}, ix.buff.meta)
	BUFF.uniqueID = uniqueID

	if (path) then
		ix.util.Include(isSingleFile and path or path.."/sh_init.lua", "shared")
	end

	for k, v in pairs(BUFF) do
		if (isfunction(v)) then
			HOOKS_CACHE[k] = HOOKS_CACHE[k] or {}
			HOOKS_CACHE[k][BUFF] = v
		end
	end

	ix.buff.list[BUFF.uniqueID] = BUFF
	BUFF = nil

	return ix.buff.list[uniqueID]
end

function ix.buff.Get(uniqueID)
	uniqueID = uniqueID:lower()

	return ix.buff.list[uniqueID]
end

function PLUGIN:InitializedPlugins()
	local directory = self.folder .. "/buffs"

	local files, folders = file.Find(directory.."/*", "LUA")

	for _, v in ipairs(folders) do
		ix.buff.Register(v, directory.."/"..v)
	end

	for _, v in ipairs(files) do
		ix.buff.Register(v, directory.."/"..v, true)
	end
end

-- PLAYER META
FindMetaTable("Player").HasBuff = function(self, uniqueID)
	return (self.buffs or {})[uniqueID]
end

if (CLIENT) then
	net.Receive("ixBuffAdd", function()
		local client = LocalPlayer()

		local uniqueID = net.ReadString()
		local value = net.ReadType()

		client.buffs = client.buffs or {}
		client.buffs[uniqueID] = value

		timer.Create("ixBuff", 1, 0, function()
			if (!IsValid(client)) then
				timer.Remove("ixBuff")
				return
			end

			for id, v in pairs(client.buffs) do
				if (isnumber(v)) then
					if (v < CurTime()) then
						client.buffs[id] = nil
						ix.buff.list[id]:OnRemove(self)
					else
						ix.buff.list[id]:OnRun(self)
					end
				end
			end

			if (table.IsEmpty(client.buffs) or !client:Alive() or client:Health() <= 0) then
				timer.Remove("ixBuff")
				client.buffs = {}
			end
		end)
	end)

	net.Receive("ixBuffRemove", function()
		local uniqueID = net.ReadString()

		LocalPlayer().buffs = LocalPlayer().buffs or {}
		LocalPlayer().buffs[uniqueID] = nil

		if (table.IsEmpty(LocalPlayer().buffs)) then
			timer.Remove("ixBuff")
		end
	end)

	net.Receive("ixBuffClears", function()
		LocalPlayer().buffs = {}
		timer.Remove("ixBuff")
	end)
end