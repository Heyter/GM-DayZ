--- plugins\gmodz_buffs\sv_plugin.lua
-- Не используется в ресурсах предмета.

BUFF.time = 15
BUFF.time_max = 90
BUFF.damageReduction = 0.1 -- 10% защита от урона.

if (CLIENT) then
	function BUFF:HUDExtraPaint(client, perc, hud, margin)
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local time = math.max(0, LocalPlayer():HasBuff(self.uniqueID).time - CurTime())

			perc.textColor = color_white
			perc.y = perc.y - perc.h - margin
			hud:drawText(perc, "EPINEPHRINE: " .. string.ToMinutesSeconds(time))
		end
	end
end