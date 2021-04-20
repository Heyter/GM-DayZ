function PLUGIN:GetFallDamage(client, speed)
	local damage = speed / 10

	if (damage > client:Health() / 2 and damage < client:Health()) then
		client:BreakLeg(10) -- todo убрать 10
		client:EmitSound("Flesh.Break")
	end

	return damage
end

function PLUGIN:OnCharacterDisconnect(client)
	timer.Remove("ixBreakLeg" .. client:EntIndex())
end

function PLUGIN:PlayerDeath(client)
	client:HealLegs()
end

local dmg_types = {
	[] = true,
	[] = true
}

function PLUGIN:EntityTakeDamage(victim, dmg_info)
	local damage = dmg_info:GetDamage()

	if (damage > 0 and IsValid(victim) and victim:IsPlayer()) then
		local attacker = dmg_info:GetAttacker()
		if (attacker == victim) then return end

		if (dmg_types[dmg_info:GetDamageType()]) then
		
		end
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:BreakLeg(duration)
	duration = duration or 300

	self:SetLocalVar("legBroken", true)
	self:SetJumpPower(80)

	timer.Create("ixBreakLeg" .. self:EntIndex(), duration, 1, function()
		if (IsValid(self)) then
			self:SetLocalVar("legBroken", nil)
			self:SetJumpPower(200)
		end
	end)
end

function playerMeta:HealLeg()
	timer.Remove("ixBreakLeg" .. self:EntIndex())
	self:SetLocalVar("legBroken", nil)
	self:SetJumpPower(200)
end