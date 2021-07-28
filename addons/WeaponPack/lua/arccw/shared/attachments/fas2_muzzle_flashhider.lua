att.PrintName = "Flash Hider"
att.Icon = Material("vgui/fas2atts/flashhider.png")
att.Description = "A flash hider is a device attached to the muzzle of a rifle or other firearm that reduces the visible signature of the burning gases that exit the muzzle."

att.AutoStats = true
att.Slot = "fas2_muzzlebrake"

att.SortOrder = 10

att.Model = false

att.Override_MuzzleEffect = "muzzleflash_pistol_red"
att.FlashHider = true

att.Add_BarrelLength = 2

att.Mult_Recoil = 0.95
att.Mult_RecoilSide = 0.98
att.Mult_RecoilPunch = 0.95
att.Mult_Range = 0.98

att.ActivateElements = {"flashhider"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"

