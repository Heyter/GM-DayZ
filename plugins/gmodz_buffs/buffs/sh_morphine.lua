BUFF.time = 300
BUFF.time_max = 300

if (CLIENT) then
	function BUFF:HUDExtraPaint(client, perc, hud, margin)
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local time = math.max(0, LocalPlayer():HasBuff(self.uniqueID).time - CurTime())

			perc.textColor = color_white
			perc.y = perc.y - perc.h - margin
			hud:drawText(perc, "MORPHINE: " .. string.ToMinutesSeconds(time))
		end
	end
end