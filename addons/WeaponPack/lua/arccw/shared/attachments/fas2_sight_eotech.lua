att.PrintName = "EoTech 553"
att.Icon = Material("vgui/fas2atts/eotech553")
att.Description = "The EoTech 553 is an American holographic sight specifically made for elite Army units, and the US Marine Corps. The soldiers chose EOTECH as the preffered close-quarter combat optic of choice."

att.Desc_Pros = {
    "Increasing aiming mobility",
    "Provides comfortable aiming reticle"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Doesn't support reticles switching"
}

att.Slot = "fas2_sight"

att.Model = "models/weapons/fas2/attachments/eotech.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.014, 6.5, -1.11),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = true
    }
}

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/sights/eotech")
att.HolosightNoFlare = true
att.HolosightSize = 1.5
att.HolosightBone = "holosight"
att.HolosightNoHSP = true

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"