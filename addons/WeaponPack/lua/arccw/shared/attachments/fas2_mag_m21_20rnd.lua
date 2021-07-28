att.PrintName = "M21 20rnd Mag"
att.Icon = Material("vgui/fas2atts/m2120rndmag")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_m21_20rnd"

att.MagExtender = true

att.Override_ClipSize = 20

att.ActivateElements = {"20rnd"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end