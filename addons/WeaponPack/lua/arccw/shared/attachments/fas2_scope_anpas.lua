att.PrintName = "AN/PAS-29"
att.Icon = Material("vgui/fas2atts/anpas")
att.Description = "The AN/PAS-29 is a night vision scope developed by COTI. There are rumors that these scopes were purchased in a large batch by military organization ''Ignis''."

att.Desc_Pros = {
    "Precision sight picture",
    "4x magnification",
    "Can be switched ON or OFF (Double E)"
}
att.Desc_Cons = {
    "Narrow sighting area",
    "Visible scope glint"
}

att.Slot = "fas2_scope"

att.Model = "models/weapons/fas2/attachments/anpas.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.025, 7, -1.3085),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ScrollFunc = ArcCW.SCROLL_NONE,
        NVScope = true,
        NVScopeColor = Color(0, 255, 0),
        Contrast = 5,
        Brightness = 0,
        HolosightData = {
            Holosight = true,
			HolosightMagnification = 4,
			HolosightReticle = Material("sprites/fas2/scopes/anpas"),
            HolosightSize = 11,
            HolosightBlackbox = true,
            HolosightPiece = "models/weapons/fas2/attachments/anpas_hsp.mdl"
        },
    },
    {
        Pos = Vector(-0.025, 7, -1.3085),
        Ang = Angle(0, 0, 0),
        Magnification = 2,	
        HolosightData = {
            Holosight = true,
			HolosightMagnification = 4,
			HolosightReticle = Material("sprites/fas2/scopes/anpas"),
            HolosightSize = 11,
            HolosightBlackbox = true,
            HolosightPiece = "models/weapons/fas2/attachments/anpas_hsp.mdl"
        },
    },	
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 0.5

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/anpas")
att.HolosightNoFlare = true
att.HolosightSize = 11
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/anpas_hsp.mdl"

att.HolosightMagnification = 4
att.HolosightBlackbox = true

att.HolosightConstDist = 64

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"