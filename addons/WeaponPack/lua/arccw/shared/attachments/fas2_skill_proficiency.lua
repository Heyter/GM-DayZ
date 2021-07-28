att.PrintName = "Proficiency"
att.Icon = Material("vgui/fas2atts/proficiency")
att.Description = "Improves reloading speed and weapon handling."

att.Desc_Pros = {
	"Faster reloads"
}

att.Slot = "fas2_nomen"

att.Override_FAS2NomenBackup = true

att.Hook_SelectReloadAnimation = function(wep, anim)
	local thething = wep.Animations["reload_nomen"] and "_nomen" or ""
	local empty = wep:Clip1() == 0 and "_empty" or ""

	if GetConVar("developer"):GetBool() and thething == "" then print(anim .. " NO NOMEN RELOAD!!! ARCCW FAS2") end

	return "reload" .. thething .. empty
end

att.AutoStats = true

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"