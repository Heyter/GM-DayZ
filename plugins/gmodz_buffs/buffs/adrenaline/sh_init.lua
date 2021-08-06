--- plugins/enchanced_damage/sh_plugin.lua

BUFF.time = 60
BUFF.time_max = 360
BUFF.stamina_offset = 1.8

ix.util.Include("sv_init.lua", "server")

if (CLIENT) then
	function BUFF:RenderScreenspaceEffects()
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local value = math.max(0, (LocalPlayer():HasBuff(self.uniqueID).time - CurTime()) / (ix.buff.list[self.uniqueID].time / 2))

			if (value > 0) then
				DrawSharpen(math.min(1.5, value * 3), 1.1)
			end
		end
	end

	function BUFF:HUDExtraPaint(client, perc, hud, margin)
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local time = math.max(0, LocalPlayer():HasBuff(self.uniqueID).time - CurTime())

			perc.textColor = color_white
			perc.y = perc.y - perc.h - margin
			hud:drawText(perc, "ADRENALINE: " .. string.ToMinutesSeconds(time))
		end
	end
end

function BUFF:AdjustStaminaOffset(client, offset)
	if (client:HasBuff(self.uniqueID)) then
		return offset * self.stamina_offset
	end
end