att.PrintName = "SKS 20rnd mag"
att.Icon = Material("vgui/fas2atts/sks20mag")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_sks_mags"

att.MagExtender = true

att.Override_ClipSize = 20

att.ActivateElements = {"20rnd"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end