att.PrintName = "M249 200RND Box"
att.Icon = Material("vgui/fas2atts/200rnd")
att.Description = ""

att.AutoStats = true
att.Slot = "fas2_m249_200rnd"

att.MagExtender = true

att.Override_ClipSize = 200

att.ActivateElements = {"200mag"}

att.Hook_Compatible = function(wep)
    if (wep.RegularClipSize or wep.Primary.ClipSize) == wep.ExtendedClipSize then return false end
end