local ups = util.PrecacheSound

local sadd = sound.Add

local ARCCW_FAS_MS = {}

ArcCW.Firearms2_Casings_Rifle = {
	"fas2/casings/casings_rifle1.wav", 
	"fas2/casings/casings_rifle2.wav", 
	"fas2/casings/casings_rifle3.wav", 
	"fas2/casings/casings_rifle4.wav", 
	"fas2/casings/casings_rifle5.wav", 
	"fas2/casings/casings_rifle6.wav", 
	"fas2/casings/casings_rifle7.wav", 
	"fas2/casings/casings_rifle8.wav", 
	"fas2/casings/casings_rifle9.wav", 
	"fas2/casings/casings_rifle10.wav", 
	"fas2/casings/casings_rifle11.wav", 
	"fas2/casings/casings_rifle12.wav"
}

ArcCW.Firearms2_Casings_Pistol = {
	"fas2/casings/casings_pistol1.wav", 
	"fas2/casings/casings_pistol2.wav", 
	"fas2/casings/casings_pistol3.wav", 
	"fas2/casings/casings_pistol4.wav", 
	"fas2/casings/casings_pistol5.wav", 
	"fas2/casings/casings_pistol6.wav", 
	"fas2/casings/casings_pistol7.wav", 
	"fas2/casings/casings_pistol8.wav", 
	"fas2/casings/casings_pistol9.wav", 
	"fas2/casings/casings_pistol10.wav", 
	"fas2/casings/casings_pistol11.wav", 
	"fas2/casings/casings_pistol12.wav"
}
ArcCW.Firearms2_Casings_Heavy = {
	"fas2/casings/casings_50bmg1.wav", 
	"fas2/casings/casings_50bmg2.wav", 
	"fas2/casings/casings_50bmg3.wav", 
	"fas2/casings/casings_50bmg4.wav", 
	"fas2/casings/casings_50bmg5.wav", 
	"fas2/casings/casings_50bmg6.wav", 
	"fas2/casings/casings_50bmg7.wav", 
	"fas2/casings/casings_50bmg8.wav", 
	"fas2/casings/casings_50bmg9.wav", 
	"fas2/casings/casings_50bmg10.wav", 
	"fas2/casings/casings_50bmg11.wav", 
	"fas2/casings/casings_50bmg12.wav"
}
ArcCW.Firearms2_Casings_LinkM27 = {
	"fas2/casings/belt_links1.wav", 
	"fas2/casings/belt_links2.wav", 
	"fas2/casings/belt_links3.wav", 
	"fas2/casings/belt_links4.wav", 
	"fas2/casings/belt_links5.wav", 
	"fas2/casings/belt_links6.wav", 
	"fas2/casings/belt_links7.wav", 
	"fas2/casings/belt_links8.wav", 
	"fas2/casings/belt_links9.wav", 
	"fas2/casings/belt_links10.wav", 
	"fas2/casings/belt_links11.wav", 
	"fas2/casings/belt_links12.wav"
}

ArcCW.Firearms2_Casings_LiveRound = {
	"fas2/casings/bullet_full1.wav", 
	"fas2/casings/bullet_full2.wav", 
	"fas2/casings/bullet_full3.wav", 
	"fas2/casings/bullet_full4.wav", 
	"fas2/casings/bullet_full5.wav", 
	"fas2/casings/bullet_full6.wav", 
	"fas2/casings/bullet_full7.wav", 
	"fas2/casings/bullet_full8.wav", 
	"fas2/casings/bullet_full9.wav", 
	"fas2/casings/bullet_full10.wav", 
	"fas2/casings/bullet_full11.wav", 
	"fas2/casings/bullet_full12.wav"
}

ArcCW.Firearms2_Casings_SKSClip = {
	"fas2/casings/clip_sks1.wav", 
	"fas2/casings/clip_sks2.wav", 
	"fas2/casings/clip_sks3.wav", 
	"fas2/casings/clip_sks4.wav", 
	"fas2/casings/clip_sks5.wav", 
	"fas2/casings/clip_sks6.wav", 
	"fas2/casings/clip_sks7.wav", 
	"fas2/casings/clip_sks8.wav", 
	"fas2/casings/clip_sks9.wav", 
	"fas2/casings/clip_sks10.wav", 
	"fas2/casings/clip_sks11.wav", 
	"fas2/casings/clip_sks12.wav"
}

ArcCW.Firearms2_Casings_ShotgunShell = {
	"fas2/casings/shells_12g1.wav", 
	"fas2/casings/shells_12g2.wav", 
	"fas2/casings/shells_12g3.wav", 
	"fas2/casings/shells_12g4.wav", 
	"fas2/casings/shells_12g5.wav", 
	"fas2/casings/shells_12g6.wav", 
	"fas2/casings/shells_12g7.wav", 
	"fas2/casings/shells_12g8.wav", 
	"fas2/casings/shells_12g9.wav", 
	"fas2/casings/shells_12g10.wav", 
	"fas2/casings/shells_12g11.wav", 
	"fas2/casings/shells_12g12.wav"
}

--MISC
ARCCW_FAS_MS["Firearms2.Cloth_Movement"] = {"fas2/handling/generic_cloth_movement1.wav", "fas2/handling/generic_cloth_movement2.wav", "fas2/handling/generic_cloth_movement3.wav", "fas2/handling/generic_cloth_movement4.wav", "fas2/handling/generic_cloth_movement5.wav", "fas2/handling/generic_cloth_movement6.wav", "fas2/handling/generic_cloth_movement7.wav", "fas2/handling/generic_cloth_movement8.wav", "fas2/handling/generic_cloth_movement9.wav", "fas2/handling/generic_cloth_movement10.wav", "fas2/handling/generic_cloth_movement11.wav", "fas2/handling/generic_cloth_movement12.wav", "fas2/handling/generic_cloth_movement13.wav", "fas2/handling/generic_cloth_movement14.wav", "fas2/handling/generic_cloth_movement15.wav", "fas2/handling/generic_cloth_movement16.wav"}
ARCCW_FAS_MS["Firearms2.Cloth_Fast"] = {"fas2/handling/generic_cloth_fast1.wav", "fas2/handling/generic_cloth_fast2.wav"}
ARCCW_FAS_MS["Firearms2.Firemode_Switch"] = {"fas2/switch1.wav", "fas2/switch2.wav", "fas2/switch3.wav", "fas2/switch4.wav", "fas2/switch5.wav", "fas2/switch6.wav"}
-- ARCCW_FAS_MS["Firearms2.Magpouch"] = "fas2/handling/generic_magpouch1.wav"
ARCCW_FAS_MS["Firearms2.Magpouch_MachineGun"] = "fas2/handling/generic_magpouch_mg1.wav"
ARCCW_FAS_MS["Firearms2.Magpouch_Pistol"] = "fas2/handling/generic_magpouch_pistol1.wav"
ARCCW_FAS_MS["Firearms2.Magpouch_SMG"] = "fas2/handling/generic_magpouch_smg1.wav"
ARCCW_FAS_MS["Firearms2.Grip_Heavy"] = {"fas2/handling/generic_grip_heavy1.wav", "fas2/handling/generic_grip_heavy2.wav"}
ARCCW_FAS_MS["Firearms2.Deploy"] = {"fas2/weapon_deploy1.wav", "fas2/weapon_deploy2.wav", "fas2/weapon_deploy3.wav"}
ARCCW_FAS_MS["Firearms2.Holster"] = {"fas2/weapon_holster1.wav", "fas2/weapon_holster2.wav", "fas2/weapon_holster3.wav"}
ARCCW_FAS_MS["Firearms2.Bipod_Down"] = {"fas2/accessories/harrisbipod_down1.wav", "fas2/accessories/harrisbipod_down2.wav"}
ARCCW_FAS_MS["Firearms2.Bipod_Up"] = {"fas2/accessories/harrisbipod_up1.wav", "fas2/accessories/harrisbipod_up2.wav"}

