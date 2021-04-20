SH_SZ.SafeZones = SH_SZ.SafeZones or {}

function SH_SZ:GetLocalZonePosition(startPosition, endPosition, shape, size)
	local center, min, max

	if (shape == 1) then -- cube
		center = LerpVector(0.5, startPosition, endPosition)
		min = WorldToLocal(startPosition, angle_zero, center, angle_zero)
		max = WorldToLocal(endPosition, angle_zero, center, angle_zero)

		OrderVectors(min, max)
		max = max + Vector(0, 0, size)
	elseif (shape == 2) then
		local m = Vector(size, size, size)
		center, min, max = startPosition, -m, m
	end

	return center, min, max
end

function SH_SZ:IsWithinSafeZone(point)
	if (#self.SafeZones == 0) then return nil end

	local center, min, max

	for _, sz in ipairs(self.SafeZones) do
		center, min, max = self:GetLocalZonePosition(sz.points[1], sz.points[2], sz.shape, sz.size)

		if (center) then
			if (sz.shape == 1) then -- cube
				if (min and max) then
					min, max = center + min, center + max
					OrderVectors(min, max)

					if (point:WithinAABox(min, max)) then
						return sz
					end
				end
			elseif (sz.shape == 2) then -- sphere
				local x, y, z, r = (point.x - center.x), (point.y - center.y), (point.z - center.z), sz.size

				if ((x * x) + (y * y) + (z * z) <= r * r) then
					return sz
				end
			end
		end
	end

	return nil
end

local position, oldenter, status
hook.Add("PlayerPostThink", "SH_SZ.PlayerPostThink", function(client)
	if (!client:GetCharacter()) then return end

	status = client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE)

	if (status == SH_SZ.PROTECTED) then return end
	if (status == SH_SZ.OUTSIDE) then -- exited
		SH_SZ.m_Safe = nil
	elseif (status == SH_SZ.ENTERING) then
		position = select(1, client:GetBonePosition(client:LookupBone("ValveBiped.Bip01_Spine") or -1)) or client:LocalToWorld(client:OBBCenter())
		position = SH_SZ:IsWithinSafeZone(position)

		if (position) then -- entered
			oldenter = SH_SZ.m_Safe and SH_SZ.m_Safe.enter or CurTime()

			SH_SZ.m_Safe = {
				enter = oldenter,
				opts = position.opts
			}
		end
	end
end)

net.Receive("SH_SZ.Notify", function()
	SH_SZ:Notify(net.ReadString(), nil, SH_SZ.Style[net.ReadBool() and "success" or "failure"])
end)