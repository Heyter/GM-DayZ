att.PrintName = "AN/PEQ-15"
att.Icon = Material("vgui/fas2atts/anpeq15")
att.Description = "The AN/PEQ-15 Infrared Target Pointer/Illuminator/Aiming Light (ITPIAL) is a laser sight for use on rifles fitted with a Picatinny rail. It was manufactured by Insight Technology."

att.Desc_Pros = {
    "Accuracy of shooting from the hip"
}
att.Desc_Cons = {
    "Gives out your location"
}

att.Slot = "fas2_tactical"

att.Model = "models/weapons/fas2/attachments/anpeq15.mdl"

att.Laser = true
att.LaserStrength = 1
att.LaserBone = "laser"
att.LaserColor = Color(0, 255, 0)

att.Mult_HipDispersion = 0.95

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"