--AK47
ARCCW_FAS_MS["Firearms2.AK47_BoltPull"] = "fas2/ak47/ak47_cock.wav"
ARCCW_FAS_MS["Firearms2.AK47_MagOutEmpty"] = "fas2/ak47/ak47_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.AK47_MagOutEmptyNomen"] = "fas2/ak47/ak47_magout_empty_nomen.wav"
ARCCW_FAS_MS["Firearms2.AK47_MagOut"] = "fas2/ak47/ak47_magout.wav"
ARCCW_FAS_MS["Firearms2.AK47_MagIn"] = "fas2/ak47/ak47_magin.wav"

--AK74
ARCCW_FAS_MS["Firearms2.AK74_BoltPull"] = "fas2/ak74/ak74_cock.wav"
ARCCW_FAS_MS["Firearms2.AK74_MagOutEmpty"] = "fas2/ak74/ak74_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.AK74_MagOutEmptyNomen"] = "fas2/ak74/ak74_magout_empty_nomen.wav"
ARCCW_FAS_MS["Firearms2.AK74_MagOut"] = "fas2/ak74/ak74_magout.wav"
ARCCW_FAS_MS["Firearms2.AK74_MagIn"] = "fas2/ak74/ak74_magin.wav"

--FAMAS F1
ARCCW_FAS_MS["Firearms2.FAMAS_BoltPull"] = "fas2/famas/famas_cock.wav"
ARCCW_FAS_MS["Firearms2.FAMAS_MagIn"] = "fas2/famas/famas_magin.wav"
ARCCW_FAS_MS["Firearms2.FAMAS_MagOut"] = "fas2/famas/famas_magout.wav"
ARCCW_FAS_MS["Firearms2.FAMAS_MagOutEmpty"] = "fas2/famas/famas_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.FAMAS_Selector"] = "fas2/famas/famas_selector.wav"
ARCCW_FAS_MS["Firearms2.FAMAS_SightFlip"] = "fas2/famas/famas_sight_flip.wav"

--G3A3
ARCCW_FAS_MS["Firearms2.G3_Handle"] = "fas2/g3a3/g3_handle.wav"
ARCCW_FAS_MS["Firearms2.G3_BoltBack"] = "fas2/g3a3/g3_boltback.wav"
ARCCW_FAS_MS["Firearms2.G3_BoltForward"] = "fas2/g3a3/g3_boltforward.wav"
ARCCW_FAS_MS["Firearms2.G3_BoltPullNomen"] = "fas2/g3a3/g3_boltpull_nomen.wav"
ARCCW_FAS_MS["Firearms2.G3_MagOutEmpty"] = "fas2/g3a3/g3_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.G3_MagOut"] = "fas2/g3a3/g3_magout.wav"
ARCCW_FAS_MS["Firearms2.G3_MagIn"] = "fas2/g3a3/g3_magin.wav"

--M4A1
ARCCW_FAS_MS["Firearms2.M4A1_StockPull"] = "fas2/m4a1/m4_stock.wav"
ARCCW_FAS_MS["Firearms2.M4A1_ChargeBack"] = "fas2/m4a1/m4_chargeback.wav"
ARCCW_FAS_MS["Firearms2.M4A1_ReleaseHandle"] = "fas2/m4a1/m4_releasehandle.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Check"] = "fas2/m4a1/m4_check.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Forwardassist"] = "fas2/m4a1/m4_forwardassist.wav"
ARCCW_FAS_MS["Firearms2.M4A1_DustCover"] = "fas2/m4a1/m4_dustcover.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Switch"] = "fas2/m4a1/m4_selector.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Magout"] = "fas2/m4a1/m4_magout.wav"
ARCCW_FAS_MS["Firearms2.M4A1_MagoutEmpty"] = "fas2/m4a1/m4_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Magin"] = "fas2/m4a1/m4_magin.wav"
ARCCW_FAS_MS["Firearms2.M4A1_Boltcatch"] = "fas2/m4a1/m4_boltcatch.wav"

--M16A2
ARCCW_FAS_MS["Firearms2.M16A2_MagHousing"] = "fas2/m16a2/m16a2_maghousing.wav"
ARCCW_FAS_MS["Firearms2.M16A2_ChargeBack"] = "fas2/m16a2/m16a2_chargeback.wav"
ARCCW_FAS_MS["Firearms2.M16A2_ReleaseHandle"] = "fas2/m16a2/m16a2_releasehandle.wav"
ARCCW_FAS_MS["Firearms2.M16A2_MagOut"] = "fas2/m16a2/m16a2_magout.wav"
ARCCW_FAS_MS["Firearms2.M16A2_MagIn"] = "fas2/m16a2/m16a2_magin.wav"
ARCCW_FAS_MS["Firearms2.M16A2_MagOutEmpty"] = "fas2/m16a2/m16a2_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.M16A2_BoltCatch"] = "fas2/m16a2/m16a2_boltcatch.wav"

--SAKORK95
ARCCW_FAS_MS["Firearms2.SAKO95_MagIn"] = "fas2/sako95/sako95_magin.wav"
ARCCW_FAS_MS["Firearms2.SAKO95_MagOut"] = "fas2/sako95/sako95_magout.wav"
ARCCW_FAS_MS["Firearms2.SAKO95_MagOutEmpty"] = "fas2/sako95/sako95_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.SAKO95_BoltBack"] = "fas2/sako95/sako95_boltback.wav"
ARCCW_FAS_MS["Firearms2.SAKO95_BoltForward"] = "fas2/sako95/sako95_boltforward.wav"

--SG550
ARCCW_FAS_MS["Firearms2.SG550_MagIn"] = "fas2/sg55x/sg550_magin.wav"
ARCCW_FAS_MS["Firearms2.SG550_BoltBack"] = "fas2/sg55x/sg550_boltback.wav"
ARCCW_FAS_MS["Firearms2.SG550_BoltForward"] = "fas2/sg55x/sg550_boltforward.wav"
ARCCW_FAS_MS["Firearms2.SG550_MagOut"] = "fas2/sg55x/sg550_magout.wav"
ARCCW_FAS_MS["Firearms2.SG550_MagOutEmpty"] = "fas2/sg55x/sg550_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.SG550_"] = ""

--G36C
ARCCW_FAS_MS["Firearms2.G36_BoltHandle"] = "fas2/g36c/g36c_handle.wav"
ARCCW_FAS_MS["Firearms2.G36_BoltBack"] = "fas2/g36c/g36c_boltback.wav"
ARCCW_FAS_MS["Firearms2.G36_BoltForward"] = "fas2/g36c/g36c_boltforward.wav"
ARCCW_FAS_MS["Firearms2.G36_Stock"] = "fas2/g36c/g36c_stock.wav"
ARCCW_FAS_MS["Firearms2.G36_MagOut"] = "fas2/g36c/g36c_magout.wav"
ARCCW_FAS_MS["Firearms2.G36_MagIn"] = "fas2/g36c/g36c_magin.wav"
ARCCW_FAS_MS["Firearms2.G36_MagOutEmpty"] = "fas2/g36c/g36c_magout_empty.wav"

ARCCW_FAS_MS["Firearms2.Deagle_MagOut"] = "fas2/deserteagle/de_magout.wav"
ARCCW_FAS_MS["Firearms2.Deagle_MagIn"] = "fas2/deserteagle/de_magin.wav"
ARCCW_FAS_MS["Firearms2.Deagle_MagOutEmpty"] = "fas2/deserteagle/de_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.Deagle_SlideStop"] = "fas2/deserteagle/de_sliderelease.wav"
ARCCW_FAS_MS["Firearms2.Deagle_MagInPartial"] = "fas2/deserteagle/de_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.Deagle_MagInNomen"] = "fas2/deserteagle/de_magin_nomen.wav"

