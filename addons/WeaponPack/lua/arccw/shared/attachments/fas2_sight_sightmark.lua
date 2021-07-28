att.PrintName = "Sightmark SM13003B-DT"
att.Icon = Material("vgui/fas2atts/sightmark")
att.Description = "The Sightmark SM13003B-DT is a Red Dot Sight weapon sight developed by Sightmark for picatinny accessory rails."

att.Desc_Pros = {
    "Increasing aiming mobility",
    "Provides comfortable aiming reticle"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Doesn't support reticles switching"
}

att.Slot = "fas2_sight"

att.Model = "models/weapons/fas2/attachments/kobrards.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.007, 6.5, -0.92),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = true
    }
}

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/sights/cobrards")
att.HolosightNoFlare = true
att.HolosightSize = 1.5
att.HolosightBone = "holosight"
att.HolosightNoHSP = true

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"