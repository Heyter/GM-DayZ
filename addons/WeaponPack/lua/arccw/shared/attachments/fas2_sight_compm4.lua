att.PrintName = "Aimpoint CompM4"
att.Icon = Material("vgui/fas2atts/compm4")
att.Description = "The Aimpoint CompM4 is a non-magnified red dot style gun sight adopted by the U.S. Armed Forces. It is produced by the Swedish company Aimpoint AB and is the successor to the earlier Aimpoint CompM2."

att.Desc_Pros = {
    "Slighty increasing aiming mobility",
    "Provides comfortable Red Dot reticle"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Doesn't support reticles switching"
}

att.Slot = "fas2_sight"

att.Model = "models/weapons/fas2/attachments/compm4.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.013, 6.5, -0.8),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = true
    }
}

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/sights/dot")
att.HolosightNoFlare = true
att.HolosightSize = 1.5
att.HolosightBone = "holosight"
att.HolosightNoHSP = true

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"