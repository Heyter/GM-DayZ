util.AddNetworkString("SH_SZ.New")
util.AddNetworkString("SH_SZ.Edit")
util.AddNetworkString("SH_SZ.Delete")
util.AddNetworkString("SH_SZ.Menu")
util.AddNetworkString("SH_SZ.Teleport")
util.AddNetworkString("SH_SZ.Notify")
util.AddNetworkString("SH_SZ.Closed")

if (SH_SZ.UseWorkshop) then
	resource.AddWorkshop("1130097039")
else
	resource.AddFile("materials/shenesis/general/close.png")
	resource.AddFile("materials/shenesis/safezones/cube.png")
	resource.AddFile("materials/shenesis/safezones/sphere.png")
	resource.AddFile("resource/fonts/circular.ttf")
	resource.AddFile("resource/fonts/circular_bold.ttf")
end

SH_SZ.SafeZones = SH_SZ.SafeZones or {}

function SH_SZ:CreateSafeZone(sz, shape)
	local z = ents.Create("sh_safezone")
	z:Spawn()
	z.m_Data = sz
	z.m_Options = sz.opts
	z.m_Points = sz.points
	z.m_fSize = sz.size

	shape.setup(z, sz.points, sz.size)

	sz.zone = z
	sz.index = z:EntIndex()
end

