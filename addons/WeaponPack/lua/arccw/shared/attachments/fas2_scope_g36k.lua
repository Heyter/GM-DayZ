att.PrintName = "G36K"
att.Icon = Material("")
att.Description = ""

att.Slot = "firearms2_g36k"

att.Model = "models/weapons/fas2/attachments/g36k_hsp.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 2.4, 0),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ScrollFunc = ArcCW.NONE,
        ZoomSound = "fas2/sks/sks_insertlast.wav",
    }
}

att.ScopeGlint = true

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/g36k")
att.HolosightNoFlare = true
att.HolosightSize = 13.6
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/g36k_hsp.mdl"

att.HolosightMagnification = 4
att.HolosightBlackbox = true