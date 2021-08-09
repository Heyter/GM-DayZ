att.PrintName = "Canted Ironsights ''Tiss''"
att.Icon = Material("vgui/fas2atts/cantedironsight")
att.Description = "Canted Ironsights are available for weapons with attachment rails that allow a close-range option when a long-range optic is already mounted. The user simply rotates the weapon 45° to make use of the accessory, with minimal change in handling and performance."

att.Desc_Pros = {
    "Tririum ironsight",
    "The ability to switch from the telescopic sight to the side (Double E)"
}

att.ItemData = {
    width = 1,
    height = 1,
    price = 8000,
    rarity = { weight = 35 },
}


att.Slot = "fas2_cantedsight"

att.Model = "models/weapons/fas2/attachments/tiss.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.455, 9, -1.05),
        Ang = Angle(0, 0, -45),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = true
    }
}

att.KeepBaseIrons = true

att.Holosight = false

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"