--GLOCK20
ARCCW_FAS_MS["Firearms2.Glock20_MagOut"] = "fas2/glock20/glock20_magout.wav"
ARCCW_FAS_MS["Firearms2.Glock20_MagIn"] = "fas2/glock20/glock20_magin.wav"
ARCCW_FAS_MS["Firearms2.Glock20_MagOutEmpty"] = "fas2/glock20/glock20_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.Glock20_SlideForward"] = "fas2/glock20/glock20_sliderelease.wav"

--M1911
ARCCW_FAS_MS["Firearms2.M1911_MagOut"] = "fas2/1911/1911_magout.wav"
ARCCW_FAS_MS["Firearms2.M1911_MagInPartial"] = "fas2/1911/1911_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.M1911_MagIn"] = "fas2/1911/1911_magin.wav"
ARCCW_FAS_MS["Firearms2.M1911_MagOutEmpty"] = "fas2/1911/1911_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.M1911_SlideStop"] = "fas2/1911/1911_sliderelease.wav"

--P226
ARCCW_FAS_MS["Firearms2.P226_MagOut"] = "fas2/p226/p226_magout.wav"
ARCCW_FAS_MS["Firearms2.P226_MagInPartial"] = "fas2/p226/p226_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.P226_MagIn"] = "fas2/p226/p226_magin.wav"
ARCCW_FAS_MS["Firearms2.P226_MagOutEmpty"] = "fas2/p226/p226_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.P226_SlideBack"] = "fas2/p226/p226_slideback.wav"
ARCCW_FAS_MS["Firearms2.P226_SlideForward"] = "fas2/p226/p226_slideforward.wav"
ARCCW_FAS_MS["Firearms2.P226_SlideStop"] = "fas2/p226/p226_slidestop.wav"
ARCCW_FAS_MS["Firearms2.P226_SlidePull"] = "fas2/p226/p226_slidepull.wav"
ARCCW_FAS_MS["Firearms2.P226_SlideRelease"] = "fas2/p226/p226_sliderelease.wav"

--OTs-33
ARCCW_FAS_MS["Firearms2.OTs33_MagOut"] = "fas2/ots33/ots33_magout.wav"
ARCCW_FAS_MS["Firearms2.OTs33_MagInPartial"] = "fas2/ots33/ots33_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.OTs33_MagIn"] = "fas2/ots33/ots33_magin.wav"
ARCCW_FAS_MS["Firearms2.OTs33_MagOutEmpty"] = "fas2/ots33/ots33_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.OTs33_SlideRelease"] = "fas2/ots33/ots33_sliderelease.wav"
ARCCW_FAS_MS["Firearms2.OTs33_SlideBack"] = "fas2/ots33/ots33_slideback.wav"

--RAGING BULL
ARCCW_FAS_MS["Firearms2.RBULL_CylinderOpen"] = "fas2/ragingbull/ragingbull_open.wav"
ARCCW_FAS_MS["Firearms2.RBULL_Remove"] = {"fas2/ragingbull/ragingbull_remove1.wav", "fas2/ragingbull/ragingbull_remove2.wav", "fas2/ragingbull/ragingbull_remove3.wav", "fas2/ragingbull/ragingbull_remove4.wav", "fas2/ragingbull/ragingbull_remove5.wav"}
ARCCW_FAS_MS["Firearms2.RBULL_Insert"] = {"fas2/ragingbull/ragingbull_insert1.wav", "fas2/ragingbull/ragingbull_insert2.wav", "fas2/ragingbull/ragingbull_insert3.wav", "fas2/ragingbull/ragingbull_insert4.wav", "fas2/ragingbull/ragingbull_insert5.wav"}
ARCCW_FAS_MS["Firearms2.RBULL_CylinderClose"] = "fas2/ragingbull/ragingbull_close.wav"
ARCCW_FAS_MS["Firearms2.RBULL_Jiggle"] = {"fas2/ragingbull/ragingbull_jiggle1.wav", "fas2/ragingbull/ragingbull_jiggle2.wav", "fas2/ragingbull/ragingbull_jiggle3.wav", "fas2/ragingbull/ragingbull_jiggle4.wav"}
ARCCW_FAS_MS["Firearms2.RBULL_Extractor"] = "fas2/ragingbull/ragingbull_extractor.wav"

--M79
ARCCW_FAS_MS["Firearms2.M79_Open"] = "fas2/m79/m79_open.wav"
ARCCW_FAS_MS["Firearms2.M79_ShellOut"] = "fas2/m79/m79_remove.wav"
ARCCW_FAS_MS["Firearms2.M79_ShellIn"] = "fas2/m79/m79_insert.wav"
ARCCW_FAS_MS["Firearms2.M79_Close"] = "fas2/m79/m79_close.wav"

--M67
ARCCW_FAS_MS["Firearms2.M67_Safety"] = "fas2/m67/m67_safety.wav"
ARCCW_FAS_MS["Firearms2.M67_PinPull"] = "fas2/m67/m67_pinpull.wav"
ARCCW_FAS_MS["Firearms2.M67_Spoon"] = "fas2/m67/m67_spoon1.wav"
ARCCW_FAS_MS["Firearms2.M67_Primer"] = "fas2/m67/m67_primer.wav"

--MC51B VOLLMER
ARCCW_FAS_MS["Firearms2.Vollmer_stock"] = "fas2/vollmer/vollmer_stock.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_boltback"] = "fas2/vollmer/vollmer_boltback.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_open"] = "fas2/vollmer/vollmer_open.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_beltpull"] = "fas2/vollmer/vollmer_beltpull.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_beltload"] = "fas2/vollmer/vollmer_beltload.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_boltforward"] = "fas2/vollmer/vollmer_boltforward.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_StarterTab"] = "fas2/vollmer/vollmer_startertab.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_Belt"] = {"fas2/vollmer/vollmer_belt1.wav", "fas2/vollmer/vollmer_belt2.wav", "fas2/vollmer/vollmer_belt3.wav"}
ARCCW_FAS_MS["Firearms2.Vollmer_beltremove"] = "fas2/vollmer/vollmer_beltremove.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_boxout"] = "fas2/vollmer/vollmer_boxout.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_box"] = "fas2/vollmer/vollmer_box.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_rip"] = "fas2/vollmer/vollmer_rip.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_boxin"] = "fas2/vollmer/vollmer_boxin.wav"
ARCCW_FAS_MS["Firearms2.Vollmer_close"] = "fas2/vollmer/vollmer_close.wav"

--RPK47
ARCCW_FAS_MS["Firearms2.RPK47_MagInPartial"] = "fas2/rpk47/rpk47_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.RPK47_MagIn"] = "fas2/rpk47/rpk47_magin.wav"
ARCCW_FAS_MS["Firearms2.RPK47_BipodOpen"] = "fas2/rpk47/rpk47_bipod_open.wav"
ARCCW_FAS_MS["Firearms2.RPK47_BoltBack"] = "fas2/rpk47/rpk47_boltback.wav"
ARCCW_FAS_MS["Firearms2.RPK47_BoltForward"] = "fas2/rpk47/rpk47_boltforward.wav"
ARCCW_FAS_MS["Firearms2.RPK47_MagOut"] = "fas2/rpk47/rpk47_magout.wav"
ARCCW_FAS_MS["Firearms2.RPK47_MagOutEmpty"] = "fas2/rpk47/rpk47_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.RPK47_MagOutEmptyNomen"] = "fas2/rpk47/rpk47_magout_empty_nomen.wav"

