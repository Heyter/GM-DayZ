att.PrintName = "Leupold"
att.Icon = Material("vgui/fas2atts/mk4")
att.Description = "Adjustable medium to long range optic, used on a variety of US military marksman and sniper rifles."

att.Desc_Pros = {
    "Precision sight picture",
    "8x magnification",
}
att.Desc_Cons = {
    "Large size",
    "Visible scope glint"
}

att.Slot = "fas2_leupold_scope"

att.Model = "models/weapons/fas2/attachments/leupold.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 7, -0.735),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 4,
        ZoomSound = "fas2/sks/sks_insertlast.wav",
    }
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 1

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/leupold")
att.HolosightNoFlare = true
att.HolosightSize = 17
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/leupold_hsp.mdl"

att.HolosightMagnification = 8
att.HolosightBlackbox = true

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"