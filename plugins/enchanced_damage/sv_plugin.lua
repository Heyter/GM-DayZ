-- TODO: сделать сохранение кровотечение, перелома ног
-- timer.TimeLeft и timer.RepsLeft

function PLUGIN:GetFallDamage(client, speed)
	local damage = speed / 10

	if (damage > client:Health() / 2 and damage < client:Health()) then
		client:BreakLeg()
		client:EmitSound("Flesh.Break")

		if (math.random() >= 0.8) then -- почему бы и нет.
			client:SetBleeding(damage)
		end
	end

	return damage
end

function PLUGIN:OnCharacterDisconnect(client)
	client:HealLeg(true)
	client:HealBleeding()
end

function PLUGIN:PlayerDeath(client)
	client.healBody = true
end

function PLUGIN:PlayerSpawn(client)
	client.DeathMsg = nil

	if (client.healBody) then
		client:HealLeg()
		client:HealBleeding()

		client.healBody = nil
	end
end

function PLUGIN:EntityTakeDamage(victim, dmg_info)
	local damage = dmg_info:GetDamage()

	if (damage > 0 and IsValid(victim) and victim:IsPlayer()) then
		local attacker = dmg_info:GetAttacker()

		if (attacker:IsPlayer() and hook.Run("PlayerShouldTakeDamage", victim, attacker) == false) then
			return
		end

		local hit_group = victim:LastHitGroup()

		if (dmg_info:IsBulletDamage() or dmg_info:IsExplosionDamage()) then
			victim:SetBleeding(damage, nil, attacker)

			if ((hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) and damage > victim:Health() / 2 and damage < victim:Health()) then
				victim:BreakLeg()
			end
		end

		Schema:PlayerEmitPainSound(victim, hit_group)
	end
end

-- PLAYER META

local playerMeta = FindMetaTable("Player")

function playerMeta:BreakLeg(duration, bForce)
	if (!bForce and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end

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

function playerMeta:HealLeg(bSetOnlyTimer)
	timer.Remove("ixBreakLeg" .. self:EntIndex())

	if (!bSetOnlyTimer) then
		self:SetLocalVar("legBroken", nil)
		self:SetJumpPower(200)
	end
end

function playerMeta:SetBleeding(damage, bForce, inflictor)
	if (!damage) then return end
	if (!bForce and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end

	local max_health = self:GetMaxHealth()
	if (damage >= max_health or self:Health() - damage <= 0) then return end -- считай парень и так труп

	local amt_bleeding = self:GetNetVar("bleeding")
	if (amt_bleeding and amt_bleeding > damage) then return end -- не перезаписываем более лучшее кровотечение

	damage = damage / 0.8

	if (damage >= 15) then
		if (inflictor and inflictor != self) then
			self.bleeding_att = inflictor
		end

		local delay, repetitions, loss = 10, 0, 4
		local dmgPerc = math.max(0, (max_health - damage) / max_health)

		if (damage == 15 and math.random(1, 3) == 1) then -- легкий тип кровотечения (иллюзия нелинейности)
			repetitions = math.random(1, 7) -- т.к это легкий, то позволим ему самому вылечиться
		elseif (damage >= 50) then
			dmgPerc = dmgPerc * 0.8
			loss = loss + 1

			if (damage >= 65) then
				delay = delay - 1.5
			else
				delay = delay - 1
			end
		end

		delay = math.max(0.5, math.floor(delay * dmgPerc))
		loss = math.min(32, math.floor(loss / dmgPerc)) -- сколько хп отнимаем каждый круг

		self:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 128), 0.3, 0)
		self:SetNetVar("bleeding", damage)

		local uniqueID = "ixBleeding" .. self:EntIndex()

		timer.Create(uniqueID, delay, repetitions, function()
			if (IsValid(self)) then
				if (!self:Alive()) then
					timer.Remove(uniqueID)
					return
				elseif (timer.RepsLeft(uniqueID) == 0) then
					self:HealBleeding()
					return
				end

				local amt = math.max(0, self:Health() - loss)

				if (amt <= 0) then
					timer.Remove(uniqueID)
					self.DeathMsg = "bledout"
					self:Kill()
					return
				end

				self:SetHealth(amt)
			end
		end)
	end
end

function playerMeta:HealBleeding(amount)
	timer.Remove("ixBleeding" .. self:EntIndex())
	self:SetNetVar("bleeding", nil)

	self.bleeding_att = nil

	if (amount) then
		self:SetHealth(math.min(self:GetMaxHealth(), self:Health() + amount))
		self:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 128), 0.3, 0)
	end
end