--M60E3
ARCCW_FAS_MS["Firearms2.M60_carryinghandle"] = "fas2/m60/m60_carryinghandle.wav"
ARCCW_FAS_MS["Firearms2.M60_charge"] = "fas2/m60/m60_charge.wav"
ARCCW_FAS_MS["Firearms2.M60_open"] = "fas2/m60/m60_open.wav"
ARCCW_FAS_MS["Firearms2.M60_feeding_mechanism"] = "fas2/m60/m60_feeding_mechanism.wav"
ARCCW_FAS_MS["Firearms2.M60_feeding_tray"] = "fas2/m60/m60_feeding_tray.wav"
ARCCW_FAS_MS["Firearms2.M60_belt_insert"] = "fas2/m60/m60_belt_insert.wav"
ARCCW_FAS_MS["Firearms2.M60_belt"] = {"fas2/m60/m60_belt1.wav", "fas2/m60/m60_belt2.wav", "fas2/m60/m60_belt3.wav", "fas2/m60/m60_belt4.wav"}
ARCCW_FAS_MS["Firearms2.M60_close"] = "fas2/m60/m60_close.wav"
ARCCW_FAS_MS["Firearms2.M60_flipsights"] = "fas2/m60/m60_flipsights.wav"
ARCCW_FAS_MS["Firearms2.M60_bipod"] = "fas2/m60/m60_bipod.wav"
ARCCW_FAS_MS["Firearms2.M60_shoulderrest"] = "fas2/m60/m60_shoulderrest.wav"
ARCCW_FAS_MS["Firearms2.M60_startertab"] = "fas2/m60/m60_startertab.wav"
ARCCW_FAS_MS["Firearms2.M60_fire_empty"] = "fas2/m60/m60_fire_empty.wav"
ARCCW_FAS_MS["Firearms2.M60_belt_remove"] = "fas2/m60/m60_belt_remove.wav"
ARCCW_FAS_MS["Firearms2.M60_velcro_rip"] = {"fas2/m60/m60_velcro_rip1.wav", "fas2/m60/m60_velcro_rip2.wav"}
ARCCW_FAS_MS["Firearms2.M60_cardboard_remove_full"] = "fas2/m60/m60_cardboard_remove_full.wav"
ARCCW_FAS_MS["Firearms2.M60_cardboard_insert"] = "fas2/m60/m60_cardboard_insert.wav"
ARCCW_FAS_MS["Firearms2.M60_cardboard_rip"] = {"fas2/m60/m60_cardboard_rip1.wav", "fas2/m60/m60_cardboard_rip2.wav"}
ARCCW_FAS_MS["Firearms2.M60_velcro_close"] = "fas2/m60/m60_velcro_close.wav"
ARCCW_FAS_MS["Firearms2.M60_cardboard_remove"] = "fas2/m60/m60_cardboard_remove.wav"

--M249 & MINIMI
ARCCW_FAS_MS["Firearms2.M249_Lidopen"] = "fas2/m249/m249_lidopen.wav"
ARCCW_FAS_MS["Firearms2.M249_Lidclose"] = "fas2/m249/m249_lidclose.wav"
ARCCW_FAS_MS["Firearms2.M249_Beltremove"] = "fas2/m249/m249_beltremove.wav"
ARCCW_FAS_MS["Firearms2.M249_Boxremove"] = "fas2/m249/m249_boxremove.wav"
ARCCW_FAS_MS["Firearms2.M249_Boxinsert"] = "fas2/m249/m249_boxinsert.wav"
ARCCW_FAS_MS["Firearms2.M249_Beltpull"] = "fas2/m249/m249_beltpull.wav"
ARCCW_FAS_MS["Firearms2.M249_Beltload"] = "fas2/m249/m249_beltload.wav"
ARCCW_FAS_MS["Firearms2.M249_Charge"] = "fas2/m249/m249_charge.wav"
ARCCW_FAS_MS["Firearms2.M249_Belt3"] = "fas2/m249/m249_belt3.wav"
ARCCW_FAS_MS["Firearms2.M249_Belt4"] = "fas2/m249/m249_belt4.wav"
ARCCW_FAS_MS["Firearms2.M249_Belt5"] = "fas2/m249/m249_belt5.wav"
ARCCW_FAS_MS["Firearms2.M249_Belt6"] = "fas2/m249/m249_belt6.wav"
ARCCW_FAS_MS["Firearms2.M249_Butt"] = "fas2/m249/m249_belt1.wav"
ARCCW_FAS_MS["Firearms2.M249_Butt_Move"] = "fas2/m249/m249_belt2.wav"
ARCCW_FAS_MS["Firearms2.M249_FireEmpty"] = "fas2/m249/m249_fire_empty.wav"
ARCCW_FAS_MS["Firearms2.M249_Bipod"] = "fas2/m249/m249_bipod.wav"

--M14
ARCCW_FAS_MS["Firearms2.M14_Boltpull"] = "fas2/m14/m14_charge.wav"
ARCCW_FAS_MS["Firearms2.M14_BoltRelease"] = "fas2/m14/m14_boltrelease.wav"
ARCCW_FAS_MS["Firearms2.M14_Check"] = "fas2/m14/m14_check.wav"
ARCCW_FAS_MS["Firearms2.M14_Magout"] = "fas2/m14/m14_magout.wav"
ARCCW_FAS_MS["Firearms2.M14_MagoutEmpty"] = "fas2/m14/m14_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.M14_Magin"] = "fas2/m14/m14_magin.wav"

--SKS
ARCCW_FAS_MS["Firearms2.SKS_LatchOpen"] = "fas2/sks/sks_latchopen.wav"
ARCCW_FAS_MS["Firearms2.SKS_LatchClose"] = "fas2/sks/sks_latchclose.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltBack"] = "fas2/sks/sks_boltback.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltBackLock"] = "fas2/sks/sks_boltback_lock.wav"
ARCCW_FAS_MS["Firearms2.SKS_ClipIn"] = "fas2/sks/sks_clipin.wav"
ARCCW_FAS_MS["Firearms2.SKS_Insert1"] = "fas2/sks/sks_insert1.wav"
ARCCW_FAS_MS["Firearms2.SKS_Insert2"] = "fas2/sks/sks_insert2.wav"
ARCCW_FAS_MS["Firearms2.SKS_InsertLast"] = "fas2/sks/sks_insertlast.wav"
ARCCW_FAS_MS["Firearms2.SKS_RemoveClip"] = "fas2/sks/sks_removeclip.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltRelease"] = "fas2/sks/sks_boltrelease.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltForward"] = "fas2/sks/sks_boltforward.wav"
ARCCW_FAS_MS["Firearms2.SKS_MagOut"] = "fas2/sks/sks_magout.wav"
ARCCW_FAS_MS["Firearms2.SKS_MagOutEmpty"] = "fas2/sks/sks_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.SKS_MagIn"] = "fas2/sks/sks_magin.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltBackHalfA"] = "fas2/sks/sks_boltback_half_a.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltBackHalfB"] = "fas2/sks/sks_boltback_half_b.wav"
ARCCW_FAS_MS["Firearms2.SKS_BoltForwardHalf"] = "fas2/sks/sks_boltforward_half.wav"
ARCCW_FAS_MS["Firearms2.SKS_InsertNomen"] = "fas2/sks/sks_insert_nomen.wav"

--KS23
ARCCW_FAS_MS["Firearms2.KS23_PumpBack"] = "fas2/ks23/ks23_pump_back.wav"
ARCCW_FAS_MS["Firearms2.KS23_PumpForward"] = "fas2/ks23/ks23_pump_forward.wav"
ARCCW_FAS_MS["Firearms2.KS23_InsertPort"] = "fas2/ks23/ks23_insert_port.wav"
ARCCW_FAS_MS["Firearms2.KS23_Insert"] = {"fas2/ks23/ks23_insert1.wav", "fas2/ks23/ks23_insert2.wav", "fas2/ks23/ks23_insert3.wav"}

