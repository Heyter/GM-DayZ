att.PrintName = "SG551"
att.Icon = Material("")
att.Description = ""

att.Slot = "firearms2_sg551"

att.Model = "models/weapons/fas2/attachments/sg551_hsp.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.003, 3, 0.003),
        Ang = Angle(0, 0, 0),
        Magnification = 2.25,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 4,
        ZoomSound = "fas2/sr25/sr25_safety.wav",
    }
}

att.ScopeGlint = true

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/leupold")
att.HolosightNoFlare = true
att.HolosightSize = 12.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/sg551_hsp.mdl"

att.HolosightMagnification = 12
att.HolosightBlackbox = true