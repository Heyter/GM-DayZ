ENT.Type = "anim"
ENT.SH_IsSZ = true

function ENT:Initialize()
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetSolid(SOLID_BBOX)
	self:DrawShadow(false)

	if (SERVER) then
		self:SetTrigger(true)

		self.m_Players = {}
		self.m_Entities = {}
	end
end

function ENT:SetupCube(a, b, size)
	local center = Vector(a.x + b.x, a.y + b.y, a.z + b.z) / 2
	self:SetPos(center)

	local a, b = self:WorldToLocal(a), self:WorldToLocal(b)
	OrderVectors(a, b)
	self:SetCollisionBounds(a, b + Vector(0, 0, size))

	self.m_Shape = "cube"
end

function ENT:SetupSphere(center, size)
	local m = Vector(size, size, size)

	self:SetPos(center)
	self:SetCollisionBounds(-m, m)

	self.m_Shape = "sphere"
end