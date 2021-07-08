hook.Add("ScaleNPCDamage", "SB_AND_ScaleNPCDamage",function(ent, group, info)
	ent.LastHitGroup = group
end)

util.AddNetworkString("sb_anb_ragdoll")

g_SoundDurations = g_SoundDurations or {}