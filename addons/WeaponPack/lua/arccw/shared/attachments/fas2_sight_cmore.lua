att.PrintName = "C-More Railway"
att.Icon = Material("vgui/fas2atts/cmore")
att.Description = "The C-More Railway is a Red Dot Sight weapon sight developed by C-More for picatinny accessory rails."

att.Desc_Pros = {
    "Increasing aiming mobility",
    "Provides comfortable aiming reticle"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Doesn't support reticles switching"
}

att.Slot = "fas2_sight"

att.Model = "models/weapons/fas2/attachments/cmore.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.006, 6.5, -0.95),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = true
    }
}

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/sights/cmore")
att.HolosightNoFlare = true
att.HolosightSize = 1.5
att.HolosightBone = "holosight"
att.HolosightNoHSP = true

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"

att.ActivateElements = {"mount"}