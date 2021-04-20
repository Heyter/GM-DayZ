SH_SZ.OUTSIDE = 0
SH_SZ.ENTERING = 1
SH_SZ.PROTECTED = 2

function SH_SZ:GetSafeStatus(ply, sz)
	local i = ply:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE)

	if (SERVER) then
		return i
	else
		if (i == SH_SZ.ENTERING) then
			return "will_be_protected_in_x", math.max(math.ceil(sz.enter + sz.opts.ptime - CurTime()), 0)
		elseif (i == SH_SZ.PROTECTED) then
			return "safe_from_damage"
		else
			return ""
		end
	end
end