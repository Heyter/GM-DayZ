AddCSLuaFile("shared.lua")
include("shared.lua")

local PluginName = "player_spawn_points"

function TOOL:LeftClick(trace)
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin()) then
		return false
	end

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN) then return false end

	local stop = nil
	local location = trace.HitPos + trace.HitNormal * 2

	for k, v in ipairs(PLUGIN.spawners) do
		if (self:AreaInRect(v, location)) then
			if (!v.static) then
				v.safezone = tobool(self:GetClientNumber("safezone", 0))
			end

			stop = true
			break
		end
	end

	if (stop) then
		net.Start("ixPlayerSpawnerSync")
			net.WriteTable(PLUGIN.spawners)
		net.Send(owner)

		PLUGIN:SaveData()

		return true
	end

	local angles = (trace.HitPos - owner:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local data = {
		position = location,
		angles = angles,
		title = "Player Spawn Point #" .. table.Count(PLUGIN.spawners) + 1,
		safezone = tobool(self:GetClientNumber("safezone", 0))
	}

	table.insert(PLUGIN.spawners, data)
	data = nil

	net.Start("ixPlayerSpawnerSync")
		net.WriteTable(PLUGIN.spawners)
	net.Send(owner)

	PLUGIN:SaveData()

	return true
end

function TOOL:RightClick(trace)
	local owner = self:GetOwner()

	if (!owner:IsSuperAdmin()) then
		return false
	end

	local PLUGIN = ix.plugin.Get(PluginName)
	if (!PLUGIN or table.IsEmpty(PLUGIN.spawners)) then return false end

	local location = trace.HitPos + trace.HitNormal * 0.04
	local index

	for k, v in ipairs(PLUGIN.spawners) do
		if (!v.static and self:AreaInRect(v, location)) then
			index = k
			break
		end
	end

	if (index) then
		owner:Notify("Точка спавна была удалена.")

		table.remove(PLUGIN.spawners, index)

		net.Start("ixPlayerSpawnerSync")
			net.WriteTable(PLUGIN.spawners)
		net.Send(owner)

		PLUGIN:SaveData()
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

function TOOL:Holster()
	self:Deploy()
end