-- Не используется в ресурсах предмета.

BUFF.permanently = true
BUFF.isOnlyServer = true

if (SERVER) then
	function BUFF:OnRunOnce(client)
		local maxHP = client:GetMaxHealth()

		self:Timer(client, 2, 5, function()
			if (IsValid(client)) then
				if (!client:Alive()) then
					client:RemoveBuff(self.uniqueID, true)
					self:TimerRemove(client)
					return
				end

				local newHealth = math.min(maxHP, client:Health() + 10)
				client:SetHealth(newHealth)

				if (newHealth >= maxHP) then
					client:RemoveBuff(self.uniqueID, true)
					self:TimerRemove(client)
				else
					self:TimerAdjust(client, math.ceil(50 / math.random(10, 25)), nil, nil)
				end
			end
		end)
	end
end