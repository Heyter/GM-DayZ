function BUFF:OnRunOnce(client)
	local maxHP = client:GetMaxHealth()
	if (client:Health() >= maxHP) then return end

	local hp_diff = (maxHP - client:Health())
	local reps = math.max(1, math.floor(hp_diff / 10))
	local inc_hp = math.ceil(hp_diff / reps)

	self:Timer(client, 1, reps, function()
		if (IsValid(client)) then
			if (!client:Alive()) then
				self:TimerRemove(client)
				return
			end

			local newHealth = math.min(maxHP, client:Health() + inc_hp)
			client:SetHealth(newHealth)

			if (newHealth >= maxHP) then
				self:TimerRemove(client)
			end
		end
	end)
end