--M3S90
ARCCW_FAS_MS["Firearms2.M3S90_LoadEjectorPort"] = "fas2/m3s90p/m3s90_load_ejectorport.wav"
ARCCW_FAS_MS["Firearms2.M3S90_Boltcatch"] = "fas2/m3s90p/m3s90_boltcatch.wav"
ARCCW_FAS_MS["Firearms2.M3S90_GetAmmo"] = {"fas2/m3s90p/m3s90_getammo1.wav", "fas2/m3s90p/m3s90_getammo2.wav", "fas2/m3s90p/m3s90_getammo3.wav"}
ARCCW_FAS_MS["Firearms2.M3S90_Load"] = {"fas2/m3s90p/m3s90_load1.wav", "fas2/m3s90p/m3s90_load2.wav", "fas2/m3s90p/m3s90_load3.wav", "fas2/m3s90p/m3s90_load4.wav", "fas2/m3s90p/m3s90_load5.wav", "fas2/m3s90p/m3s90_load6.wav", "fas2/m3s90p/m3s90_load7.wav", "fas2/m3s90p/m3s90_load8.wav"}

--REM870
ARCCW_FAS_MS["Firearms2.REM870_PumpBack"] = {"fas2/rem870/rem870_pump_back.wav", "fas2/rem870/rem870_pump_back1.wav", "fas2/rem870/rem870_pump_back2.wav"}
ARCCW_FAS_MS["Firearms2.REM870_PumpForward"] = {"fas2/rem870/rem870_pump_forward.wav", "fas2/rem870/rem870_pump_forward1.wav", "fas2/rem870/rem870_pump_forward2.wav"}
ARCCW_FAS_MS["Firearms2.REM870_Insert"] = {"fas2/rem870/rem870_insert1.wav", "fas2/rem870/rem870_insert2.wav", "fas2/rem870/rem870_insert3.wav"}

--PP19 BIZON
ARCCW_FAS_MS["Firearms2.PP19_MagOut"] = "fas2/bizon/bizon_magout.wav"
ARCCW_FAS_MS["Firearms2.PP19_MagLatch"] = "fas2/bizon/bizon_maglatch.wav"
ARCCW_FAS_MS["Firearms2.PP19_MagIn"] = "fas2/bizon/bizon_magin.wav"
ARCCW_FAS_MS["Firearms2.PP19_MagOutEmpty"] = "fas2/bizon/bizon_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.PP19_BoltPull"] = "fas2/bizon/bizon_boltpull.wav"

--MP5 SERIES
ARCCW_FAS_MS["Firearms2.MP5_SelectorSwitch"] = "fas2/mp5/mp5_selectorswitch.wav"
ARCCW_FAS_MS["Firearms2.MP5_BoltBack"] = "fas2/mp5/mp5_boltback.wav"
ARCCW_FAS_MS["Firearms2.MP5_MagIn"] = "fas2/mp5/mp5_magin.wav"
ARCCW_FAS_MS["Firearms2.MP5_BoltForward"] = "fas2/mp5/mp5_boltforward.wav"
ARCCW_FAS_MS["Firearms2.MP5_Stock"] = "fas2/mp5/mp5_stock.wav"
ARCCW_FAS_MS["Firearms2.MP5_MagOut"] = "fas2/mp5/mp5_magout.wav"
ARCCW_FAS_MS["Firearms2.MP5_MagOutEmpty"] = "fas2/mp5/mp5_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.MP5_BoltPull"] = "fas2/mp5/mp5_boltpull.wav"
ARCCW_FAS_MS["Firearms2.MP5K_BoltBack"] = "fas2/mp5/mp5k_boltback.wav"
ARCCW_FAS_MS["Firearms2.MP5K_BoltForward"] = "fas2/mp5/mp5k_boltforward.wav"
ARCCW_FAS_MS["Firearms2.MP5_BoltCatch"] = "fas2/mp5/mp5_boltcatch.wav"

--MAC11
ARCCW_FAS_MS["Firearms2.MAC11_BoltForward"] = "fas2/mac11/mac11_boltforward.wav"
ARCCW_FAS_MS["Firearms2.MAC11_MagOut"] = "fas2/mac11/mac11_magout.wav"
ARCCW_FAS_MS["Firearms2.MAC11_MagIn"] = "fas2/mac11/mac11_magin.wav"
ARCCW_FAS_MS["Firearms2.MAC11_MagOutEmpty"] = "fas2/mac11/mac11_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.MAC11_BoltBack"] = "fas2/mac11/mac11_boltback.wav"

--UZI
ARCCW_FAS_MS["Firearms2.UZI_StockUnfold"] = "fas2/uzi/uzi_stockunfold.wav"
ARCCW_FAS_MS["Firearms2.UZI_MagRelease"] = "fas2/uzi/uzi_magrelease.wav"
ARCCW_FAS_MS["Firearms2.UZI_MagOut"] = "fas2/uzi/uzi_magout.wav"
ARCCW_FAS_MS["Firearms2.UZI_MagInPartial"] = "fas2/uzi/uzi_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.UZI_MagIn"] = "fas2/uzi/uzi_magin.wav"
ARCCW_FAS_MS["Firearms2.UZI_BoltBack"] = "fas2/uzi/uzi_boltback.wav"
ARCCW_FAS_MS["Firearms2.UZI_BoltForward"] = "fas2/uzi/uzi_boltforward.wav"
ARCCW_FAS_MS["Firearms2.UZI_MagOutEmpty"] = "fas2/uzi/uzi_magout_empty.wav"

--STERLING SERIES
ARCCW_FAS_MS["Firearms2.STERLING_Boltback"] = "fas2/sterling/sterling_boltback.wav"
ARCCW_FAS_MS["Firearms2.STERLING_Boltforward"] = "fas2/sterling/sterling_boltforward.wav"
ARCCW_FAS_MS["Firearms2.STERLING_StockUnfold"] = "fas2/sterling/sterling_stockunfold.wav"
ARCCW_FAS_MS["Firearms2.STERLING_MagOut"] = "fas2/sterling/sterling_magout.wav"
ARCCW_FAS_MS["Firearms2.STERLING_MagInPartial"] = "fas2/sterling/sterling_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.STERLING_MagIn"] = "fas2/sterling/sterling_magin.wav"
ARCCW_FAS_MS["Firearms2.STERLING_MagOutEmpty"] = "fas2/sterling/sterling_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.STERLING_MagRelease"] = "fas2/sterling/sterling_magrelease.wav"

--STERLING MK7A4
ARCCW_FAS_MS["Firearms2.MK7A4_MagOut"] = "fas2/sterling_mk7a4/mk7a4_magout.wav"
ARCCW_FAS_MS["Firearms2.MK7A4_MagIn"] = "fas2/sterling_mk7a4/mk7a4_magin.wav"
ARCCW_FAS_MS["Firearms2.MK7A4_MagOutEmpty"] = "fas2/sterling_mk7a4/mk7a4_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.MK7A4_MagSlap"] = "fas2/sterling_mk7a4/mk7a4_magslap.wav"

--M21
ARCCW_FAS_MS["Firearms2.M21_Magout"] = "fas2/m21/m21_magout.wav"
ARCCW_FAS_MS["Firearms2.M21_Magin"] = "fas2/m21/m21_magin.wav"
ARCCW_FAS_MS["Firearms2.M21_MagoutEmpty"] = "fas2/m21/m21_magout_empty.wav"

