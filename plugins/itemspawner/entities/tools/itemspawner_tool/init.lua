AddCSLuaFile("shared.lua")
include("shared.lua")

local PluginName = "itemspawner"

function TOOL:LeftClick(trace)
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin()) then
		return false
	end

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN) then return false end

	local stop = nil
	local location = trace.HitPos + trace.HitNormal

	for k, v in ipairs(PLUGIN.spawners) do
		if (self:AreaInRect(v, location)) then
			stop = true
			break
		end
	end

	if (stop) then
		return true
	end

	PLUGIN:AddSpawner(owner, location)
	return true
end

function TOOL:RightClick(trace)
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin()) then
		return false
	end

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN) then return false end

	local location = trace.HitPos + trace.HitNormal
	local index

	for k, v in ipairs(PLUGIN.spawners) do
		if (!v.static and self:AreaInRect(v, location)) then
			index = k
			break
		end
	end

	if (index) then
		if (PLUGIN:RemoveSpawner(owner, index)) then
			net.Start("ixItemSpawnerSync")
				net.WriteTable(PLUGIN.spawners)
			net.Send(owner)

			owner:Notify("Точка спавна была удалена.") -- The spawnpoint has been removed.
		else
			owner:Notify("Нет точки спавна с таким именем.") -- No spawnpoint with that name.
		end
	else
		return false
	end

	return true
end

function TOOL:Deploy()
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin()) then
		return false
	end

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN or table.IsEmpty(PLUGIN.spawners)) then return false end

	net.Start("ixPlayerSpawnerSync")
		net.WriteTable(PLUGIN.spawners)
	net.Send(owner)

	return true
end

function TOOL:Reload()
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin() or (self.next_reload_press or 0) > CurTime()) then
		return false
	end

	self.next_reload_press = CurTime() + 2

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN or table.IsEmpty(PLUGIN.spawners)) then return false end

	net.Start("ixItemSpawnerManager")
		net.WriteTable(PLUGIN.spawners)
	net.Send(owner)

	return false
end