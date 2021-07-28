att.PrintName = "SR25 Suppressor"
att.Icon = Material("vgui/fas2atts/suppressor")
att.Description = "A suppressor is a muzzle device that reduces the acoustic intensity of the muzzle report and the recoil when a gun is discharged."

att.AutoStats = true
att.Slot = "fas2_muzzle_sr25"

att.SortOrder = 10

att.Model = false

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_Recoil = 0.9
att.Mult_RecoilSide = 0.9
att.Mult_RecoilPunch = 0.9
att.Mult_HipDispersion = 0.8
att.Mult_Range = 1.1

att.Mult_Damage = 0.95
att.Mult_DamageMin = 0.95

att.Add_BarrelLength = 8

att.ActivateElements = {"suppressorsr25"}

att.AttachSound = "fas2/cstm/attach.wav"
att.DetachSound = "fas2/cstm/detach.wav"