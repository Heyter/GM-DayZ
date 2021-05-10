-- TODO: сделать сохранение кровотечение, перелома ног
-- timer.TimeLeft и timer.RepsLeft

util.AddNetworkString("ixHitmarker")

function PLUGIN:GetFallDamage(client, speed)
	local damage = speed / 10

	if (damage > client:Health() / 2 and damage < client:Health()) then
		client:BreakLeg()
		client:EmitSound("Flesh.Break")

		if (math.random() >= 0.8) then
			--damage = damage / 0.8
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

-- Возможно стоит перекинуть на EntityTakeDamage т.к урон от взрыва не определяется (он по хитгруппе 0)
function PLUGIN:PlayerHurt(client, attacker, health, damage)
	if (damage > 0 and health > 0 and (attacker:IsPlayer() or attacker:IsNPC())) then
		if (attacker:IsPlayer() and hook.Run("PlayerShouldTakeDamage", client, attacker) == false) then return end

		local hit_group = client:LastHitGroup()
		if (hit_group == 0) then return end -- урон от кулаков, падения (свой хук)

		if ((client.ixNextHurt or 0) < CurTime()) then
			net.Start("ixHitmarker")
				net.WriteBool(hit_group == HITGROUP_HEAD)
			net.Send(client)

			client.ixNextHurt = CurTime() + 0.25
		end

		client:SetBleeding(damage, nil, attacker)

		if ((hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) and damage > client:Health() / 2 and damage < client:Health()) then
			client:BreakLeg()
		end
	end
end

function PLUGIN:GetPlayerDeathSound()
	return false
end

function PLUGIN:CharacterPreSave(character)
	local time = math.max(0, character:GetPlayer():GetLocalVar("legBroken", 0) - CurTime())

	if (time < 10) then
		time = nil
	end

	character:SetData("legBroken", time)
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

function playerMeta:SetBleeding(damage, bForce, inflictor)
	if (!damage) then return end
	if (!bForce and hook.Run("PlayerShouldTakeDamage", self, self) == false) then return end

	local max_health = self:GetMaxHealth()
	if (damage >= max_health or self:Health() - damage <= 0) then return end -- считай парень и так труп

	local amt_bleeding = self:GetNetVar("bleeding")
	if (amt_bleeding and amt_bleeding > damage) then return end -- не перезаписываем более лучшее кровотечение

	if (damage >= 15) then
		self:SetNetVar("bleeding", damage)

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

		self:ScreenFade(SCREENFADE.IN, Color("red", 128), 0.3, 0)

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
		self:ScreenFade(SCREENFADE.IN, Color("lime", 128), 0.3, 0)
	end
end