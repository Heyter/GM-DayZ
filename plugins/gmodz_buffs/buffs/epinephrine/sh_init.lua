--- plugins/enchanced_damage/sh_plugin.lua

-- function BUFF:Move(client, mv)
	-- if (client:GetMoveType() != MOVETYPE_WALK) then return end

	-- if (client:HasBuff(self.uniqueID) and !client:IsBrokenLeg()) then
		-- local speed = mv:GetMaxSpeed() * 1.5
		-- mv:SetMaxSpeed(speed)
		-- mv:SetMaxClientSpeed(speed)
	-- end
-- end

BUFF.time = 15
BUFF.time_max = 90
BUFF.damageReduction = 0.1 -- 10% защита от урона.

if (CLIENT) then
	function BUFF:HUDExtraPaint(client, perc, hud, margin)
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local time = math.max(0, LocalPlayer():HasBuff(self.uniqueID) - CurTime())

			perc.textColor = color_white
			perc.y = perc.y - perc.h - margin
			hud:drawText(perc, "EPINEPHRINE: " .. string.ToMinutesSeconds(time))
		end
	end
end