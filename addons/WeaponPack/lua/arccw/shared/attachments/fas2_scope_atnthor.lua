 att.PrintName = "ATNTHOR"
att.Icon = Material("vgui/fas2atts/atnthor")
att.Description = "The ATNTHOR is a thermal scope designed for picatinny accessory rails."

att.Desc_Pros = {
    "Precision sight picture",
    "Provides thermal visions"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Not comfortable to use",
    "Narrow sighting area",
    "Visible scope glint"
}

att.Slot = "fas2_scope"

att.Model = "models/weapons/fas2/attachments/atnthor.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.008, 6.42, -1.227),
        Ang = Angle(0, 0, 0),
        Magnification = 0,
        -- ScrollFunc = ArcCW.SCROLL_ZOOM,
        -- ZoomLevels = 6,
        -- ZoomSound = "fas2/sks/sks_insertlast.wav",
        Thermal = true,
        ThermalScopeColor = Color(255, 255, 255),
        ThermalHighlightColor = Color(255, 255, 255),
    }
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 0.5

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/m110")
att.HolosightNoFlare = true
att.HolosightSize = 8.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/atnthor_hsp.mdl"

att.HolosightMagnification = 0
att.HolosightBlackbox = true

att.HolosightConstDist = 64

att.HolosightMagnificationMin = 1
att.HolosightMagnificationMax = 2

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"