--M24
ARCCW_FAS_MS["Firearms2.M24_Butt"] = "fas2/m24/m24_butt.wav"
ARCCW_FAS_MS["Firearms2.M24_Safety"] = "fas2/m24/m24_safety.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltup_Nomen"] = "fas2/m24/m24_boltup_nomen.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltback_Nomen"] = "fas2/m24/m24_boltback_nomen.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltforward_Nomen"] = "fas2/m24/m24_boltforward_nomen.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltdown_Nomen"] = "fas2/m24/m24_boltdown_nomen.wav"
ARCCW_FAS_MS["Firearms2.M24_Back"] = "fas2/m24/m24_back.wav"
ARCCW_FAS_MS["Firearms2.M24_Forward"] = "fas2/m24/m24_forward.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltup"] = "fas2/m24/m24_boltup.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltback"] = "fas2/m24/m24_boltback.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltforward"] = "fas2/m24/m24_boltforward.wav"
ARCCW_FAS_MS["Firearms2.M24_Boltdown"] = "fas2/m24/m24_boltdown.wav"
ARCCW_FAS_MS["Firearms2.M24_Eject"] = "fas2/m24/m24_eject.wav"
ARCCW_FAS_MS["Firearms2.M24_Insert"] = {"fas2/m24/m24_insert1.wav", "fas2/m24/m24_insert2.wav", "fas2/m24/m24_insert3.wav", "fas2/m24/m24_insert4.wav", "fas2/m24/m24_insert5.wav"}

--SR25
ARCCW_FAS_MS["Firearms2.SR25_StockUnlock"] = "fas2/sr25/sr25_stockunlock.wav"
ARCCW_FAS_MS["Firearms2.SR25_StockPull"] = "fas2/sr25/sr25_stockpull.wav"
ARCCW_FAS_MS["Firearms2.SR25_StockLock"] = "fas2/sr25/sr25_stocklock.wav"
ARCCW_FAS_MS["Firearms2.SR25_ChargingHandleBack"] = "fas2/sr25/sr25_charginghandle_back.wav"
ARCCW_FAS_MS["Firearms2.SR25_ChargingHandleForward"] = "fas2/sr25/sr25_charginghandle_forward.wav"
ARCCW_FAS_MS["Firearms2.SR25_SupressorOn"] = "fas2/sr25/sr25_supressoron.wav"
ARCCW_FAS_MS["Firearms2.SR25_SupressorLock"] = "fas2/sr25/sr25_supressorlock.wav"
ARCCW_FAS_MS["Firearms2.SR25_Safety"] = "fas2/sr25/sr25_safety.wav"
ARCCW_FAS_MS["Firearms2.SR25_Magout"] = "fas2/sr25/sr25_magout.wav"
ARCCW_FAS_MS["Firearms2.SR25_Magin"] = "fas2/sr25/sr25_magin.wav"
ARCCW_FAS_MS["Firearms2.SR25_Magslap"] = "fas2/sr25/sr25_magslap.wav"
ARCCW_FAS_MS["Firearms2.SR25_MagoutEmpty"] = "fas2/sr25/sr25_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.SR25_BoltcatchSlap"] = "fas2/sr25/sr25_boltcatchslap.wav"
ARCCW_FAS_MS["Firearms2.SR25_Boltcatch"] = "fas2/sr25/sr25_boltcatch.wav"

--SVD
ARCCW_FAS_MS["Firearms2.SVD_BoltBack"] = "fas2/svd/svd_boltback.wav"
ARCCW_FAS_MS["Firearms2.SVD_BoltForward"] = "fas2/svd/svd_boltforward.wav"
ARCCW_FAS_MS["Firearms2.SVD_MagOut"] = "fas2/svd/svd_magout.wav"
ARCCW_FAS_MS["Firearms2.SVD_MagInPartial"] = "fas2/svd/svd_magin_partial.wav"
ARCCW_FAS_MS["Firearms2.SVD_MagIn"] = "fas2/svd/svd_magin.wav"
ARCCW_FAS_MS["Firearms2.SVD_MagoutEmpty"] = "fas2/svd/svd_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.SVD_MagInNomen"] = "fas2/svd/svd_magin_nomen.wav"

--M82
ARCCW_FAS_MS["Firearms2.M82_MagRelease"] = "fas2/m82/m82_magrelease.wav"
ARCCW_FAS_MS["Firearms2.M82_MagOut"] = "fas2/m82/m82_magout.wav"
ARCCW_FAS_MS["Firearms2.M82_MagIn"] = "fas2/m82/m82_magin.wav"
ARCCW_FAS_MS["Firearms2.M82_MagOutEmpty"] = "fas2/m82/m82_magout_empty.wav"
ARCCW_FAS_MS["Firearms2.M82_BoltBack"] = "fas2/m82/m82_boltback.wav"
ARCCW_FAS_MS["Firearms2.M82_BoltForward"] = "fas2/m82/m82_boltforward.wav"

--NEW

--AUG
ARCCW_FAS_MS["Firearms2.AUG_BoltBack"] = "fas2/aug/aug_boltback.wav"
ARCCW_FAS_MS["Firearms2.AUG_BoltForward"] = "fas2/aug/aug_boltforward.wav"
ARCCW_FAS_MS["Firearms2.AUG_MagIn"] = "fas2/aug/aug_magin.wav"
ARCCW_FAS_MS["Firearms2.AUG_MagOut"] = "fas2/aug/aug_magout.wav"

--TOZ34
ARCCW_FAS_MS["Firearms2.TOZ34_OpenStart"] = "fas2/toz34/toz34_open_start.wav"
ARCCW_FAS_MS["Firearms2.TOZ34_Close"] = "fas2/toz34/toz34_close.wav"
ARCCW_FAS_MS["Firearms2.TOZ34_OpenFinish"] = "fas2/toz34/toz34_open_finish.wav"
ARCCW_FAS_MS["Firearms2.TOZ34_ShellIn"] = {"fas2/toz34/toz34_shell_in1.wav", "fas2/toz34/toz34_shell_in2.wav"}
ARCCW_FAS_MS["Firearms2.TOZ34_HammerPull"] = "fas2/toz34/toz34_pull_hammer.wav"

--PM
ARCCW_FAS_MS["Firearms2.PM_MagIn"] = "fas2/pm/pm_magin.wav"
ARCCW_FAS_MS["Firearms2.PM_MagOut"] = "fas2/pm/pm_magout.wav"
ARCCW_FAS_MS["Firearms2.PM_SlideForward"] = "fas2/pm/pm_slideforward.wav"

--PMM
ARCCW_FAS_MS["Firearms2.PMM_MagIn"] = "fas2/pmm/pmm_magin.wav"
ARCCW_FAS_MS["Firearms2.PMM_MagOut"] = "fas2/pmm/pmm_magout.wav"
ARCCW_FAS_MS["Firearms2.PMM_MagHit"] = "fas2/pmm/pmm_maghit.wav"
ARCCW_FAS_MS["Firearms2.PMM_BoltRelease"] = "fas2/pmm/pmm_boltrelease.wav"

--AK101
ARCCW_FAS_MS["Firearms2.AK101_MagIn"] = "fas2/ak101/ak101_magin.wav"
ARCCW_FAS_MS["Firearms2.AK101_MagOut"] = "fas2/ak101/ak101_magout.wav"
ARCCW_FAS_MS["Firearms2.AK101_BoltPull"] = "fas2/ak101/ak101_cock.wav"

--ASH12
ARCCW_FAS_MS["Firearms2.ASH12_Cloth2"] = "fas2/ash12/ash12_cloth2.wav"
ARCCW_FAS_MS["Firearms2.ASH12_BoltBack"] = "fas2/ash12/ash12_boltback.wav"
ARCCW_FAS_MS["Firearms2.ASH12_MagOut"] = "fas2/ash12/ash12_magout.wav"
ARCCW_FAS_MS["Firearms2.ASH12_Cloth"] = "fas2/ash12/ash12_cloth.wav"
ARCCW_FAS_MS["Firearms2.ASH12_MagIn"] = "fas2/ash12/ash12_magin.wav"
ARCCW_FAS_MS["Firearms2.ASH12_BoltForward"] = "fas2/ash12/ash12_boltforward.wav"

