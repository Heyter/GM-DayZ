function BUFF:OnRunOnce(client)
	local maxHP = client:GetMaxHealth()
	if (client:Health() >= maxHP) then return end
	
	self:Timer(client, 1, 0, function()
		if (IsValid(client)) then
			if (!client:Alive()) then
				self:TimerRemove(client)
				return
			end

			local newHealth = math.Approach(client:Health(), maxHP, 10)
			client:SetHealth(newHealth)

			if (newHealth >= maxHP) then
				self:TimerRemove(client)
			end
		end
	end)
end