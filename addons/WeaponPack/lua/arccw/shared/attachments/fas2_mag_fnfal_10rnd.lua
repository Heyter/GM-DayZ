att.PrintName = "FN Fal 10RND Magazine"
att.Icon = Material("vgui/fas2atts/fnfal10mag")
att.Description = "Extended magazine for FN Fal."

att.AutoStats = true
att.Slot = "fas2_fnfalmag"

att.MagExtender = true 

att.Override_ClipSize = 10

att.ActivateElements = {"mag"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end