--G36K
ARCCW_FAS_MS["Firearms2.G36K_MagOut"] = "fas2/g36k/g36k_magout.wav"
ARCCW_FAS_MS["Firearms2.G36K_MagIn"] = "fas2/g36k/g36k_magin.wav"
ARCCW_FAS_MS["Firearms2.G36K_BoltHandle"] = "fas2/g36k/g36k_handle.wav"
ARCCW_FAS_MS["Firearms2.G36K_BoltForward"] = "fas2/g36k/g36k_boltforward.wav"
ARCCW_FAS_MS["Firearms2.G36K_BoltBack"] = "fas2/g36k/g36k_boltback.wav"

--L85
ARCCW_FAS_MS["Firearms2.L85_MagOut"] = "fas2/l85/l85_magout.wav"
ARCCW_FAS_MS["Firearms2.L85_MagIn"] = "fas2/l85/l85_magin.wav"
ARCCW_FAS_MS["Firearms2.L85_BoltBack"] = "fas2/l85/l85_boltback.wav"
ARCCW_FAS_MS["Firearms2.L85_BoltForward"] = "fas2/l85/l85_boltforward.wav"

--MP153
ARCCW_FAS_MS["Firearms2.MP153_BoltBack"] = "fas2/mp153/mp153_boltback.wav"
ARCCW_FAS_MS["Firearms2.MP153_BoltForward"] = "fas2/mp153/mp153_boltforward.wav"
ARCCW_FAS_MS["Firearms2.MP153_Start"] = "fas2/mp153/mp153_start.wav"
ARCCW_FAS_MS["Firearms2.MP153_Insert"] = {"fas2/mp153/mp153_insert1.wav", "fas2/mp153/mp153_insert2.wav", "fas2/mp153/mp153_insert3.wav"}
ARCCW_FAS_MS["Firearms2.MP153_End"] = "fas2/mp153/mp153_end.wav"

--SAIGA12K
ARCCW_FAS_MS["Firearms2.SAIGA12K_MagOut"] = "fas2/saiga12k/saiga12k_magout.wav"
ARCCW_FAS_MS["Firearms2.SAIGA12K_MagIn"] = "fas2/saiga12k/saiga12k_magin.wav"
ARCCW_FAS_MS["Firearms2.SAIGA12K_BoltPull"] = "fas2/saiga12k/saiga12k_cock.wav"

--P90
ARCCW_FAS_MS["Firearms2.P90_MagOut"] = "fas2/p90/p90_magout.wav"
ARCCW_FAS_MS["Firearms2.P90_MagIn"] = "fas2/p90/p90_magin.wav"
ARCCW_FAS_MS["Firearms2.P90_MagHit"] = "fas2/p90/p90_maghit.wav"
ARCCW_FAS_MS["Firearms2.P90_MagDraw"] = "fas2/p90/p90_magdraw.wav"
ARCCW_FAS_MS["Firearms2.P90_BoltBack"] = "fas2/p90/p90_boltback.wav"
ARCCW_FAS_MS["Firearms2.P90_BoltForward"] = "fas2/p90/p90_boltforward.wav"

--UMP45
ARCCW_FAS_MS["Firearms2.UMP45_MagOut"] = "fas2/ump45/ump45_magout.wav"
ARCCW_FAS_MS["Firearms2.UMP45_MagIn"] = "fas2/ump45/ump45_magin.wav"
ARCCW_FAS_MS["Firearms2.UMP45_Cloth"] = "fas2/ump45/ump45_cloth.wav"
ARCCW_FAS_MS["Firearms2.UMP45_BoltBack"] = "fas2/ump45/ump45_boltback.wav"
ARCCW_FAS_MS["Firearms2.UMP45_BoltForward"] = "fas2/ump45/ump45_boltforward.wav"

--FNFAL
ARCCW_FAS_MS["Firearms2.FNFAL_MagOut"] = "fas2/fnfal/fnfal_magout.wav"
ARCCW_FAS_MS["Firearms2.FNFAL_MagIn"] = "fas2/fnfal/fnfal_magin.wav"
ARCCW_FAS_MS["Firearms2.FNFAL_BoltBack"] = "fas2/fnfal/fnfal_boltback.wav"
ARCCW_FAS_MS["Firearms2.FNFAL_BoltRelease"] = "fas2/fnfal/fnfal_boltrelease.wav"

--KAR98K
ARCCW_FAS_MS["Firearms2.KAR98K_BoltBack"] = "fas2/kar98k/kar98k_boltback.wav"
ARCCW_FAS_MS["Firearms2.KAR98K_BoltForward"] = "fas2/kar98k/kar98k_boltforward.wav"

--M110
ARCCW_FAS_MS["Firearms2.M110_Magout"] = "fas2/m110/m110_magout.wav"
ARCCW_FAS_MS["Firearms2.M110_Magin"] = "fas2/m110/m110_magin.wav"
ARCCW_FAS_MS["Firearms2.M110_Boltcatch"] = "fas2/m110/m110_boltcatch.wav"

--VSS
ARCCW_FAS_MS["Firearms2.VSS_Reload"] = "fas2/vss/vss_reload.wav"
ARCCW_FAS_MS["Firearms2.VSS_Reload_Empty"] = "fas2/vss/vss_reload_empty.wav"

--LR300
ARCCW_FAS_MS["Firearms2.LR300_Deploy"] = "fas2/lr300/lr300_deploy.wav"
ARCCW_FAS_MS["Firearms2.LR300_BoltPull"] = "fas2/lr300/lr300_boltpull.wav"
ARCCW_FAS_MS["Firearms2.LR300_MagOut"] = "fas2/lr300/lr300_magout.wav"
ARCCW_FAS_MS["Firearms2.LR300_MagIn"] = "fas2/lr300/lr300_magin.wav"

--MX4
ARCCW_FAS_MS["Firearms2.MX4_MagOut"] = "fas2/mx4/mx4_magout.wav"
ARCCW_FAS_MS["Firearms2.MX4_MagIn"] = "fas2/mx4/mx4_magin.wav"

local tbl = {channel = CHAN_AUTO,
	volume = 1,
	level = 65,
	pitchstart = 100,
	pitchend = 100}

for k, v in pairs(ARCCW_FAS_MS) do
	tbl.name = k
	tbl.sound = v
		
	sadd(tbl)
	
	if type(v) == "table" then
		for k2, v2 in pairs(v) do
			ups(v2)
		end
	else
		ups(v)
	end
end

local ARCCW_FAS_RIFLES_FS = {}

ARCCW_FAS_RIFLES_FS["Firearms2_AK47"] = "fas2/ak47/ak47_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AK74"] = "fas2/ak74/ak74_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_FAMAS"] = "fas2/famas/famas_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_G3"] = "fas2/g3a3/g3_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_G36C"] = "fas2/g36c/g36c_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M4A1"] = "fas2/m4a1/m4_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M16A2"] = "fas2/m16a2/m16a2_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SAKO95"] = "fas2/sako95/sako95_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SG550"] = "fas2/sg55x/sg550_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SG552"] = "fas2/sg55x/sg552_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_RAGINGBULL"] = "fas2/ragingbull/ragingbull_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M79"] = "fas2/m79/m79_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_VOLLMER"] = "fas2/vollmer/vollmer_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_RPK47"] = "fas2/rpk47/rpk47_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M60E3"] = "fas2/m60/m60_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M249"] = "fas2/m249/m249_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M14"] = "fas2/m14/m14_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SKS"] = "fas2/sks/sks_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_KS23"] = "fas2/ks23/ks23_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M3S90"] = "fas2/m3s90p/m3s90_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_REM870"] = "fas2/rem870/rem870_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_PP19"] = "fas2/bizon/bizon_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MP5"] = "fas2/mp5/mp5_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MP5K"] = "fas2/mp5/mp5k_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MAC11"] = "fas2/mac11/mac11_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_UZI"] = "fas2/uzi/uzi_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_STERLING"] = "fas2/sterling/sterling_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MK7A4"] = "fas2/sterling_mk7a4/mk7a4_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M21"] = "fas2/m21/m21_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M24"] = "fas2/m24/m24_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SR25"] = "fas2/sr25/sr25_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SVD"] = "fas2/svd/svd_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M82"] = "fas2/m82/m82_fire1.wav"