function SH_SZ:New(ply, shape, points, size, opts)
	if (!self.Usergroups[ply:GetUserGroup()]) then
		self:Notify(ply, "not_allowed", false)
		return
	end

	local tbl = {
		creator = ply:SteamID(),
		shape = shape.id,
		points = points,
		size = math.max(0, size),
		opts = opts,
		date = os.time(),
	}

	-- Check options
	opts.ptime = math.max(opts.ptime or self.DefaultOptions.ptime, 0)

	table.insert(self.SafeZones, tbl)

	self:CreateSafeZone(tbl, shape)

	self:Notify(ply, "safe_zone_created", true)
	self:Sync(nil, true)

	ServerLog(ply:Nick() .. " <" .. ply:SteamID() .. "> created Safe Zone #" .. #self.SafeZones .. " '" .. opts.name .. "'\n")
end

function SH_SZ:Edit(ply, id, points, size, opts)
	local sz = self.SafeZones[id]
	if (!sz) then
		self:Notify(ply, "an_error_has_occured", false)
		return
	end

	sz.points = points
	sz.size = math.max(0, size)
	sz.opts = opts

	SafeRemoveEntity(sz.zone)
	self:CreateSafeZone(sz, self.ShapesIndex[sz.shape])

	self:Notify(ply, "safe_zone_edited", true)
	ServerLog(ply:Nick() .. " <" .. ply:SteamID() .. "> edited Safe Zone #" .. id .. " '" .. sz.opts.name .. "'\n")
end

function SH_SZ:Delete(ply, id)
	local sz = self.SafeZones[id]
	if (!sz) then
		self:Notify(ply, "an_error_has_occured", false)
		return
	end

	SafeRemoveEntity(sz.zone)

	table.remove(self.SafeZones, id)

	self:Notify(ply, "safe_zone_deleted", true)
	ServerLog(ply:Nick() .. " <" .. ply:SteamID() .. "> deleted Safe Zone #" .. id .. " '" .. sz.opts.name .. "'\n")
end

function SH_SZ:PlayerSpawn(ply)
	-- If we spawn in a SZ it makes sense that we should receive protection immediately
	timer.Simple(0.3, function()
		if (!IsValid(ply)) then
			return end

		local sz = ply.SH_SZ
		if (!sz) then
			return end

		ply:SetLocalVar("SH_SZ.Safe", SH_SZ.PROTECTED)

		hook.Run("PlayerEnterSafeZone", ply, SH_SZ.PROTECTED)
	end)
end

function SH_SZ:PlayerPostThink(ply)
	local sz = ply.SH_SZ
	if (!sz) then
		return end

	local st = self:GetSafeStatus(ply)
	if (st == SH_SZ.ENTERING and CurTime() >= sz.enter + sz.opts.ptime) then
		ply:SetLocalVar("SH_SZ.Safe", SH_SZ.PROTECTED)

		hook.Run("PlayerEnterSafeZone", ply, SH_SZ.PROTECTED)
	end
end

function SH_SZ:PlayerShouldTakeDamage(ply, atk)
	if (IsValid(atk) and atk:IsPlayer() and SH_SZ:GetSafeStatus(atk) != SH_SZ.OUTSIDE) then
		return false
	end

	if (self:GetSafeStatus(ply) == SH_SZ.PROTECTED) then
		return false
	end
end

function SH_SZ:EnterSafeZone(ply, zone)
	-- allows for merged safe zones
	local oldzone, oldenter

	if (ply.SH_SZ) then
		oldenter = ply.SH_SZ.enter
		oldzone = ply.SH_SZ.zone
	end

	ply.SH_SZ = {
		enter = oldenter or CurTime(),
		zone = zone,
		opts = zone.m_Options,
	}

	if (zone.m_Options.ptime >= 0) and (!oldzone or oldzone == zone or ply:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.ENTERING) then
		ply:SetLocalVar("SH_SZ.Safe", SH_SZ.ENTERING)
		hook.Run("PlayerEnterSafeZone", ply, SH_SZ.ENTERING)
	else
		ply:SetLocalVar("SH_SZ.Safe", SH_SZ.PROTECTED)
		hook.Run("PlayerEnterSafeZone", ply, SH_SZ.PROTECTED)
	end

	local msg = zone.m_Options.entermsg or self.DefaultOptions.entermsg or ""
	if (#msg > 0) then
		ply:Notify(msg)
	end
end

function SH_SZ:ExitSafeZone(ply, zone)
	-- allows for merged safe zones
	if (ply.SH_SZ and ply.SH_SZ.zone ~= zone) then
		return end

	ply.SH_SZ = nil
	ply:SetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE)

	hook.Run("PlayerExitSafeZone", ply)

	local msg = zone.m_Options.leavemsg or self.DefaultOptions.leavemsg or ""
	if (#msg > 0) then
		ply:Notify(msg)
	end
end

function SH_SZ:OnEntityCreated(ent)
	timer.Simple(0, function()
		if (!IsValid(ent)) then
			return end

		if (ent:IsNPC()) then
			local zone = self:IsWithinSafeZone(ent:LocalToWorld(ent:OBBCenter()))

			if (zone) then
				if (zone.m_Options.nonpc) then
					ent:Remove()
				end
			end
		end
	end)
end

function SH_SZ:PlayerSpawnedProp(ply, mdl, ent)
	if (self.Usergroups[ply:GetUserGroup()]) then
		return end

	local zone = self:IsWithinSafeZone(ent:LocalToWorld(ent:OBBCenter()))
	if (zone) then
		if (zone.m_Options.noprop) then
			ent:Remove()
			return
		end
	end

	ent.SH_SpawnedBy = ply
end

function SH_SZ:IsWithinSafeZone(point)
	for _, sz in pairs (self.SafeZones) do
		local zone = sz.zone
		if (IsValid(zone)) then
			local pos = zone:GetPos()
			local min, max = zone:GetCollisionBounds()
			min = pos + min
			max = pos + max
			OrderVectors(min, max)

			if (point:WithinAABox(min, max)) then
				return zone
			end
		end
	end

	return nil
end

function SH_SZ:TeleportToSafeZone(ply, id)
	local sz = self.SafeZones[id]
	if (!sz) then
		return end

	local center = Vector(0, 0, 0)
	for _, pnt in pairs (sz.points) do
		center = center + pnt
	end
	center = center / #sz.points

	local ang = Angle(0, -90, 45)
	local ideal, maxdist
	for i = 1, 8 do
		local endpos = center + ang:Up() * self.TeleportIdealDistance
		local tr = util.TraceLine({start = center, endpos = endpos, filter = ply})
		local dist = math.Round(tr.HitPos:Distance(center))
		if (!ideal or maxdist < dist) then
			ideal = tr.HitPos
			maxdist = dist
		end

		ang.y = ang.y + 45
	end

	ply:SetPos(ideal)
	ply:SetEyeAngles((center - ideal):Angle())

	ServerLog(ply:Nick() .. " <" .. ply:SteamID() .. "> teleported to Safe Zone #" .. #self.SafeZones .. " '" .. sz.opts.name .. "'\n")
end

function SH_SZ:Sync(ply, bNotAdmin)
	local json = util.TableToJSON(self.SafeZones)
	local compressed = util.Compress(json)
	local length = compressed:len()

	net.Start("SH_SZ.Menu")
		net.WriteUInt(length, 32)
		net.WriteData(compressed, length)

	if (ply) then
		net.WriteBool(!bNotAdmin)
		net.Send(ply)
	else
		net.WriteBool(false)
		net.Broadcast()
	end

	if (ply and !bNotAdmin) then
		ply.SH_PosBeforeEditor = ply:GetPos()
		ply.SH_MoveTypeBeforeEditor = ply:GetMoveType()
		ply:SetNoDraw(true)
		ply:SetNotSolid(true)
		ply:DrawWorldModel(false)
		ply:DrawShadow(false)
		ply:GodEnable()
		ply:SetNoTarget(true)
		ply:SetMoveType(MOVETYPE_NOCLIP)
	end
end

function SH_SZ:Notify(ply, msg, good)
	net.Start("SH_SZ.Notify")
		net.WriteString(msg)
		net.WriteBool(good or false)
	net.Send(ply)
end

hook.Add("OnEntityCreated", "SH_SZ.OnEntityCreated", function(ent)
	SH_SZ:OnEntityCreated(ent)
end)

hook.Add("PlayerSpawnedProp", "SH_SZ.PlayerSpawnedProp", function(ply, mdl, ent)
	SH_SZ:PlayerSpawnedProp(ply, mdl, ent)
end)

hook.Add("PlayerSpawnedSENT", "SH_SZ.PlayerSpawnedSENT", function(ply, ent)
	SH_SZ:PlayerSpawnedProp(ply, "", ent)
end)

hook.Add("PlayerSpawnedVehicle", "SH_SZ.PlayerSpawnedVehicle", function(ply, ent)
	SH_SZ:PlayerSpawnedProp(ply, "", ent)
end)

hook.Add("PlayerSpawn", "SH_SZ.PlayerSpawn", function(ply)
	SH_SZ:PlayerSpawn(ply)
end)

hook.Add("PlayerPostThink", "SH_SZ.PlayerPostThink", function(ply)
	SH_SZ:PlayerPostThink(ply)
end)

hook.Add("PlayerShouldTakeDamage", "SH_SZ.PlayerShouldTakeDamage", function(ply, atk)
	local b = SH_SZ:PlayerShouldTakeDamage(ply, atk)
	if (b ~= nil) then
		return b
	end
end)

hook.Add("PlayerInitialSpawn", "SH_SZ.PlayerInitialSpawn", function(client)
	timer.Simple(1, function()
		if (IsValid(client)) then
			SH_SZ:Sync(client, true)
		end
	end)
end)

net.Receive("SH_SZ.New", function(_, ply)
	if (!SH_SZ.Usergroups[ply:GetUserGroup()]) then
		SH_SZ:Notify(ply, "not_allowed", false)
		return
	end

	local shape = SH_SZ.ShapesIndex[net.ReadUInt(16)]
	if (!shape) then
		SH_SZ:Notify(ply, "an_error_has_occured", false)
		return
	end

	local points = {}
	for i = 1, shape.points do
		points[i] = net.ReadVector()
	end

	local size = net.ReadFloat()

	local opts = {}
	for i = 1, net.ReadUInt(16) do
		opts[net.ReadString()] = net.ReadType()
	end

	SH_SZ:New(ply, shape, points, size, opts)
end)

net.Receive("SH_SZ.Edit", function(_, ply)
	if (!SH_SZ.Usergroups[ply:GetUserGroup()]) then
		SH_SZ:Notify(ply, "not_allowed", false)
		return
	end

	local id = net.ReadUInt(16)
	local sz = SH_SZ.SafeZones[id]
	if (!sz) then
		SH_SZ:Notify(ply, "an_error_has_occured", false)
		return
	end

	local shape = SH_SZ.ShapesIndex[sz.shape]
	if (!shape) then
		SH_SZ:Notify(ply, "an_error_has_occured", false)
		return
	end

	local points = {}
	for i = 1, shape.points do
		points[i] = net.ReadVector()
	end

	local size = net.ReadFloat()

	local opts = {}
	for i = 1, net.ReadUInt(16) do
		opts[net.ReadString()] = net.ReadType()
	end

	SH_SZ:Edit(ply, id, points, size, opts)
end)

net.Receive("SH_SZ.Delete", function(_, ply)
	if (!SH_SZ.Usergroups[ply:GetUserGroup()]) then
		SH_SZ:Notify(ply, "not_allowed", false)
		return
	end

	local id = net.ReadUInt(16)
	local sz = SH_SZ.SafeZones[id]
	if (!sz) then
		SH_SZ:Notify(ply, "an_error_has_occured", false)
		return
	end

	SH_SZ:Delete(ply, id)
end)

net.Receive("SH_SZ.Teleport", function(_, ply)
	if (!SH_SZ.Usergroups[ply:GetUserGroup()]) then
		SH_SZ:Notify(ply, "not_allowed", false)
		return
	end

	SH_SZ:TeleportToSafeZone(ply, net.ReadUInt(16))
end)

net.Receive("SH_SZ.Closed", function(_, ply)
	if (!ply.SH_PosBeforeEditor) then
		return end

	ply:SetPos(ply.SH_PosBeforeEditor)
	ply:SetMoveType(ply.SH_MoveTypeBeforeEditor)
	ply:SetNoDraw(false)
	ply:SetNotSolid(false)
	ply:DrawWorldModel(true)
	ply:DrawShadow(true)
	ply:GodDisable()
	ply:SetNoTarget(false)

	ply.SH_PosBeforeEditor = nil
	ply.SH_MoveTypeBeforeEditor = nil
end)