att.PrintName = "IRNV"
att.Icon = Material("vgui/fas2atts/irnv")
att.Description = "The IRNV is a scope with night vision, that highlights heat signatures as orange. This is useful for finding enemies at night, through foliage, in fog or rain, or when vision is otherwise hampered by inclement weather conditions."

att.Desc_Pros = {
    "Precision sight picture",
    "Provides thermal & night visions"
}
att.Desc_Cons = {
    "Doesn't provide magnification",
    "Narrow sighting area"
}

att.Slot = "fas2_scope1"

att.Model = "models/weapons/fas2/attachments/irnv.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.02, 6.2, -1.105),
        Ang = Angle(0, 0, 0),
        Magnification = 0,
        Thermal = true,
        ThermalScopeColor = Color(0, 255, 0),
        ThermalHighlightColor = Color(255, 255, 0),
        ThermalFullColor = false,
        ThermalScopeSimple = false,
        ThermalNoCC = false,
        ThermalBHOT = false,
        Contrast = 2,
    }
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 0.5

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/irnv")
att.HolosightNoFlare = true
att.HolosightSize = 11
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/irnv_hsp.mdl"

att.HolosightMagnification = 0
att.HolosightBlackbox = true

att.HolosightConstDist = 64

att.HolosightMagnificationMin = 1
att.HolosightMagnificationMax = 2

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"

--Временно не используется