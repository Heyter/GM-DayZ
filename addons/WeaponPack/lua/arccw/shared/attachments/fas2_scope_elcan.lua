att.PrintName = "ELCAN C79"
att.Icon = Material("vgui/fas2atts/c79")
att.Description = "The C79 Optical sight is a small arms telescopic sight. It is 3.4×28, meaning 3.4x magnification, and a 28mm diameter objective lens. A tritium illuminated reticle provides for normal and low-light conditions sighting."

att.Desc_Pros = {
    "Precision sight picture",
    "3.4x magnification",
    "Designed for close combat (Double E)"
}
att.Desc_Cons = {
    "Large size",
    "Visible scope glint"
}

att.Slot = "fas2_scope"

att.Model = "models/weapons/fas2/attachments/elcan.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.01, 7, -1.21),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 2,
        ZoomSound = "fas2/sks/sks_insertlast.wav"
    },
    {
        Pos = Vector(-0.005, 5.8, -2.01),
        Ang = Angle(0, 0, 0),
        Magnification = 1.25,
        HolosightBone = "holosight",
        HolosightData = {
        Holosight = false,
        HolosightNoHSP = true,
        },
    },
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 0.5

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/elcan")
att.HolosightNoFlare = true
att.HolosightSize = 11.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/elcan_hsp.mdl"

att.HolosightMagnification = 3.4
att.HolosightBlackbox = true

att.HolosightMagnificationMin = 2
att.HolosightMagnificationMax = 3.4

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"