--NEW
ARCCW_FAS_RIFLES_FS["Firearms2_AUG"] = "fas2/aug/aug_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AKM"] = "fas2/akm/akm_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AKS74U"] = "fas2/aks74u/aks74u_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_DUPLET"] = "fas2/duplet/duplet_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_SHORTY"] = "fas2/shorty/shorty_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_BM16"] = "fas2/bm16/bm16_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AK12"] = {"fas2/ak12/ak12_fire1.wav", "fas2/ak12/ak12_fire2.wav", "fas2/ak12/ak12_fire3.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_AN94"] = {"fas2/an94/an94_fire1.wav", "fas2/an94/an94_fire2.wav", "fas2/an94/an94_fire3.wav", "fas2/an94/an94_fire4.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_GALIL"] = "fas2/galil/galil_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_TOZ34"] = "fas2/toz34/toz34_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AK101"] = "fas2/ak101/ak101_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_REM870_TACTICAL"] = "fas2/rem870_tactical/rem870_tactical_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_RPG26"] = "fas2/rpg26/rpg26_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_AK104"] = "fas2/ak104/ak104_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_ASH12"] = "fas2/ash12/ash12_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_G36K"] = "fas2/g36k/g36k_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_L85"] = "fas2/l85/l85_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MP153"] = {"fas2/mp153/mp153_fire1.wav", "fas2/mp153/mp153_fire2.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_SAIGA12K"] = {"fas2/saiga12k/saiga12k_fire1.wav", "fas2/saiga12k/saiga12k_fire3.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_VECTOR"] = "fas2/kriss/kriss_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_P90"] = {"fas2/p90/p90_fire1.wav", "fas2/p90/p90_fire2.wav", "fas2/p90/p90_fire3.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_UMP45"] = "fas2/ump45/ump45_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_FNFAL"] = {"fas2/fnfal/fnfal_fire1.wav", "fas2/fnfal/fnfal_fire2.wav", "fas2/fnfal/fnfal_fire3.wav"}
ARCCW_FAS_RIFLES_FS["Firearms2_KAR98K"] = "fas2/kar98k/kar98k_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M40A3"] = "fas2/m40a3/m40a3_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_M110"] = "fas2/m110/m110_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_LR300"] = "fas2/lr300/lr300_fire1.wav"
ARCCW_FAS_RIFLES_FS["Firearms2_MX4"] = "fas2/mx4/mx4_fire1.wav"

local tbl = {channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitchstart = 92,
	pitchend = 112}

for k, v in pairs(ARCCW_FAS_RIFLES_FS) do
	tbl.name = k
	tbl.sound = v
		
	sadd(tbl)
	
	if type(v) == "table" then
		for k2, v2 in pairs(v) do
			ups(v2)
		end
	else
		ups(v)
	end
end	

local ARCCW_FAS_PISTOLS_FS = {}

ARCCW_FAS_PISTOLS_FS["Firearms2_DEAGLE"] = "fas2/deserteagle/de_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_GLOCK20"] = "fas2/glock20/glock20_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_M1911"] = "fas2/1911/1911_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_OTS33"] = "fas2/ots33/ots33_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_P226"] = "fas2/p226/p226_fire1.wav"

--NEW
ARCCW_FAS_PISTOLS_FS["Firearms2_DEAGLE357"] = "fas2/deagle357/deagle357_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_GSH18"] = "fas2/gsh18/gsh18_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_PM"] = "fas2/pm/pm_fire1.wav"
ARCCW_FAS_PISTOLS_FS["Firearms2_PMM"] = "fas2/pmm/pmm_fire1.wav"

local tbl = {channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitchstart = 92,
	pitchend = 112}

for k, v in pairs(ARCCW_FAS_PISTOLS_FS) do
	tbl.name = k
	tbl.sound = v
		
	sadd(tbl)
	
	if type(v) == "table" then
		for k2, v2 in pairs(v) do
			ups(v2)
		end
	else
		ups(v)
	end
end

local ARCCW_FAS_RIFLES_FSS = {}

ARCCW_FAS_RIFLES_FSS["Firearms2_AK47_S"] = "fas2/ak47/ak47_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_AK74_S"] = "fas2/ak74/ak74_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_FAMAS_S"] = "fas2/famas/famas_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_G3_S"] = "fas2/g3a3/g3_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_G36C_S"] = "fas2/g36c/g36c_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M4A1_S"] = "fas2/m4a1/m4_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M16A2_S"] = "fas2/m16a2/m16a2_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SAKO95_S"] = "fas2/sako95/sako95_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SG550_S"] = "fas2/sg55x/sg550_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SG552_S"] = "fas2/sg55x/sg552_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_VOLLMER_S"] = "fas2/vollmer/vollmer_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_RPK47_S"] = "fas2/rpk47/rpk47_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M60E3_S"] = "fas2/m60/m60_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M249_S"] = "fas2/m249/m249_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M14_S"] = "fas2/m14/m14_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SKS_S"] = "fas2/sks/sks_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_PP19_S"] = "fas2/bizon/bizon_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_MP5K_S"] = "fas2/mp5/mp5k_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_MP5SD"] = "fas2/mp5/mp5sd_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_MAC11_S"] = "fas2/mac11/mac11_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_UZI_S"] = "fas2/uzi/uzi_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_STERLING_S"] = "fas2/sterling/sterling_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_MK7A4_S"] = "fas2/sterling_mk7a4/mk7a4_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M21_S"] = "fas2/m21/m21_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M24_S"] = "fas2/m24/m24_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SR25_S"] = "fas2/sr25/sr25_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SVD_S"] = "fas2/svd/svd_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_AK101_S"] = "fas2/ak101/ak101_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_AK104_S"] = "fas2/ak104/ak104_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_G36K_S"] = "fas2/g36k/g36k_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_L85_S"] = "fas2/l85/l85_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_SAIGA12K_S"] = "fas2/saiga12k/saiga12k_suppressed.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_P90_S"] = {"fas2/p90/p90_suppressed_fire1.wav", "fas2/p90/p90_suppressed_fire2.wav", "fas2/p90/p90_suppressed_fire3.wav"}
ARCCW_FAS_RIFLES_FSS["Firearms2_UMP45_S"] = "fas2/ump45/ump45_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_FNFAL_S"] = {"fas2/fnfal/fnfal_suppressed_fire1.wav", "fas2/fnfal/fnfal_suppressed_fire2.wav", "fas2/fnfal/fnfal_suppressed_fire3.wav"}
ARCCW_FAS_RIFLES_FSS["Firearms2_M110_S"] = "fas2/m110/m110_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_VSS"] = "fas2/vss/vss_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_LR300_S"] = "fas2/lr300/lr300_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_"] = ""


ARCCW_FAS_RIFLES_FSS["Firearms2_GLOCK20_S"] = "fas2/glock20/glock20_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_M1911_S"] = "fas2/1911/1911_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_P226_S"] = "fas2/p226/p226_suppressed_fire1.wav"
ARCCW_FAS_RIFLES_FSS["Firearms2_PM_S"] = "fas2/pm/pm_suppressed_fire1.wav"

local tbl = {channel = CHAN_STATIC,
	volume = 1,
	level = 70,
	pitchstart = 92,
	pitchend = 112}

for k, v in pairs(ARCCW_FAS_RIFLES_FSS) do
	tbl.name = k
	tbl.sound = v
		
	sadd(tbl)
	
	if type(v) == "table" then
		for k2, v2 in pairs(v) do
			ups(v2)
		end
	else
		ups(v)
	end
end	