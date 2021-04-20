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
	client:HealLeg()
	client:HealBleeding()
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
			victim:SetBleeding(damage)

			if (damage > victim:Health() / 2 and damage < victim:Health() and (hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG)) then
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

function playerMeta:SetBleeding(damage, bForce)
	if (!damage) then return end
	if (!bForce and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end

	local max_health = self:GetMaxHealth()
	if (damage >= max_health or self:Health() - damage <= 0) then return end -- считай парень и так труп

	local amt_bleeding = self:GetNetVar("bleeding")
	if (amt_bleeding and amt_bleeding > damage) then return end -- не перезаписываем более лучшее кровотечение

	if (damage >= 15) then
		local delay, repetitions, loss = 10, 0, 4
		local dmgPerc = math.max(0, (max_health - damage) / max_health)

		if (damage == 15 and math.random(1, 3) == 1) then -- легкий тип кровотечения (иллюзия нелинейности)
			repetitions = math.random(1, 5) -- т.к это легкий, то позволим ему самому вылечиться
		end

		if (damage >= 65) then
			dmgPerc = dmgPerc * 0.85
		end

		delay = math.max(2, math.floor(delay * dmgPerc))
		loss = math.min(20, math.floor(loss / dmgPerc)) -- сколько хп отнимаем каждый круг

		self:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 128), 0.3, 0)
		self:SetNetVar("bleeding", damage)

		timer.Create("ixBleeding" .. self:EntIndex(), delay, repetitions, function()
			if (IsValid(self)) then
				local amt = math.max(0, self:Health() - loss)

				if (amt <= 0) then
					timer.Remove("ixBleeding" .. self:EntIndex()) -- по сути, это вызывается в HealBleeding
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

	if (amount) then
		self:SetHealth(math.min(self:GetMaxHealth(), self:Health() + amount))
		self:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 128), 0.3, 0)
	end
end