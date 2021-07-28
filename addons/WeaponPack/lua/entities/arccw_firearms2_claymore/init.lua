AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(6)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(6)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(self.BaseHealth)
	self:SetMaxHealth(self.BaseHealth)
	self.Owner = self:GetOwner()
	self:SetOwner(NULL)
	self.FuseTime = CurTime() + GetConVar("arccw_equipmenttime"):GetInt()
	self:EmitSound("fas2/claymore/claymore_plant.wav")
	self.Armed = true

	self.m_vecStart = self:GetPos() + self:GetUp() * 15
	--self.m_vecEnd = self.m_vecStart + self:GetForward() * self.RangeDistance
	self.m_angForward = self:GetAngles():Forward()
	self.traceData = {
		start = self.m_vecStart,
		endpos = true,
		filter = self,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs()
	}
end

function ENT:Think()
	if self.Armed then
		if self.FuseTime < CurTime() then
			self:Detonate()
		end

		local tEnts = ents.FindInCone(self.m_vecStart, self.m_angForward, self.RangeDistance, 0.8)
		for i = 1, #tEnts do
			local v = tEnts[i]
			if (IsValid(v) and (v:IsPlayer() or v:IsNPC() or v:IsNextBot())) then
				self.traceData.endpos = v:NearestPoint(self.m_vecStart)
				if (util.TraceHull(self.traceData).Entity == v) then
					self:Detonate()
					break
				end
			end
		end

		self:NextThink(CurTime() + 0.1)
		return true
	end
end

function ENT:OnTakeDamage(info)
	self:SetHealth(self:Health() - info:GetDamage())

	if (self:Health() <= 0 and self.Armed) then
		self:Detonate()
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:Use(activator)
	if activator:IsPlayer() then
		if weapons.GetStored(self.Ammo).Primary.Ammo ~= "" then
			activator:GiveAmmo(1, weapons.GetStored(self.Ammo).Primary.Ammo)
		end

		activator:Give(self.Ammo, true)
	end

	self:EmitSound("weapons/arccw/c4/c4_disarm.wav", 75)
	self:Remove()
end

-- Кешировать не забываем.
local ang1 = Angle(0, 90, 0)
local ang2 = Angle(0, 120, 0)
function ENT:Detonate()
	self.Armed = nil

	local ed = EffectData()
	ed:SetOrigin(self:GetPos())

	local damage = 140
	if self:WaterLevel() >= 1 then
		ParticleEffect("water_explosion_final", ed:GetOrigin(), ang1, nil)
		self:EmitSound("weapons/underwater_explode" .. math.random(3, 4) .. ".wav", 120, 100, 1, CHAN_AUTO)

		damage = damage / 2
	else
		ParticleEffect("explosion_HE_claymore", ed:GetOrigin(), ang2, nil)
		self:EmitSound("fas2/claymore/claymore_explode_1.wav", 100, 100, 1, CHAN_AUTO)
		self:EmitSound("fas2/claymore/claymore_explode_1_distant", 140, 100, 1, CHAN_WEAPON)
	end

	local owner = self.Owner

	if (!IsValid(owner)) then
		owner = game.GetWorld()
	end

	self:SphereDamage(owner, ed:GetOrigin(), self.ExplodeRadius, self.ExplodeDamage)
	--util.BlastDamage(self, owner, ed:GetOrigin(), self.ExplodeRadius, self.ExplodeDamage)
	self:Remove()
end

function ENT:SphereDamage(attacker, position, radius, damage)
	position.z = position.z + 1 // если позиция прям на земле

	local falloff = damage / radius
	local adjustedDamage = damage
	local tr

	local info = DamageInfo()
	info:SetAttacker(attacker)
	info:SetInflictor(self)
	info:SetDamageType(DMG_BLAST)
	info:SetDamageForce(vector_up)
	info:SetDamagePosition(position)

	local tEnts = ents.FindInSphere(position, radius)
	for i = 1, #tEnts do
		local v = tEnts[i]
		if (IsValid(v) and (v:IsPlayer() or v:IsNPC() or v:IsNextBot())) then
			self.traceData.endpos = v:NearestPoint(position) --v:WorldSpaceCenter() -- v:BodyTarget(position)
			// NearestPoint лучше всех определяет
			tr = util.TraceLine(self.traceData)

			// Взрыв может увидеть сущность
			if (tr.Fraction >= 0.75 or tr.Entity == v) then
				adjustedDamage = adjustedDamage - position:Distance(v:GetPos()) * falloff
				adjustedDamage = adjustedDamage * tr.Fraction

				if (adjustedDamage > 0.0) then
					info:SetDamage(adjustedDamage)

					v:TakeDamageInfo(info)
				end
			end
		end
	end

	info, tr = nil, nil
end
