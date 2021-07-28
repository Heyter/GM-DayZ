att.PrintName = "SKS 30rnd mag"
att.Icon = Material("vgui/fas2atts/stanag")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_vss_30rnd"

att.MagExtender = true

att.Override_ClipSize = 30

att.ActivateElements = {"30rnd"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end