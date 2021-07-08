-- TODO: сделать сохранение кровотечение, перелома ног
-- timer.TimeLeft и timer.RepsLeft

util.AddNetworkString("ixHitmarker")

function PLUGIN:GetFallDamage(client, speed)
	--local damage = speed / 10
	if (speed < 660) then
		speed = speed - 250
	end

	local damage = 100 * ((speed) / 850) * 0.75

	if (damage > client:GetHealth() / 2 and damage < client:GetHealth()) then
		client:BreakLeg()
		client:EmitSound("Flesh.Break")

		if (math.random() >= 0.8) then
			client:SetBleeding(damage)
		end
	end

	return damage
end

function PLUGIN:OnCharacterDisconnect(client)
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

function PLUGIN:PostPlayerTakeDamage(client, damageInfo)
	local attacker = damageInfo:GetAttacker()

	if (IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC())) then
		local hit_group = client:LastHitGroup()

		if (hit_group != 0 or damageInfo:IsExplosionDamage()) then
			local damage = damageInfo:GetDamage()

			if (client:GetHealth() - damage <= 0) then
				return
			end

			if ((client.ixNextHurt or 0) < CurTime()) then
				net.Start("ixHitmarker")
					net.WriteBool(hit_group == HITGROUP_HEAD)
				net.Send(client)

				client.ixNextHurt = CurTime() + 0.25
			end

			client:SetBleeding(damage, nil, attacker)

			if ((hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) and damage > client:GetHealth() / 2 and damage < client:GetHealth()) then
				client:BreakLeg()
			end
		end
	end
end

function PLUGIN:GetPlayerDeathSound()
	return false
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	if (client.healBody and !client:Alive()) then return end

	local time = math.max(0, client:GetLocalVar("legBroken", 0) - CurTime())

	if (time < 10) then
		time = nil
	end

	character:SetData("legBroken", time, true)
end

function PLUGIN:OnCharacterDisconnect(client, character)
	if (!client:Alive()) then
		character:SetData("legBroken", nil, true)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	local time = character:GetData("legBroken")

	if (time) then
		client:BreakLeg(time, true)
	else
		client:HealLeg()
	end
end

-- PLAYER META

local playerMeta = FindMetaTable("Player")

function playerMeta:BreakLeg(duration, bForce)
	if (!bForce and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end

	self:SetLocalVar("legBroken", CurTime() + (duration or 300))
end

function playerMeta:HealLeg()
	self:SetLocalVar("legBroken", nil)
end

function ix.bleeding.Timer(client, level, isRise)
	local maxLevel = ix.bleeding.max_level
	level = math.min(maxLevel, level)

	if (isRise and level == maxLevel) then
		client.bleeding.riseTime = nil
		return
	end

	local timerID = "ixBleeding" .. client:EntIndex()
	local reps = level == 1 and math.random(5, 20) or 0
	local delay = math.Remap( level, maxLevel, 1, 0.5, 3.5 )

	client.bleeding = {
		loss = math.floor(math.Remap( level, 1, maxLevel, 1, 8 )), // сколько хп отнимаем каждый круг
		riseTime = level != 1 and CurTime() + 20 or nil // повышаем уровень кровотечения
	}

	client:SetNetVar("bleeding", level)

	if (isRise) then
		timer.Adjust(timerID, delay, reps)
		return
	else
		client:ScreenFade(SCREENFADE.IN, Color("red", 128), 0.3, 0)
	end

	timer.Create(timerID, delay, reps, function()
		if (IsValid(client)) then
			if (!client:Alive()) then
				timer.Remove(timerID)
				return
			elseif (timer.RepsLeft(timerID) == 0) then
				client:HealBleeding()
				return
			end

			local amt = client:GetHealth() - client.bleeding.loss
			if (amt <= 0) then
				timer.Remove(timerID)
				client:KillFeed("bledout")
				return
			end

			client:SetHealth(amt)
			if (client:GetLocalVar("extra_health")) then client:AddExtraHealth(-client.bleeding.loss) end

			if (client.bleeding.riseTime and client.bleeding.riseTime < CurTime()) then
				ix.bleeding.Timer(client, client:GetNetVar("bleeding", 1) + 1, true)
			end
		else
			timer.Remove(timerID)
		end
	end)
end

function playerMeta:SetBleeding(damage, bNotShouldTakeDamage, inflictor)
	if (damage or 0) <= 0 then return end
	if (!bNotShouldTakeDamage and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end
	if (damage >= self:GetMaxHealth() or self:GetHealth() - damage <= 0) then return end

	local bleeding = self:GetNetVar("bleeding")
	local level = math.floor(damage / ix.bleeding.min_damage)

	if (bleeding and bleeding > level) then return end -- не перезаписываем более лучшее кровотечение
	if (level >= 1) then
		if (inflictor and inflictor != self) then
			self.bleeding_att = inflictor
		end

		ix.bleeding.Timer(self, level)
	end
end

function playerMeta:HealBleeding(amount)
	timer.Remove("ixBleeding" .. self:EntIndex())
	self:SetNetVar("bleeding", nil)

	self.bleeding = nil
	self.bleeding_att = nil

	if (amount) then
		self:SetHealth(math.min(self:GetMaxHealth(), self:Health() + amount))
		self:ScreenFade(SCREENFADE.IN, Color("lime", 128), 0.3, 0)
	end
end