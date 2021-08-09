att.PrintName = "AN/PEQ-2"
att.Icon = Material("vgui/fas2atts/anpeq2")
att.Description = "The AN/PEQ-2 Infrared Target Pointer/Illuminator/Aiming Light (ITPIAL) is a laser sight for use on rifles fitted with a Picatinny rail. It was manufactured by Insight Technology."

att.Desc_Pros = {
    "Accuracy of shooting from the hip"
}
att.Desc_Cons = {
    "Gives out your location"
}

att.Slot = "fas2_tactical"

att.ItemData = {
    width = 1,
    height = 1,
    price = 3000,
    rarity = { weight = 35 },
}

att.Model = "models/weapons/fas2/attachments/anpeq2.mdl"

att.Laser = true
att.LaserStrength = 1
att.LaserBone = "laser"
att.LaserColor = Color(255, 0, 0)

att.Mult_HipDispersion = 0.95

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"