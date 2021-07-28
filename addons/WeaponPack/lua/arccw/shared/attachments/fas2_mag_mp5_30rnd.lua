att.PrintName = "MP5 30rnd Mag"
att.Icon = Material("vgui/fas2atts/mp5k30rnd")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_mp5_30rnd"

att.MagExtender = true

att.Override_ClipSize = 30

att.ActivateElements = {"30rnd"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end