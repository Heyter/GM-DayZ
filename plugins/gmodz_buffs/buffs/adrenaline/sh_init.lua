--- plugins/enchanced_damage/sh_plugin.lua

-- function BUFF:Move(client, mv)
	-- if (client:GetMoveType() != MOVETYPE_WALK) then return end

	-- if (client:HasBuff(self.uniqueID) and !client:IsBrokenLeg()) then
		-- local speed = mv:GetMaxSpeed() * 1.5
		-- mv:SetMaxSpeed(speed)
		-- mv:SetMaxClientSpeed(speed)
	-- end
-- end

ix.util.Include("sv_init.lua", "server")

if (CLIENT) then
	function BUFF:RenderScreenspaceEffects()
		if (LocalPlayer():HasBuff(self.uniqueID)) then
			local value = math.max(0, (LocalPlayer():HasBuff(self.uniqueID) - CurTime()) / (ix.buff.list[self.uniqueID].time / 2))

			if (value > 0) then
				DrawSharpen(math.min(2, value * 3), 1.2)
			end
		end
	end
end