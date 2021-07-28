att.PrintName = "Acog"
att.Icon = Material("vgui/fas2atts/acog")
att.Description = "The ACOG is a series of prismatic telescopic sights manufactured by Trijicon. The ACOG was originally designed to be used on the M16 rifle and M4 carbine, but Trijicon has also developed ACOG accessories for other firearms. Models provide fixed-power magnification levels from 1.25× to 6×."

att.Desc_Pros = {
    "Precision sight picture",
    "4x magnification",
}
att.Desc_Cons = {
    "Narrow sighting area",
    "Visible scope glint"
}

att.Slot = "fas2_scope"

att.Model = "models/weapons/fas2/attachments/acog.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.009, 7.1, -1.064),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
    }
}

att.ScopeGlint = true

att.Mult_GlintMagnitude = 0.5

att.Holosight = true
att.HolosightReticle = Material("sprites/fas2/scopes/acog")
att.HolosightNoFlare = true
att.HolosightSize = 6.8
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/fas2/attachments/acog_hsp.mdl"

att.HolosightMagnification = 4
att.HolosightBlackbox = true

att.ActivateElements = {"mount"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"