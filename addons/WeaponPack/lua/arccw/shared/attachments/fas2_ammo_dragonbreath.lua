att.PrintName = "Dragon's Breath Ammo"
att.Icon = Material("vgui/fas2atts/incendiary")
att.Description = "Dragon's breath is a special type of incendiary-effect rounds for 12 gauge shotguns."

att.Desc_Pros = {
	"A 100% chance to set the enemy on fire"
}

att.AutoStats = true
att.Slot = "fas2_ammo_shotgun"

att.Mult_Damage = 0.6
att.Mult_DamageMin = 0.4
att.Mult_Penetration = 0.05
att.Mult_AccuracyMOA = 1.5
att.Mult_HipDispersion = 1

att.Override_DamageType = DMG_BURN

att.ActivateElements = {"incendiary"}

att.Override_Ammo = "12 Gauge Incendiary"

att.Override_ShellModel = "models/shells/12g_bucknball.mdl"