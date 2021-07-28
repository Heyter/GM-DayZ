att.PrintName = "Muzzlebrake"
att.Icon = Material("vgui/fas2atts/muzzlebrake.png")
att.Description = "A muzzle brake is a device connected to the muzzle or barrel of a firearm that is intended to redirect a portion of propellant gases to counter recoil and unwanted muzzle rise."

att.AutoStats = true
att.Slot = "fas2_muzzlebrake"

att.SortOrder = 10

att.Model = false

att.Add_BarrelLength = 2

att.Mult_Recoil = 0.85
att.Mult_RecoilSide = 1.1
att.Mult_RecoilPunch = 0.8
att.Mult_Range = 0.92

att.ActivateElements = {"muzzlebrake"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"

