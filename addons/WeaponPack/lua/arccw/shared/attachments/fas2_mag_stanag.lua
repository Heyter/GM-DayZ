att.PrintName = "Stanag Magazine"
att.Icon = Material("vgui/fas2atts/stanag")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_stanag"

att.MagReducer = true

att.Override_ClipSize = 30

att.ActivateElements = {"stanag"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end