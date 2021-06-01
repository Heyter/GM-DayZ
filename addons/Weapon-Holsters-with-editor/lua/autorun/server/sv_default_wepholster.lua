--[[
   __  ___        __      __                                
  /  |/  /__ ____/ /__   / /  __ __                         
 / /|_/ / _ `/ _  / -_) / _ \/ // /                         
/_/  /_/\_,_/\_,_/\__/ /_.__/\_, /                          
   ___       __             /___/         ___           __  
  / _ \___  / /_ _____ ___ / /____ ____  / _ \__ ______/ /__
 / ___/ _ \/ / // / -_|_-</ __/ -_) __/ / // / // / __/  '_/
/_/   \___/_/\_, /\__/___/\__/\__/_/   /____/\_,_/\__/_/\_\ 
            /___/                                           
https://steamcommunity.com/profiles/76561198057599363
]]
WepHolster.defData = {}
----------------------------------------------------------------
----------------------------------------------------------------
-- Half-Life 2 Weapons
----------------------------------------------------------------
WepHolster.defData["weapon_pistol"] = {}
WepHolster.defData["weapon_pistol"].Model = "models/weapons/W_pistol.mdl"
WepHolster.defData["weapon_pistol"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_pistol"].BoneOffset = {Vector(0, -8, 0), Angle(0, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["weapon_357"] = {}
WepHolster.defData["weapon_357"].Model = "models/weapons/W_357.mdl"
WepHolster.defData["weapon_357"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_357"].BoneOffset = {Vector(-5, 8, 0), Angle(0, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["weapon_frag"] = {}
WepHolster.defData["weapon_frag"].Model = "models/Items/grenadeAmmo.mdl"
WepHolster.defData["weapon_frag"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_frag"].BoneOffset = {Vector(3, -5, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["weapon_slam"] = {}
WepHolster.defData["weapon_slam"].Model = "models/weapons/w_slam.mdl"
WepHolster.defData["weapon_slam"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["weapon_slam"].BoneOffset = {Vector(-9, 0, -7), Angle(270, 90, -25)}
----------------------------------------------------------------
WepHolster.defData["weapon_crowbar"] = {}
WepHolster.defData["weapon_crowbar"].Model = "models/weapons/w_crowbar.mdl"
WepHolster.defData["weapon_crowbar"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["weapon_crowbar"].BoneOffset = {Vector(3, 0, 0), Angle(0, 0, 45)}
----------------------------------------------------------------
WepHolster.defData["weapon_stunstick"] = {}
WepHolster.defData["weapon_stunstick"].Model = "models/weapons/W_stunbaton.mdl"
WepHolster.defData["weapon_stunstick"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["weapon_stunstick"].BoneOffset = {Vector(3, 0, 0), Angle(0, 0, -45)}
----------------------------------------------------------------
WepHolster.defData["weapon_shotgun"] = {}
WepHolster.defData["weapon_shotgun"].Model = "models/weapons/W_shotgun.mdl"
WepHolster.defData["weapon_shotgun"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["weapon_shotgun"].BoneOffset = {Vector(10, 5, 2), Angle(0, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["weapon_rpg"] = {}
WepHolster.defData["weapon_rpg"].Model = "models/weapons/w_rocket_launcher.mdl"
WepHolster.defData["weapon_rpg"].Bone = "ValveBiped.Bip01_L_Clavicle"
WepHolster.defData["weapon_rpg"].BoneOffset = {Vector(-16, 5, 0), Angle(90, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_smg1"] = {}
WepHolster.defData["weapon_smg1"].Model = "models/weapons/w_smg1.mdl"
WepHolster.defData["weapon_smg1"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["weapon_smg1"].BoneOffset = {Vector(5, 0, -5), Angle(0, 0, 230)}
----------------------------------------------------------------
WepHolster.defData["weapon_ar2"] = {}
WepHolster.defData["weapon_ar2"].Model = "models/weapons/W_irifle.mdl"
WepHolster.defData["weapon_ar2"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["weapon_ar2"].BoneOffset = {Vector(-5, 0, 7), Angle(0, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["weapon_crossbow"] = {}
WepHolster.defData["weapon_crossbow"].Model = "models/weapons/W_crossbow.mdl"
WepHolster.defData["weapon_crossbow"].Bone = "ValveBiped.Bip01_L_Clavicle"
WepHolster.defData["weapon_crossbow"].BoneOffset = {Vector(0, 5, -5), Angle(180, 90, 0)}
----------------------------------------------------------------
----------------------------------------------------------------
-- CW 2.0
----------------------------------------------------------------
WepHolster.defData["cw_ak74"] = {}
WepHolster.defData["cw_ak74"].Model = "models/weapons/w_rif_ak47.mdl"
WepHolster.defData["cw_ak74"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_ak74"].BoneOffset = {Vector(13, 4, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_ar15"] = {}
WepHolster.defData["cw_ar15"].Model = "models/weapons/w_rif_m4a1.mdl"
WepHolster.defData["cw_ar15"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_ar15"].BoneOffset = {Vector(13, 4, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_deagle"] = {}
WepHolster.defData["cw_deagle"].Model = "models/weapons/w_pist_deagle.mdl"
WepHolster.defData["cw_deagle"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_deagle"].BoneOffset = {Vector(1, -7.5, -5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_l115"] = {}
WepHolster.defData["cw_l115"].Model = "models/weapons/w_cstm_l96.mdl"
WepHolster.defData["cw_l115"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_l115"].BoneOffset = {Vector(1, 5, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_g3a3"] = {}
WepHolster.defData["cw_g3a3"].Model = "models/weapons/w_snip_g3sg1.mdl"
WepHolster.defData["cw_g3a3"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_g3a3"].BoneOffset = {Vector(13, 10, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_vss"] = {}
WepHolster.defData["cw_vss"].Model = "models/cw2/rifles/w_vss.mdl"
WepHolster.defData["cw_vss"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_vss"].BoneOffset = {Vector(6, 1, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_m3super90"] = {}
WepHolster.defData["cw_m3super90"].Model = "models/weapons/w_cstm_m3super90.mdl"
WepHolster.defData["cw_m3super90"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_m3super90"].BoneOffset = {Vector(1, 5, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_m249_official"] = {}
WepHolster.defData["cw_m249_official"].Model = "models/weapons/cw2_0_mach_para.mdl"
WepHolster.defData["cw_m249_official"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_m249_official"].BoneOffset = {Vector(1, 5, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_mac11"] = {}
WepHolster.defData["cw_mac11"].Model = "models/weapons/w_cst_mac11.mdl"
WepHolster.defData["cw_mac11"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cw_mac11"].BoneOffset = {Vector(5, -5, 5), Angle(0, 0, 230)}
----------------------------------------------------------------
WepHolster.defData["cw_shorty"] = {}
WepHolster.defData["cw_shorty"].Model = "models/weapons/cw2_super_shorty.mdl"
WepHolster.defData["cw_shorty"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cw_shorty"].BoneOffset = {Vector(5, -5, 5), Angle(0, 0, 230)}
----------------------------------------------------------------
WepHolster.defData["cw_mp5"] = {}
WepHolster.defData["cw_mp5"].Model = "models/weapons/w_smg_mp5.mdl"
WepHolster.defData["cw_mp5"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cw_mp5"].BoneOffset = {Vector(5, -5, 5), Angle(0, 0, 230)}
----------------------------------------------------------------
WepHolster.defData["cw_ump45"] = {}
WepHolster.defData["cw_ump45"].Model = "models/weapons/w_smg_ump45.mdl"
WepHolster.defData["cw_ump45"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cw_ump45"].BoneOffset = {Vector(5, -5, 5), Angle(0, 0, 230)}
----------------------------------------------------------------
WepHolster.defData["cw_g36c"] = {}
WepHolster.defData["cw_g36c"].Model = "models/weapons/cw20_g36c.mdl"
WepHolster.defData["cw_g36c"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_g36c"].BoneOffset = {Vector(1, 4, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_scarh"] = {}
WepHolster.defData["cw_scarh"].Model = "models/cw2/rifles/w_scarh.mdl"
WepHolster.defData["cw_scarh"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_scarh"].BoneOffset = {Vector(1, 4, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_l85a2"] = {}
WepHolster.defData["cw_l85a2"].Model = "models/weapons/w_cw20_l85a2.mdl"
WepHolster.defData["cw_l85a2"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_l85a2"].BoneOffset = {Vector(-10, 14, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_m14"] = {}
WepHolster.defData["cw_m14"].Model = "models/weapons/w_cstm_m14.mdl"
WepHolster.defData["cw_m14"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["cw_m14"].BoneOffset = {Vector(1, 4, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["cw_p99"] = {}
WepHolster.defData["cw_p99"].Model = "models/weapons/w_pist_p228.mdl"
WepHolster.defData["cw_p99"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_p99"].BoneOffset = {Vector(5, -7.5, -5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_mr96"] = {}
WepHolster.defData["cw_mr96"].Model = "models/weapons/W_357.mdl"
WepHolster.defData["cw_mr96"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_mr96"].BoneOffset = {Vector(0, -7.5, -2), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_fiveseven"] = {}
WepHolster.defData["cw_fiveseven"].Model = "models/weapons/w_pist_fiveseven.mdl"
WepHolster.defData["cw_fiveseven"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_fiveseven"].BoneOffset = {Vector(1, -7.5, -5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_m1911"] = {}
WepHolster.defData["cw_m1911"].Model = "models/weapons/cw_pist_m1911.mdl"
WepHolster.defData["cw_m1911"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_m1911"].BoneOffset = {Vector(-1, -7.5, -2), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_frag_grenade"] = {}
WepHolster.defData["cw_frag_grenade"].Model = "models/weapons/w_cw_fraggrenade_thrown.mdl"
WepHolster.defData["cw_frag_grenade"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_frag_grenade"].BoneOffset = {Vector(3, -5, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_flash_grenade"] = {}
WepHolster.defData["cw_flash_grenade"].Model = "models/weapons/w_eq_flashbang_thrown.mdl"
WepHolster.defData["cw_flash_grenade"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_flash_grenade"].BoneOffset = {Vector(3, -1, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_smoke_grenade"] = {}
WepHolster.defData["cw_smoke_grenade"].Model = "models/weapons/w_eq_smokegrenade_thrown.mdl"
WepHolster.defData["cw_smoke_grenade"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_smoke_grenade"].BoneOffset = {Vector(3, 3, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cw_extrema_ratio_official"] = {}
WepHolster.defData["cw_extrema_ratio_official"].Model = "models/weapons/wcw_ex_ra.mdl"
WepHolster.defData["cw_extrema_ratio_official"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cw_extrema_ratio_official"].BoneOffset = {Vector(1, -7.5, -0.5), Angle(180, 0, 0)}
----------------------------------------------------------------
----------------------------------------------------------------
-- FA:S 2.0
----------------------------------------------------------------
WepHolster.defData["fas2_ak47"] = {}
WepHolster.defData["fas2_ak47"].Model = "models/weapons/w_rif_ak47.mdl"
WepHolster.defData["fas2_ak47"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_ak47"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_ak74"] = {}
WepHolster.defData["fas2_ak74"].Model = "models/weapons/w_rif_galil.mdl"
WepHolster.defData["fas2_ak74"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_ak74"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_famas"] = {}
WepHolster.defData["fas2_famas"].Model = "models/weapons/w_rif_famas.mdl"
WepHolster.defData["fas2_famas"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_famas"].BoneOffset = {Vector(16, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_g36c"] = {}
WepHolster.defData["fas2_g36c"].Model = "models/weapons/w_g36e.mdl"
WepHolster.defData["fas2_g36c"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_g36c"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_g3"] = {}
WepHolster.defData["fas2_g3"].Model = "models/weapons/w_g3a3.mdl"
WepHolster.defData["fas2_g3"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_g3"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m14"] = {}
WepHolster.defData["fas2_m14"].Model = "models/weapons/w_m14.mdl"
WepHolster.defData["fas2_m14"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m14"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m21"] = {}
WepHolster.defData["fas2_m21"].Model = "models/weapons/w_m14.mdl"
WepHolster.defData["fas2_m21"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m21"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m24"] = {}
WepHolster.defData["fas2_m24"].Model = "models/weapons/w_m24.mdl"
WepHolster.defData["fas2_m24"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m24"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m3s90"] = {}
WepHolster.defData["fas2_m3s90"].Model = "models/weapons/w_m3.mdl"
WepHolster.defData["fas2_m3s90"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m3s90"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m4a1"] = {}
WepHolster.defData["fas2_m4a1"].Model = "models/weapons/w_m4.mdl"
WepHolster.defData["fas2_m4a1"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m4a1"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_m82"] = {}
WepHolster.defData["fas2_m82"].Model = "models/weapons/w_m82.mdl"
WepHolster.defData["fas2_m82"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_m82"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_mp5a5"] = {}
WepHolster.defData["fas2_mp5a5"].Model = "models/weapons/w_mp5.mdl"
WepHolster.defData["fas2_mp5a5"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_mp5a5"].BoneOffset = {Vector(13, 4, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_pp19"] = {}
WepHolster.defData["fas2_pp19"].Model = "models/weapons/w_smg_biz.mdl"
WepHolster.defData["fas2_pp19"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_pp19"].BoneOffset = {Vector(-4, 7, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_rpk"] = {}
WepHolster.defData["fas2_rpk"].Model = "models/weapons/w_ak47.mdl"
WepHolster.defData["fas2_rpk"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_rpk"].BoneOffset = {Vector(14, 3, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_rk95"] = {}
WepHolster.defData["fas2_rk95"].Model = "models/weapons/world/rifles/rk95.mdl"
WepHolster.defData["fas2_rk95"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_rk95"].BoneOffset = {Vector(5, 3, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_sg550"] = {}
WepHolster.defData["fas2_sg550"].Model = "models/weapons/w_rif_sg552.mdl"
WepHolster.defData["fas2_sg550"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_sg550"].BoneOffset = {Vector(14, 8, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_sg552"] = {}
WepHolster.defData["fas2_sg552"].Model = "models/weapons/w_rif_sg552.mdl"
WepHolster.defData["fas2_sg552"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_sg552"].BoneOffset = {Vector(14, 8, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_sks"] = {}
WepHolster.defData["fas2_sks"].Model = "models/weapons/world/rifles/sks.mdl"
WepHolster.defData["fas2_sks"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_sks"].BoneOffset = {Vector(14, 0, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_sr25"] = {}
WepHolster.defData["fas2_sr25"].Model = "models/weapons/w_sr25.mdl"
WepHolster.defData["fas2_sr25"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["fas2_sr25"].BoneOffset = {Vector(14, 3, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["fas2_ragingbull"] = {}
WepHolster.defData["fas2_ragingbull"].Model = "models/weapons/W_357.mdl"
WepHolster.defData["fas2_ragingbull"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_ragingbull"].BoneOffset = {Vector(-5, 8, 0), Angle(0, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["fas2_glock20"] = {}
WepHolster.defData["fas2_glock20"].Model = "models/weapons/w_pist_glock18.mdl"
WepHolster.defData["fas2_glock20"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_glock20"].BoneOffset = {Vector(-2, -8, -2), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["fas2_m67"] = {}
WepHolster.defData["fas2_m67"].Model = "models/weapons/w_eq_fraggrenade_thrown.mdl"
WepHolster.defData["fas2_m67"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_m67"].BoneOffset = {Vector(3, 4, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["fas2_m79"] = {}
WepHolster.defData["fas2_m79"].Model = "models/weapons/w_m79.mdl"
WepHolster.defData["fas2_m79"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_m79"].BoneOffset = {Vector(-4, -2, -7), Angle(-85, 0, 90)}
----------------------------------------------------------------
WepHolster.defData["fas2_ifak"] = {}
WepHolster.defData["fas2_ifak"].Model = "models/weapons/w_ifak.mdl"
WepHolster.defData["fas2_ifak"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["fas2_ifak"].BoneOffset = {Vector(-8, 0, 6), Angle(180, 95, 30)}
----------------------------------------------------------------
WepHolster.defData["fas2_machete"] = {}
WepHolster.defData["fas2_machete"].Model = "models/weapons/w_machete.mdl"
WepHolster.defData["fas2_machete"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_machete"].BoneOffset = {Vector(2, -7.5, 2), Angle(0, 800, 90)}
----------------------------------------------------------------
WepHolster.defData["fas2_dv2"] = {}
WepHolster.defData["fas2_dv2"].Model = "models/weapons/w_dv2.mdl"
WepHolster.defData["fas2_dv2"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["fas2_dv2"].BoneOffset = {Vector(3, -8, 0), Angle(0, 800, 90)}
----------------------------------------------------------------
----------------------------------------------------------------
-- M9K
----------------------------------------------------------------
WepHolster.defData["m9k_winchester73"] = {}
WepHolster.defData["m9k_winchester73"].Model = "models/weapons/w_winchester_1873.mdl"
WepHolster.defData["m9k_winchester73"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_winchester73"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_acr"] = {}
WepHolster.defData["m9k_acr"].Model = "models/weapons/w_masada_acr.mdl"
WepHolster.defData["m9k_acr"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_acr"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_ak47"] = {}
WepHolster.defData["m9k_ak47"].Model = "models/weapons/w_ak47_m9k.mdl"
WepHolster.defData["m9k_ak47"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ak47"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_ak74"] = {}
WepHolster.defData["m9k_ak74"].Model = "models/weapons/w_ak47_m9k.mdl"
WepHolster.defData["m9k_ak74"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ak74"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_amd65"] = {}
WepHolster.defData["m9k_amd65"].Model = "models/weapons/w_amd_65.mdl"
WepHolster.defData["m9k_amd65"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_amd65"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_an94"] = {}
WepHolster.defData["m9k_an94"].Model = "models/weapons/w_rif_an_94.mdl"
WepHolster.defData["m9k_an94"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_an94"].BoneOffset = {Vector(1, -2, 4), Angle(90, -2, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_val"] = {}
WepHolster.defData["m9k_val"].Model = "models/weapons/w_dmg_vally.mdl"
WepHolster.defData["m9k_val"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_val"].BoneOffset = {Vector(9, 2, 4.3), Angle(5, 12, 242)}
----------------------------------------------------------------
WepHolster.defData["m9k_f2000"] = {}
WepHolster.defData["m9k_f2000"].Model = "models/weapons/w_fn_f2000.mdl"
WepHolster.defData["m9k_f2000"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_f2000"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_famas"] = {}
WepHolster.defData["m9k_famas"].Model = "models/weapons/w_tct_famas.mdl"
WepHolster.defData["m9k_famas"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_famas"].BoneOffset = {Vector(2, 1.5, 6), Angle(12, 10, 240)}
----------------------------------------------------------------
WepHolster.defData["m9k_fal"] = {}
WepHolster.defData["m9k_fal"].Model = "models/weapons/w_fn_fal.mdl"
WepHolster.defData["m9k_fal"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_fal"].BoneOffset = {Vector(3, 5, 3.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_g36"] = {}
WepHolster.defData["m9k_g36"].Model = "models/weapons/w_hk_g36c.mdl"
WepHolster.defData["m9k_g36"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_g36"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_m416"] = {}
WepHolster.defData["m9k_m416"].Model = "models/weapons/w_hk_416.mdl"
WepHolster.defData["m9k_m416"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m416"].BoneOffset = {Vector(3, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_g3a3"] = {}
WepHolster.defData["m9k_g3a3"].Model = "models/weapons/w_hk_g3.mdl"
WepHolster.defData["m9k_g3a3"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_g3a3"].BoneOffset = {Vector(3, 5, 3.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_l85"] = {}
WepHolster.defData["m9k_l85"].Model = "models/weapons/w_l85a2.mdl"
WepHolster.defData["m9k_l85"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_l85"].BoneOffset = {Vector(7, 5, 4), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_m14sp"] = {}
WepHolster.defData["m9k_m14sp"].Model = "models/weapons/w_snip_m14sp.mdl"
WepHolster.defData["m9k_m14sp"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m14sp"].BoneOffset = {Vector(3, 2, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_m16a4_acog"] = {}
WepHolster.defData["m9k_m16a4_acog"].Model = "models/weapons/w_dmg_m16ag.mdl"
WepHolster.defData["m9k_m16a4_acog"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m16a4_acog"].BoneOffset = {Vector(8, 1, 3.3), Angle(180, 10, 95)}
----------------------------------------------------------------
WepHolster.defData["m9k_m4a1"] = {}
WepHolster.defData["m9k_m4a1"].Model = "models/weapons/w_m4a1_iron.mdl"
WepHolster.defData["m9k_m4a1"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m4a1"].BoneOffset = {Vector(3, 5, 5), Angle(90, -5, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_scar"] = {}
WepHolster.defData["m9k_scar"].Model = "models/weapons/w_fn_scar_h.mdl"
WepHolster.defData["m9k_scar"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_scar"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, -5, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_vikhr"] = {}
WepHolster.defData["m9k_vikhr"].Model = "models/weapons/w_dmg_vikhr.mdl"
WepHolster.defData["m9k_vikhr"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_vikhr"].BoneOffset = {Vector(0, 1, 5), Angle(90, -5, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_auga3"] = {}
WepHolster.defData["m9k_auga3"].Model = "models/weapons/w_auga3.mdl"
WepHolster.defData["m9k_auga3"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_auga3"].BoneOffset = {Vector(4.5, 5, 4), Angle(90, -10, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_tar21"] = {}
WepHolster.defData["m9k_tar21"].Model = "models/weapons/w_imi_tar21.mdl"
WepHolster.defData["m9k_tar21"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_tar21"].BoneOffset = {Vector(8.5, 3, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_ares_shrike"] = {}
WepHolster.defData["m9k_ares_shrike"].Model = "models/weapons/w_ares_shrike.mdl"
WepHolster.defData["m9k_ares_shrike"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ares_shrike"].BoneOffset = {Vector(8.5, 5, 3.5), Angle(90, -10, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_minigun"] = {}
WepHolster.defData["m9k_minigun"].Model = "models/weapons/w_m134_minigun.mdl"
WepHolster.defData["m9k_minigun"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_minigun"].BoneOffset = {Vector(-10, 5, 5), Angle(90, -10, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_fg42"] = {}
WepHolster.defData["m9k_fg42"].Model = "models/weapons/w_fg42.mdl"
WepHolster.defData["m9k_fg42"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_fg42"].BoneOffset = {Vector(5, 3, 6), Angle(265, 10, 230)}
----------------------------------------------------------------
WepHolster.defData["m9k_m1918bar"] = {}
WepHolster.defData["m9k_m1918bar"].Model = "models/weapons/w_m1918_bar.mdl"
WepHolster.defData["m9k_m1918bar"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m1918bar"].BoneOffset = {Vector(1, 3, 6), Angle(265, 10, 230)}
----------------------------------------------------------------
WepHolster.defData["m9k_m249lmg"] = {}
WepHolster.defData["m9k_m249lmg"].Model = "models/weapons/w_m249_machine_gun.mdl"
WepHolster.defData["m9k_m249lmg"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m249lmg"].BoneOffset = {Vector(1, 3, 6), Angle(265, 25, 230)}
----------------------------------------------------------------
WepHolster.defData["m9k_m60"] = {}
WepHolster.defData["m9k_m60"].Model = "models/weapons/w_m60_machine_gun.mdl"
WepHolster.defData["m9k_m60"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m60"].BoneOffset = {Vector(1, 3, 6.5), Angle(265, 25, 230)}
----------------------------------------------------------------
WepHolster.defData["m9k_pkm"] = {}
WepHolster.defData["m9k_pkm"].Model = "models/weapons/w_mach_russ_pkm.mdl"
WepHolster.defData["m9k_pkm"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_pkm"].BoneOffset = {Vector(1, 5, 4.2), Angle(265, 25, 230)}
----------------------------------------------------------------
WepHolster.defData["m9k_colt1911"] = {}
WepHolster.defData["m9k_colt1911"].Model = "models/weapons/s_dmgf_co1911.mdl"
WepHolster.defData["m9k_colt1911"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_colt1911"].BoneOffset = {Vector(13, 5.5, -2.5), Angle(180, -20, 45)}
----------------------------------------------------------------
WepHolster.defData["m9k_coltpython"] = {}
WepHolster.defData["m9k_coltpython"].Model = "models/weapons/w_colt_python.mdl"
WepHolster.defData["m9k_coltpython"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_coltpython"].BoneOffset = {Vector(13, 5.5, -2.5), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_deagle"] = {}
WepHolster.defData["m9k_deagle"].Model = "models/weapons/w_tcom_deagle.mdl"
WepHolster.defData["m9k_deagle"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_deagle"].BoneOffset = {Vector(18, 5.5, -2.5), Angle(180, -11, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_glock"] = {}
WepHolster.defData["m9k_glock"].Model = "models/weapons/w_dmg_glock.mdl"
WepHolster.defData["m9k_glock"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_glock"].BoneOffset = {Vector(5, -1.5, 4), Angle(180, -150, -70)}
----------------------------------------------------------------
WepHolster.defData["m9k_hk45"] = {}
WepHolster.defData["m9k_hk45"].Model = "models/weapons/w_hk45c.mdl"
WepHolster.defData["m9k_hk45"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_hk45"].BoneOffset = {Vector(4, 5, 0), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_m29satan"] = {}
WepHolster.defData["m9k_m29satan"].Model = "models/weapons/w_m29_satan.mdl"
WepHolster.defData["m9k_m29satan"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m29satan"].BoneOffset = {Vector(6, 6.2, -2.5), Angle(0, 0, -10)}
----------------------------------------------------------------
WepHolster.defData["m9k_m92beretta"] = {}
WepHolster.defData["m9k_m92beretta"].Model = "models/weapons/w_beretta_m92.mdl"
WepHolster.defData["m9k_m92beretta"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m92beretta"].BoneOffset = {Vector(8, 5, 0), Angle(15, 18, 15)}
----------------------------------------------------------------
WepHolster.defData["m9k_luger"] = {}
WepHolster.defData["m9k_luger"].Model = "models/weapons/w_luger_p08.mdl"
WepHolster.defData["m9k_luger"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_luger"].BoneOffset = {Vector(7, 4.2, 0), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_ragingbull"] = {}
WepHolster.defData["m9k_ragingbull"].Model = "models/weapons/w_taurus_raging_bull.mdl"
WepHolster.defData["m9k_ragingbull"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ragingbull"].BoneOffset = {Vector(7, 4.5, -1), Angle(0, -5, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_scoped_taurus"] = {}
WepHolster.defData["m9k_scoped_taurus"].Model = "models/weapons/w_raging_bull_scoped.mdl"
WepHolster.defData["m9k_scoped_taurus"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_scoped_taurus"].BoneOffset = {Vector(13, 3, 3.9), Angle(-90, 180, 50)}
----------------------------------------------------------------
WepHolster.defData["m9k_remington1858"] = {}
WepHolster.defData["m9k_remington1858"].Model = "models/weapons/w_remington_1858.mdl"
WepHolster.defData["m9k_remington1858"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_remington1858"].BoneOffset = {Vector(5, 5, -2), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_model3russian"] = {}
WepHolster.defData["m9k_model3russian"].Model = "models/weapons/w_model_3_rus.mdl"
WepHolster.defData["m9k_model3russian"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_model3russian"].BoneOffset = {Vector(5, 4.3, -2), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_model500"] = {}
WepHolster.defData["m9k_model500"].Model = "models/weapons/w_sw_model_500.mdl"
WepHolster.defData["m9k_model500"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_model500"].BoneOffset = {Vector(5, 4.3, -2), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_model627"] = {}
WepHolster.defData["m9k_model627"].Model = "models/weapons/w_sw_model_627.mdl"
WepHolster.defData["m9k_model627"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_model627"].BoneOffset = {Vector(5, 4.3, -2), Angle(0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_sig_p229r"] = {}
WepHolster.defData["m9k_sig_p229r"].Model = "models/weapons/w_pist_fokkususp.mdl"
WepHolster.defData["m9k_sig_p229r"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_sig_p229r"].BoneOffset = {Vector(10, 5.5, 2), Angle(0, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["m9k_m3"] = {}
WepHolster.defData["m9k_m3"].Model = "models/weapons/w_benelli_m3.mdl"
WepHolster.defData["m9k_m3"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m3"].BoneOffset = {Vector(3, 5, 2.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_browningauto5"] = {}
WepHolster.defData["m9k_browningauto5"].Model = "models/weapons/w_browning_auto.mdl"
WepHolster.defData["m9k_browningauto5"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_browningauto5"].BoneOffset = {Vector(3, 5, 2.9), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_dbarrel"] = {}
WepHolster.defData["m9k_dbarrel"].Model = "models/weapons/w_double_barrel_shotgun.mdl"
WepHolster.defData["m9k_dbarrel"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_dbarrel"].BoneOffset = {Vector(3, 5, 2.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_ithacam37"] = {}
WepHolster.defData["m9k_ithacam37"].Model = "models/weapons/w_ithaca_m37.mdl"
WepHolster.defData["m9k_ithacam37"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ithacam37"].BoneOffset = {Vector(3, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mossberg590"] = {}
WepHolster.defData["m9k_mossberg590"].Model = "models/weapons/w_mossberg_590.mdl"
WepHolster.defData["m9k_mossberg590"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mossberg590"].BoneOffset = {Vector(3, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_jackhammer"] = {}
WepHolster.defData["m9k_jackhammer"].Model = "models/weapons/w_pancor_jackhammer.mdl"
WepHolster.defData["m9k_jackhammer"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_jackhammer"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_remington870"] = {}
WepHolster.defData["m9k_remington870"].Model = "models/weapons/w_remington_870_tact.mdl"
WepHolster.defData["m9k_remington870"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_remington870"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_spas12"] = {}
WepHolster.defData["m9k_spas12"].Model = "models/weapons/w_spas_12.mdl"
WepHolster.defData["m9k_spas12"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_spas12"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_striker12"] = {}
WepHolster.defData["m9k_striker12"].Model = "models/weapons/w_striker_12g.mdl"
WepHolster.defData["m9k_striker12"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_striker12"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_usas"] = {}
WepHolster.defData["m9k_usas"].Model = "models/weapons/w_usas_12.mdl"
WepHolster.defData["m9k_usas"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_usas"].BoneOffset = {Vector(3, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_1897winchester"] = {}
WepHolster.defData["m9k_1897winchester"].Model = "models/weapons/w_winchester_1887.mdl"
WepHolster.defData["m9k_1897winchester"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_1897winchester"].BoneOffset = {Vector(0, 5, 3.8), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_1887winchester"] = {}
WepHolster.defData["m9k_1887winchester"].Model = "models/weapons/w_winchester_1897_trench.mdl"
WepHolster.defData["m9k_1887winchester"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_1887winchester"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_aw50"] = {}
WepHolster.defData["m9k_aw50"].Model = "models/weapons/w_acc_int_aw50.mdl"
WepHolster.defData["m9k_aw50"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_aw50"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_barret_m82"] = {}
WepHolster.defData["m9k_barret_m82"].Model = "models/weapons/w_barret_m82.mdl"
WepHolster.defData["m9k_barret_m82"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_barret_m82"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_m98b"] = {}
WepHolster.defData["m9k_m98b"].Model = "models/weapons/w_barrett_m98b.mdl"
WepHolster.defData["m9k_m98b"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m98b"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_svu"] = {}
WepHolster.defData["m9k_svu"].Model = "models/weapons/w_dragunov_svu.mdl"
WepHolster.defData["m9k_svu"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_svu"].BoneOffset = {Vector(5, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_sl8"] = {}
WepHolster.defData["m9k_sl8"].Model = "models/weapons/w_hk_sl8.mdl"
WepHolster.defData["m9k_sl8"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_sl8"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_intervention"] = {}
WepHolster.defData["m9k_intervention"].Model = "models/weapons/w_acc_int_aw50.mdl"
WepHolster.defData["m9k_intervention"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_intervention"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_m24"] = {}
WepHolster.defData["m9k_m24"].Model = "models/weapons/w_snip_m24_6.mdl"
WepHolster.defData["m9k_m24"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_m24"].BoneOffset = {Vector(5, 2.5, 6.5), Angle(0, 0, 90)}
----------------------------------------------------------------
WepHolster.defData["m9k_psg1"] = {}
WepHolster.defData["m9k_psg1"].Model = "models/weapons/w_hk_psg1.mdl"
WepHolster.defData["m9k_psg1"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_psg1"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_remington7615p"] = {}
WepHolster.defData["m9k_remington7615p"].Model = "models/weapons/w_remington_7615p.mdl"
WepHolster.defData["m9k_remington7615p"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_remington7615p"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_dragunov"] = {}
WepHolster.defData["m9k_dragunov"].Model = "models/weapons/w_svd_dragunov.mdl"
WepHolster.defData["m9k_dragunov"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_dragunov"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_svt40"] = {}
WepHolster.defData["m9k_svt40"].Model = "models/weapons/w_svt_40.mdl"
WepHolster.defData["m9k_svt40"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_svt40"].BoneOffset = {Vector(0, 5, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_honeybadger"] = {}
WepHolster.defData["m9k_honeybadger"].Model = "models/weapons/w_aac_honeybadger.mdl"
WepHolster.defData["m9k_honeybadger"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_honeybadger"].BoneOffset = {Vector(0, 5.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_bizonp19"] = {}
WepHolster.defData["m9k_bizonp19"].Model = "models/weapons/w_pp19_bizon.mdl"
WepHolster.defData["m9k_bizonp19"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_bizonp19"].BoneOffset = {Vector(0, 5.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_smgp90"] = {}
WepHolster.defData["m9k_smgp90"].Model = "models/weapons/w_fn_p90.mdl"
WepHolster.defData["m9k_smgp90"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_smgp90"].BoneOffset = {Vector(5.5, 3, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mp5"] = {}
WepHolster.defData["m9k_mp5"].Model = "models/weapons/w_hk_mp5.mdl"
WepHolster.defData["m9k_mp5"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mp5"].BoneOffset = {Vector(3, 5.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mp7"] = {}
WepHolster.defData["m9k_mp7"].Model = "models/weapons/w_mp7_silenced.mdl"
WepHolster.defData["m9k_mp7"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mp7"].BoneOffset = {Vector(10, -2, 3.5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_ump45"] = {}
WepHolster.defData["m9k_ump45"].Model = "models/weapons/w_hk_ump45.mdl"
WepHolster.defData["m9k_ump45"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_ump45"].BoneOffset = {Vector(2, 5.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_usc"] = {}
WepHolster.defData["m9k_usc"].Model = "models/weapons/w_hk_usc.mdl"
WepHolster.defData["m9k_usc"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_usc"].BoneOffset = {Vector(1.5, 3.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_kac_pdw"] = {}
WepHolster.defData["m9k_kac_pdw"].Model = "models/weapons/w_kac_pdw.mdl"
WepHolster.defData["m9k_kac_pdw"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_kac_pdw"].BoneOffset = {Vector(1, 3.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_vector"] = {}
WepHolster.defData["m9k_vector"].Model = "models/weapons/w_kriss_vector.mdl"
WepHolster.defData["m9k_vector"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_vector"].BoneOffset = {Vector(0, 4.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_magpulpdr"] = {}
WepHolster.defData["m9k_magpulpdr"].Model = "models/weapons/w_magpul_pdr.mdl"
WepHolster.defData["m9k_magpulpdr"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_magpulpdr"].BoneOffset = {Vector(7, 3, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mp40"] = {}
WepHolster.defData["m9k_mp40"].Model = "models/weapons/w_mp40smg.mdl"
WepHolster.defData["m9k_mp40"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mp40"].BoneOffset = {Vector(-2, 2, 5), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mp5sd"] = {}
WepHolster.defData["m9k_mp5sd"].Model = "models/weapons/w_hk_mp5sd.mdl"
WepHolster.defData["m9k_mp5sd"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mp5sd"].BoneOffset = {Vector(-1, 5.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_mp9"] = {}
WepHolster.defData["m9k_mp9"].Model = "models/weapons/w_brugger_thomet_mp9.mdl"
WepHolster.defData["m9k_mp9"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_mp9"].BoneOffset = {Vector(2, 4, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_sten"] = {}
WepHolster.defData["m9k_sten"].Model = "models/weapons/w_sten.mdl"
WepHolster.defData["m9k_sten"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_sten"].BoneOffset = {Vector(-3, 3, 10.2), Angle(90, 100, 90)}
----------------------------------------------------------------
WepHolster.defData["m9k_tec9"] = {}
WepHolster.defData["m9k_tec9"].Model = "models/weapons/w_intratec_tec9.mdl"
WepHolster.defData["m9k_tec9"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_tec9"].BoneOffset = {Vector(0, 2, 4.2), Angle(0, 0, 90)}
----------------------------------------------------------------
WepHolster.defData["m9k_thompson"] = {}
WepHolster.defData["m9k_thompson"].Model = "models/weapons/w_tommy_gun.mdl"
WepHolster.defData["m9k_thompson"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_thompson"].BoneOffset = {Vector(5, 3.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
WepHolster.defData["m9k_uzi"] = {}
WepHolster.defData["m9k_uzi"].Model = "models/weapons/w_uzi_imi.mdl"
WepHolster.defData["m9k_uzi"].Bone = "ValveBiped.Bip01_R_Clavicle"
WepHolster.defData["m9k_uzi"].BoneOffset = {Vector(9, 2.5, 4.2), Angle(90, 0, 100)}
----------------------------------------------------------------
----------------------------------------------------------------
-- TFA
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_m16_ch"] = {}
WepHolster.defData["tfa_nmrih_m16_ch"].Model = "models/weapons/tfa_nmrih/w_fa_m16a4_carryhandle.mdl"
WepHolster.defData["tfa_nmrih_m16_ch"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_m16_ch"].BoneOffset = {Vector(4, -7, -4), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_m16_rt"] = {}
WepHolster.defData["tfa_nmrih_m16_rt"].Model = "models/weapons/tfa_nmrih/w_fa_m16a4.mdl"
WepHolster.defData["tfa_nmrih_m16_rt"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_m16_rt"].BoneOffset = {Vector(4, -7, -4), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_cz"] = {}
WepHolster.defData["tfa_nmrih_cz"].Model = "models/weapons/tfa_nmrih/w_fa_cz858.mdl"
WepHolster.defData["tfa_nmrih_cz"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_cz"].BoneOffset = {Vector(3.5, -2, -4), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sv10"] = {}
WepHolster.defData["tfa_nmrih_sv10"].Model = "models/weapons/tfa_nmrih/w_fa_sv10.mdl"
WepHolster.defData["tfa_nmrih_sv10"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_sv10"].BoneOffset = {Vector(2.8, 0, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_500a"] = {}
WepHolster.defData["tfa_nmrih_500a"].Model = "models/weapons/tfa_nmrih/w_fa_500a.mdl"
WepHolster.defData["tfa_nmrih_500a"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_500a"].BoneOffset = {Vector(3, -6, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_870"] = {}
WepHolster.defData["tfa_nmrih_870"].Model = "models/weapons/tfa_nmrih/w_fa_870.mdl"
WepHolster.defData["tfa_nmrih_870"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_870"].BoneOffset = {Vector(3.5, -5, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_1892"] = {}
WepHolster.defData["tfa_nmrih_1892"].Model = "models/weapons/tfa_nmrih/w_fa_win1892.mdl"
WepHolster.defData["tfa_nmrih_1892"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_1892"].BoneOffset = {Vector(3, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_superx3"] = {}
WepHolster.defData["tfa_nmrih_superx3"].Model = "models/weapons/tfa_nmrih/w_fa_superx3.mdl"
WepHolster.defData["tfa_nmrih_superx3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_superx3"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_fal"] = {}
WepHolster.defData["tfa_nmrih_fal"].Model = "models/weapons/tfa_nmrih/w_fa_fnfal.mdl"
WepHolster.defData["tfa_nmrih_fal"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_fal"].BoneOffset = {Vector(3.5, -7, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_jae700"] = {}
WepHolster.defData["tfa_nmrih_jae700"].Model = "models/weapons/tfa_nmrih/w_fa_jae700.mdl"
WepHolster.defData["tfa_nmrih_jae700"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_jae700"].BoneOffset = {Vector(2.8, -7, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_rug1022"] = {}
WepHolster.defData["tfa_nmrih_rug1022"].Model = "models/weapons/tfa_nmrih/w_fa_ruger1022.mdl"
WepHolster.defData["tfa_nmrih_rug1022"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_rug1022"].BoneOffset = {Vector(3.5, -3.8, -5.8), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_rug1022_25"] = {}
WepHolster.defData["tfa_nmrih_rug1022_25"].Model = "models/weapons/tfa_nmrih/w_fa_ruger1022_25mag.mdl"
WepHolster.defData["tfa_nmrih_rug1022_25"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_rug1022_25"].BoneOffset = {Vector(3.5, -3.8, -5.8), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sako"] = {}
WepHolster.defData["tfa_nmrih_sako"].Model = "models/weapons/tfa_nmrih/w_fa_sako85.mdl"
WepHolster.defData["tfa_nmrih_sako"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_sako"].BoneOffset = {Vector(3, -3.8, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sako_is"] = {}
WepHolster.defData["tfa_nmrih_sako_is"].Model = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl"
WepHolster.defData["tfa_nmrih_sako_is"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_sako_is"].BoneOffset = {Vector(3, -3.8, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sks"] = {}
WepHolster.defData["tfa_nmrih_sks"].Model = "models/weapons/tfa_nmrih/w_fa_sks.mdl"
WepHolster.defData["tfa_nmrih_sks"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_sks"].BoneOffset = {Vector(3, -5, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sks_nb"] = {}
WepHolster.defData["tfa_nmrih_sks_nb"].Model = "models/weapons/tfa_nmrih/w_fa_sks_nobayo.mdl"
WepHolster.defData["tfa_nmrih_sks_nb"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_sks_nb"].BoneOffset = {Vector(3, -5, -6), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_mp5"] = {}
WepHolster.defData["tfa_nmrih_mp5"].Model = "models/weapons/tfa_nmrih/w_fa_mp5.mdl"
WepHolster.defData["tfa_nmrih_mp5"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_mp5"].BoneOffset = {Vector(3.8, 1, 3), Angle(-10, 0, 200)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_mac10"] = {}
WepHolster.defData["tfa_nmrih_mac10"].Model = "models/weapons/tfa_nmrih/w_fa_mac10.mdl"
WepHolster.defData["tfa_nmrih_mac10"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_mac10"].BoneOffset = {Vector(4, 0, 4), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_m92fs"] = {}
WepHolster.defData["tfa_nmrih_m92fs"].Model = "models/weapons/tfa_nmrih/w_fa_m92fs.mdl"
WepHolster.defData["tfa_nmrih_m92fs"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_m92fs"].BoneOffset = {Vector(-2, -8.2, -1), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_1911"] = {}
WepHolster.defData["tfa_nmrih_1911"].Model = "models/weapons/tfa_nmrih/w_fa_1911.mdl"
WepHolster.defData["tfa_nmrih_1911"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_1911"].BoneOffset = {Vector(-2, -7.5, 1), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_g17"] = {}
WepHolster.defData["tfa_nmrih_g17"].Model = "models/weapons/tfa_nmrih/w_fa_glock17.mdl"
WepHolster.defData["tfa_nmrih_g17"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_g17"].BoneOffset = {Vector(-2, -7.5, -0.5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sw686"] = {}
WepHolster.defData["tfa_nmrih_sw686"].Model = "models/weapons/tfa_nmrih/w_fa_sw686.mdl"
WepHolster.defData["tfa_nmrih_sw686"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_sw686"].BoneOffset = {Vector(-9, -7, -0.5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_mkiii"] = {}
WepHolster.defData["tfa_nmrih_mkiii"].Model = "models/weapons/tfa_nmrih/w_fa_mkiii.mdl"
WepHolster.defData["tfa_nmrih_mkiii"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_mkiii"].BoneOffset = {Vector(0, -7.5, 1), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_flaregun"] = {}
WepHolster.defData["tfa_nmrih_flaregun"].Model = "models/weapons/tfa_nmrih/w_fa_flaregun.mdl"
WepHolster.defData["tfa_nmrih_flaregun"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_flaregun"].BoneOffset = {Vector(0, 8, -1.5), Angle(5, 270, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_bow"] = {}
WepHolster.defData["tfa_nmrih_bow"].Model = "models/weapons/tfa_nmrih/w_bow_deerhunter.mdl"
WepHolster.defData["tfa_nmrih_bow"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_bow"].BoneOffset = {Vector(3.5, -3, -5.8), Angle(0, 180, -60)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_fext"] = {}
WepHolster.defData["tfa_nmrih_fext"].Model = "models/weapons/tfa_nmrih/w_tool_extinguisher.mdl"
WepHolster.defData["tfa_nmrih_fext"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_nmrih_fext"].BoneOffset = {Vector(4, -2.5, -5.8), Angle(0, 180, 90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_tnt"] = {}
WepHolster.defData["tfa_nmrih_tnt"].Model = "models/weapons/tfa_nmrih/w_exp_tnt.mdl"
WepHolster.defData["tfa_nmrih_tnt"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_tnt"].BoneOffset = {Vector(0, 5.5, -6.5), Angle(0, 275, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_molotov"] = {}
WepHolster.defData["tfa_nmrih_molotov"].Model = "models/weapons/tfa_nmrih/w_exp_molotov.mdl"
WepHolster.defData["tfa_nmrih_molotov"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_molotov"].BoneOffset = {Vector(4.5, 2.2, -7.5), Angle(-90, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_frag"] = {}
WepHolster.defData["tfa_nmrih_frag"].Model = "models/weapons/tfa_nmrih/w_grenade.mdl"
WepHolster.defData["tfa_nmrih_frag"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_nmrih_frag"].BoneOffset = {Vector(3, 4, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_maglite"] = {}
WepHolster.defData["tfa_nmrih_maglite"].Model = "models/weapons/tfa_nmrih/w_item_maglite.mdl"
WepHolster.defData["tfa_nmrih_maglite"].Bone = "ValveBiped.Bip01_L_Thigh"
WepHolster.defData["tfa_nmrih_maglite"].BoneOffset = {Vector(0, 12, 3.8), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_welder"] = {}
WepHolster.defData["tfa_nmrih_welder"].Model = "models/weapons/tfa_nmrih/w_tool_welder.mdl"
WepHolster.defData["tfa_nmrih_welder"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_welder"].BoneOffset = {Vector(4, 0, 4), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_asaw"] = {}
WepHolster.defData["tfa_nmrih_asaw"].Model = "models/weapons/tfa_nmrih/w_me_abrasivesaw.mdl"
WepHolster.defData["tfa_nmrih_asaw"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_asaw"].BoneOffset = {Vector(4, -2, 13), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_chainsaw"] = {}
WepHolster.defData["tfa_nmrih_chainsaw"].Model = "models/weapons/tfa_nmrih/w_me_chainsaw.mdl"
WepHolster.defData["tfa_nmrih_chainsaw"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_chainsaw"].BoneOffset = {Vector(4, -1, 15), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_bat"] = {}
WepHolster.defData["tfa_nmrih_bat"].Model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
WepHolster.defData["tfa_nmrih_bat"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_bat"].BoneOffset = {Vector(1.5, 9, 5), Angle(0, 10, 90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_crowbar"] = {}
WepHolster.defData["tfa_nmrih_crowbar"].Model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
WepHolster.defData["tfa_nmrih_crowbar"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_crowbar"].BoneOffset = {Vector(3.5, 2, 4), Angle(-50, 10, 90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_fubar"] = {}
WepHolster.defData["tfa_nmrih_fubar"].Model = "models/weapons/tfa_nmrih/w_me_fubar.mdl"
WepHolster.defData["tfa_nmrih_fubar"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_fubar"].BoneOffset = {Vector(3.2, 0, 8), Angle(-30, 5, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_fireaxe"] = {}
WepHolster.defData["tfa_nmrih_fireaxe"].Model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl"
WepHolster.defData["tfa_nmrih_fireaxe"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_fireaxe"].BoneOffset = {Vector(3.8, 2, 4), Angle(-20, 10, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_lpipe"] = {}
WepHolster.defData["tfa_nmrih_lpipe"].Model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
WepHolster.defData["tfa_nmrih_lpipe"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_lpipe"].BoneOffset = {Vector(3.8, 3, 4), Angle(-20, 10, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_pickaxe"] = {}
WepHolster.defData["tfa_nmrih_pickaxe"].Model = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl"
WepHolster.defData["tfa_nmrih_pickaxe"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_pickaxe"].BoneOffset = {Vector(4.8, -2, 7), Angle(-20, 10, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_sledge"] = {}
WepHolster.defData["tfa_nmrih_sledge"].Model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
WepHolster.defData["tfa_nmrih_sledge"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_sledge"].BoneOffset = {Vector(4.8, 0, 4), Angle(-20, 10, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_spade"] = {}
WepHolster.defData["tfa_nmrih_spade"].Model = "models/weapons/tfa_nmrih/w_me_spade.mdl"
WepHolster.defData["tfa_nmrih_spade"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_spade"].BoneOffset = {Vector(4.5, 2, 4), Angle(180, -10, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_etool"] = {}
WepHolster.defData["tfa_nmrih_etool"].Model = "models/weapons/tfa_nmrih/w_me_etool.mdl"
WepHolster.defData["tfa_nmrih_etool"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_nmrih_etool"].BoneOffset = {Vector(4, 1, 2), Angle(90, 0, -98)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_cleaver"] = {}
WepHolster.defData["tfa_nmrih_cleaver"].Model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
WepHolster.defData["tfa_nmrih_cleaver"].Bone = "ValveBiped.Bip01_R_Thigh"
WepHolster.defData["tfa_nmrih_cleaver"].BoneOffset = {Vector(3, 4, -5), Angle(95, 2, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_hatchet"] = {}
WepHolster.defData["tfa_nmrih_hatchet"].Model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
WepHolster.defData["tfa_nmrih_hatchet"].Bone = "ValveBiped.Bip01_R_Thigh"
WepHolster.defData["tfa_nmrih_hatchet"].BoneOffset = {Vector(0, 10, -4), Angle(95, 2, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_kknife"] = {}
WepHolster.defData["tfa_nmrih_kknife"].Model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
WepHolster.defData["tfa_nmrih_kknife"].Bone = "ValveBiped.Bip01_R_Thigh"
WepHolster.defData["tfa_nmrih_kknife"].BoneOffset = {Vector(0, 7, -3.6), Angle(95, 1, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_machete"] = {}
WepHolster.defData["tfa_nmrih_machete"].Model = "models/weapons/tfa_nmrih/w_me_machete.mdl"
WepHolster.defData["tfa_nmrih_machete"].Bone = "ValveBiped.Bip01_R_Thigh"
WepHolster.defData["tfa_nmrih_machete"].BoneOffset = {Vector(0, 7, -3.8), Angle(95, 1, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_nmrih_bcd"] = {}
WepHolster.defData["tfa_nmrih_bcd"].Model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl"
WepHolster.defData["tfa_nmrih_bcd"].Bone = "ValveBiped.Bip01_R_Thigh"
WepHolster.defData["tfa_nmrih_bcd"].BoneOffset = {Vector(0, 7, -3.8), Angle(95, 1, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_m3"] = {}
WepHolster.defData["tfa_m3"].Model = "models/weapons/w_benelli_m3.mdl"
WepHolster.defData["tfa_m3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m3"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_browningauto5"] = {}
WepHolster.defData["tfa_browningauto5"].Model = "models/weapons/tfa_w_browning_auto.mdl"
WepHolster.defData["tfa_browningauto5"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_browningauto5"].BoneOffset = {Vector(6, 12, 7), Angle(180, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_dbarrel"] = {}
WepHolster.defData["tfa_dbarrel"].Model = "models/weapons/tfa_w_double_barrel_shotgun.mdl"
WepHolster.defData["tfa_dbarrel"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_dbarrel"].BoneOffset = {Vector(6, 12, 7), Angle(180, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ithacam37"] = {}
WepHolster.defData["tfa_ithacam37"].Model = "models/weapons/w_ithaca_m37.mdl"
WepHolster.defData["tfa_ithacam37"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ithacam37"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mossberg590"] = {}
WepHolster.defData["tfa_mossberg590"].Model = "models/weapons/w_mossberg_590.mdl"
WepHolster.defData["tfa_mossberg590"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mossberg590"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_jackhammer"] = {}
WepHolster.defData["tfa_jackhammer"].Model = "models/weapons/tfa_w_pancor_jackhammer.mdl"
WepHolster.defData["tfa_jackhammer"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_jackhammer"].BoneOffset = {Vector(3.5, 12, -2), Angle(0, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_remington870"] = {}
WepHolster.defData["tfa_remington870"].Model = "models/weapons/w_remington_870_tact.mdl"
WepHolster.defData["tfa_remington870"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_remington870"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_spas12"] = {}
WepHolster.defData["tfa_spas12"].Model = "models/weapons/w_spas_12.mdl"
WepHolster.defData["tfa_spas12"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_spas12"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_striker12"] = {}
WepHolster.defData["tfa_striker12"].Model = "models/weapons/w_striker_12g.mdl"
WepHolster.defData["tfa_striker12"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_striker12"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_usas"] = {}
WepHolster.defData["tfa_usas"].Model = "models/weapons/w_usas_12.mdl"
WepHolster.defData["tfa_usas"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_usas"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_1897winchester"] = {}
WepHolster.defData["tfa_1897winchester"].Model = "models/weapons/w_winchester_1897_trench.mdl"
WepHolster.defData["tfa_1897winchester"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_1897winchester"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_1887winchester"] = {}
WepHolster.defData["tfa_1887winchester"].Model = "models/weapons/w_winchester_1887.mdl"
WepHolster.defData["tfa_1887winchester"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_1887winchester"].BoneOffset = {Vector(3.5, -8, -5), Angle(30, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_aw50"] = {}
WepHolster.defData["tfa_aw50"].Model = "models/weapons/tfa_w_acc_int_aw50.mdl"
WepHolster.defData["tfa_aw50"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_aw50"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_barret_m82"] = {}
WepHolster.defData["tfa_barret_m82"].Model = "models/weapons/tfa_w_barret_m82.mdl"
WepHolster.defData["tfa_barret_m82"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_barret_m82"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_m98b"] = {}
WepHolster.defData["tfa_m98b"].Model = "models/weapons/tfa_w_barrett_m98b.mdl"
WepHolster.defData["tfa_m98b"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m98b"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_svu"] = {}
WepHolster.defData["tfa_svu"].Model = "models/weapons/tfa_w_dragunov_svu.mdl"
WepHolster.defData["tfa_svu"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_svu"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_sl8"] = {}
WepHolster.defData["tfa_sl8"].Model = "models/weapons/tfa_w_hk_sl8.mdl"
WepHolster.defData["tfa_sl8"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_sl8"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_intervention"] = {}
WepHolster.defData["tfa_intervention"].Model = "models/weapons/tfa_w_snip_int.mdl"
WepHolster.defData["tfa_intervention"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_intervention"].BoneOffset = {Vector(6, 4, -5), Angle(-0, 180, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m24"] = {}
WepHolster.defData["tfa_m24"].Model = "models/weapons/w_snip_m24_6.mdl"
WepHolster.defData["tfa_m24"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m24"].BoneOffset = {Vector(4, 6, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_psg1"] = {}
WepHolster.defData["tfa_psg1"].Model = "models/weapons/tfa_w_hk_psg1.mdl"
WepHolster.defData["tfa_psg1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_psg1"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_remington7615p"] = {}
WepHolster.defData["tfa_remington7615p"].Model = "models/weapons/w_remington_7615p.mdl"
WepHolster.defData["tfa_remington7615p"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_remington7615p"].BoneOffset = {Vector(6, -4, -8), Angle(-0, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_dragunov"] = {}
WepHolster.defData["tfa_dragunov"].Model = "models/weapons/tfa_w_svd_dragunov.mdl"
WepHolster.defData["tfa_dragunov"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_dragunov"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_svt40"] = {}
WepHolster.defData["tfa_svt40"].Model = "models/weapons/tfa_w_svt_40.mdl"
WepHolster.defData["tfa_svt40"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_svt40"].BoneOffset = {Vector(4, 10, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_contender"] = {}
WepHolster.defData["tfa_contender"].Model = "models/weapons/tfa_w_g2_contender.mdl"
WepHolster.defData["tfa_contender"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_contender"].BoneOffset = {Vector(2, 16, -8), Angle(-30, 90, 30)}
----------------------------------------------------------------
WepHolster.defData["tfa_ares_shrike"] = {}
WepHolster.defData["tfa_ares_shrike"].Model = "models/weapons/tfa_w_ares_shrike.mdl"
WepHolster.defData["tfa_ares_shrike"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ares_shrike"].BoneOffset = {Vector(8, 10, 8), Angle(-35, 90, -140)}
----------------------------------------------------------------
WepHolster.defData["tfa_fg42"] = {}
WepHolster.defData["tfa_fg42"].Model = "models/weapons/tfa_w_fg42.mdl"
WepHolster.defData["tfa_fg42"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_fg42"].BoneOffset = {Vector(6, 10, 8), Angle(-35, 90, -140)}
----------------------------------------------------------------
WepHolster.defData["tfa_minigun"] = {}
WepHolster.defData["tfa_minigun"].Model = "models/weapons/tfa_w_m134_minigun.mdl"
WepHolster.defData["tfa_minigun"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_minigun"].BoneOffset = {Vector(8, 20, 0), Angle(-35, 90, -140)}
----------------------------------------------------------------
WepHolster.defData["tfa_m1918bar"] = {}
WepHolster.defData["tfa_m1918bar"].Model = "models/weapons/tfa_w_m1918_bar.mdl"
WepHolster.defData["tfa_m1918bar"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m1918bar"].BoneOffset = {Vector(6, 16, 8), Angle(-35, 90, -140)}
----------------------------------------------------------------
WepHolster.defData["tfa_m249lmg"] = {}
WepHolster.defData["tfa_m249lmg"].Model = "models/weapons/tfa_w_m249_machine_gun.mdl"
WepHolster.defData["tfa_m249lmg"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m249lmg"].BoneOffset = {Vector(8, 10, 8), Angle(-35, 90, -140)}
----------------------------------------------------------------
WepHolster.defData["tfa_m60"] = {}
WepHolster.defData["tfa_m60"].Model = "models/weapons/w_m60_machine_gun.mdl"
WepHolster.defData["tfa_m60"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m60"].BoneOffset = {Vector(-3, -10, 4), Angle(-85, 180, -165)}
----------------------------------------------------------------
WepHolster.defData["tfa_pkm"] = {}
WepHolster.defData["tfa_pkm"].Model = "models/weapons/w_mach_russ_pkm.mdl"
WepHolster.defData["tfa_pkm"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pkm"].BoneOffset = {Vector(4, 10, 4), Angle(-90, 0, -180)}
----------------------------------------------------------------
WepHolster.defData["tfa_ak47"] = {}
WepHolster.defData["tfa_ak47"].Model = "models/weapons/tfa_w_ak47_tfa.mdl"
WepHolster.defData["tfa_ak47"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ak47"].BoneOffset = {Vector(2.8, -12, -1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ak74"] = {}
WepHolster.defData["tfa_ak74"].Model = "models/weapons/tfa_w_tct_ak47.mdl"
WepHolster.defData["tfa_ak74"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ak74"].BoneOffset = {Vector(3.8, 2, -4), Angle(-175, -180, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_amd65"] = {}
WepHolster.defData["tfa_amd65"].Model = "models/weapons/tfa_w_amd_65.mdl"
WepHolster.defData["tfa_amd65"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_amd65"].BoneOffset = {Vector(3.4, -12, -1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_auga3"] = {}
WepHolster.defData["tfa_auga3"].Model = "models/weapons/tfa_w_auga3.mdl"
WepHolster.defData["tfa_auga3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_auga3"].BoneOffset = {Vector(4, -6, -1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_l85"] = {}
WepHolster.defData["tfa_l85"].Model = "models/weapons/tfa_w_l85a2.mdl"
WepHolster.defData["tfa_l85"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_l85"].BoneOffset = {Vector(3.8, -6, -1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m16a4_acog"] = {}
WepHolster.defData["tfa_m16a4_acog"].Model = "models/weapons/tfa_w_dmg_m16ag.mdl"
WepHolster.defData["tfa_m16a4_acog"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m16a4_acog"].BoneOffset = {Vector(3.7, 2, -4), Angle(-175, -180, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m4a1"] = {}
WepHolster.defData["tfa_m4a1"].Model = "models/weapons/tfa_w_m4a1_iron.mdl"
WepHolster.defData["tfa_m4a1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m4a1"].BoneOffset = {Vector(4.7, 3, -2), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_winchester73"] = {}
WepHolster.defData["tfa_winchester73"].Model = "models/weapons/tfa_w_winchester_1873.mdl"
WepHolster.defData["tfa_winchester73"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_winchester73"].BoneOffset = {Vector(3.3, -12, 0), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_acr"] = {}
WepHolster.defData["tfa_acr"].Model = "models/weapons/tfa_w_masada_acr.mdl"
WepHolster.defData["tfa_acr"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_acr"].BoneOffset = {Vector(3.3, -10, 0), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_val"] = {}
WepHolster.defData["tfa_val"].Model = "models/weapons/tfa_w_dmg_vally.mdl"
WepHolster.defData["tfa_val"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_val"].BoneOffset = {Vector(3.6, 1, -6), Angle(-175, -180, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_an94"] = {}
WepHolster.defData["tfa_an94"].Model = "models/weapons/tfa_w_rif_an_94.mdl"
WepHolster.defData["tfa_an94"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_an94"].BoneOffset = {Vector(3.6, 4, -4.5), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_f2000"] = {}
WepHolster.defData["tfa_f2000"].Model = "models/weapons/tfa_w_fn_f2000.mdl"
WepHolster.defData["tfa_f2000"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_f2000"].BoneOffset = {Vector(3.5, -8, 2), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_famas"] = {}
WepHolster.defData["tfa_famas"].Model = "models/weapons/tfa_w_tct_famas.mdl"
WepHolster.defData["tfa_famas"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_famas"].BoneOffset = {Vector(3.6, 4, -4.5), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_fal"] = {}
WepHolster.defData["tfa_fal"].Model = "models/weapons/tfa_w_fn_fal.mdl"
WepHolster.defData["tfa_fal"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_fal"].BoneOffset = {Vector(3.6, 4, -4.5), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_g36"] = {}
WepHolster.defData["tfa_g36"].Model = "models/weapons/tfa_w_hk_g36c.mdl"
WepHolster.defData["tfa_g36"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_g36"].BoneOffset = {Vector(3.5, -8, 1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m416"] = {}
WepHolster.defData["tfa_m416"].Model = "models/weapons/tfa_w_hk_416.mdl"
WepHolster.defData["tfa_m416"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m416"].BoneOffset = {Vector(3.5, -10, 0), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_g3a3"] = {}
WepHolster.defData["tfa_g3a3"].Model = "models/weapons/tfa_w_hk_g3.mdl"
WepHolster.defData["tfa_g3a3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_g3a3"].BoneOffset = {Vector(3.3, -10, 0), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m14sp"] = {}
WepHolster.defData["tfa_m14sp"].Model = "models/weapons/tfa_w_snip_m14sp.mdl"
WepHolster.defData["tfa_m14sp"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m14sp"].BoneOffset = {Vector(3.6, 4, -3), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_scar"] = {}
WepHolster.defData["tfa_scar"].Model = "models/weapons/tfa_w_fn_scar_h.mdl"
WepHolster.defData["tfa_scar"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_scar"].BoneOffset = {Vector(3.3, -10, 0), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_vikhr"] = {}
WepHolster.defData["tfa_vikhr"].Model = "models/weapons/tfa_w_dmg_vikhr.mdl"
WepHolster.defData["tfa_vikhr"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_vikhr"].BoneOffset = {Vector(3.6, 7, -4), Angle(-175, -180, -10)}
----------------------------------------------------------------
WepHolster.defData["tfa_tar21"] = {}
WepHolster.defData["tfa_tar21"].Model = "models/weapons/tfa_w_imi_tar21.mdl"
WepHolster.defData["tfa_tar21"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_tar21"].BoneOffset = {Vector(3.3, -2, -1), Angle(-175, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_honeybadger"] = {}
WepHolster.defData["tfa_honeybadger"].Model = "models/weapons/tfa_w_aac_honeybadger.mdl"
WepHolster.defData["tfa_honeybadger"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_honeybadger"].BoneOffset = {Vector(5.3, -8, -1), Angle(0, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_bizonp19"] = {}
WepHolster.defData["tfa_bizonp19"].Model = "models/weapons/tfa_w_pp19_bizon.mdl"
WepHolster.defData["tfa_bizonp19"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_bizonp19"].BoneOffset = {Vector(5.3, -8, -1), Angle(0, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_smgp90"] = {}
WepHolster.defData["tfa_smgp90"].Model = "models/weapons/tfa_w_fn_p90.mdl"
WepHolster.defData["tfa_smgp90"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_smgp90"].BoneOffset = {Vector(5.3, -2, 0.5), Angle(0, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mp5"] = {}
WepHolster.defData["tfa_mp5"].Model = "models/weapons/tfa_w_hk_mp5.mdl"
WepHolster.defData["tfa_mp5"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mp5"].BoneOffset = {Vector(5.3, -8, -1), Angle(0, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mp7"] = {}
WepHolster.defData["tfa_mp7"].Model = "models/weapons/tfa_w_mp7_silenced.mdl"
WepHolster.defData["tfa_mp7"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mp7"].BoneOffset = {Vector(5.5, 2, 4), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ump45"] = {}
WepHolster.defData["tfa_ump45"].Model = "models/weapons/tfa_w_hk_ump45.mdl"
WepHolster.defData["tfa_ump45"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ump45"].BoneOffset = {Vector(6, -8, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_usc"] = {}
WepHolster.defData["tfa_usc"].Model = "models/weapons/tfa_w_hk_usc.mdl"
WepHolster.defData["tfa_usc"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_usc"].BoneOffset = {Vector(6, -8, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_kac_pdw"] = {}
WepHolster.defData["tfa_kac_pdw"].Model = "models/weapons/tfa_w_kac_pdw.mdl"
WepHolster.defData["tfa_kac_pdw"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_kac_pdw"].BoneOffset = {Vector(6, -8, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_vector"] = {}
WepHolster.defData["tfa_vector"].Model = "models/weapons/tfa_w_kriss_vector.mdl"
WepHolster.defData["tfa_vector"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_vector"].BoneOffset = {Vector(6, -8, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_magpulpdr"] = {}
WepHolster.defData["tfa_magpulpdr"].Model = "models/weapons/tfa_w_magpul_pdr.mdl"
WepHolster.defData["tfa_magpulpdr"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_magpulpdr"].BoneOffset = {Vector(6, -2, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mp40"] = {}
WepHolster.defData["tfa_mp40"].Model = "models/weapons/tfa_w_mp40smg.mdl"
WepHolster.defData["tfa_mp40"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mp40"].BoneOffset = {Vector(4.8, 2, 4), Angle(-10, -180, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mp5sd"] = {}
WepHolster.defData["tfa_mp5sd"].Model = "models/weapons/tfa_w_hk_mp5sd.mdl"
WepHolster.defData["tfa_mp5sd"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mp5sd"].BoneOffset = {Vector(6, -9, 0), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_mp9"] = {}
WepHolster.defData["tfa_mp9"].Model = "models/weapons/tfa_w_brugger_thomet_mp9.mdl"
WepHolster.defData["tfa_mp9"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_mp9"].BoneOffset = {Vector(5.5, -9, 1), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_sten"] = {}
WepHolster.defData["tfa_sten"].Model = "models/weapons/tfa_w_sten.mdl"
WepHolster.defData["tfa_sten"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_sten"].BoneOffset = {Vector(4.5, -9, 8), Angle(-180, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_tec9"] = {}
WepHolster.defData["tfa_tec9"].Model = "models/weapons/tfa_w_intratec_tec9.mdl"
WepHolster.defData["tfa_tec9"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_tec9"].BoneOffset = {Vector(6, -9, 1), Angle(-10, 90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_thompson"] = {}
WepHolster.defData["tfa_thompson"].Model = "models/weapons/tfa_w_tommy_gun.mdl"
WepHolster.defData["tfa_thompson"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_thompson"].BoneOffset = {Vector(5, -5, 3), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_uzi"] = {}
WepHolster.defData["tfa_uzi"].Model = "models/weapons/tfa_wuzi_imi.mdl"
WepHolster.defData["tfa_uzi"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_uzi"].BoneOffset = {Vector(5.5, -2, 1), Angle(-10, -90, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_coltpython"] = {}
WepHolster.defData["tfa_coltpython"].Model = "models/weapons/tfa_wcolt_python.mdl"
WepHolster.defData["tfa_coltpython"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_coltpython"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_m29satan"] = {}
WepHolster.defData["tfa_m29satan"].Model = "models/weapons/tfa_w_m29_satan.mdl"
WepHolster.defData["tfa_m29satan"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_m29satan"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_remington1858"] = {}
WepHolster.defData["tfa_remington1858"].Model = "models/weapons/tfa_w_remington_1858.mdl"
WepHolster.defData["tfa_remington1858"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_remington1858"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_ragingbull"] = {}
WepHolster.defData["tfa_ragingbull"].Model = "models/weapons/tfa_w_taurus_raging_bull.mdl"
WepHolster.defData["tfa_ragingbull"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_ragingbull"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_scoped_taurus"] = {}
WepHolster.defData["tfa_scoped_taurus"].Model = "models/weapons/tfa_w_raging_bull_scoped.mdl"
WepHolster.defData["tfa_scoped_taurus"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_scoped_taurus"].BoneOffset = {Vector(-1, -9, -4), Angle(5, 180, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_model3russian"] = {}
WepHolster.defData["tfa_model3russian"].Model = "models/weapons/tfa_w_model_3_rus.mdl"
WepHolster.defData["tfa_model3russian"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_model3russian"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_model500"] = {}
WepHolster.defData["tfa_model500"].Model = "models/weapons/tfa_w_sw_model_500.mdl"
WepHolster.defData["tfa_model500"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_model500"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_model627"] = {}
WepHolster.defData["tfa_model627"].Model = "models/weapons/tfa_w_sw_model_627.mdl"
WepHolster.defData["tfa_model627"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_model627"].BoneOffset = {Vector(-1, -9.5, -4), Angle(5, 360, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_colt1911"] = {}
WepHolster.defData["tfa_colt1911"].Model = "models/weapons/tfa_w__dmgf_co1911.mdl"
WepHolster.defData["tfa_colt1911"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_colt1911"].BoneOffset = {Vector(5, -7, 0), Angle(-90, 90, 95)}
----------------------------------------------------------------
WepHolster.defData["tfa_deagle"] = {}
WepHolster.defData["tfa_deagle"].Model = "models/weapons/tfa_w_tcom_deagle.mdl"
WepHolster.defData["tfa_deagle"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_deagle"].BoneOffset = {Vector(5, -7, 0), Angle(-90, 90, 95)}
----------------------------------------------------------------
WepHolster.defData["tfa_glock"] = {}
WepHolster.defData["tfa_glock"].Model = "models/weapons/tfa_w_dmg_glock.mdl"
WepHolster.defData["tfa_glock"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_glock"].BoneOffset = {Vector(5, -7, 0), Angle(-90, 90, 95)}
----------------------------------------------------------------
WepHolster.defData["tfa_usp"] = {}
WepHolster.defData["tfa_usp"].Model = "models/weapons/tfa_w_pist_fokkususp.mdl"
WepHolster.defData["tfa_usp"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_usp"].BoneOffset = {Vector(5, -7, 0), Angle(-90, 90, 95)}
----------------------------------------------------------------
WepHolster.defData["tfa_m92beretta"] = {}
WepHolster.defData["tfa_m92beretta"].Model = "models/weapons/tfa_w_beretta_m92.mdl"
WepHolster.defData["tfa_m92beretta"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_m92beretta"].BoneOffset = {Vector(0, -8.8, -4), Angle(0, 360, -360)}
----------------------------------------------------------------
WepHolster.defData["tfa_hk45"] = {}
WepHolster.defData["tfa_hk45"].Model = "models/weapons/tfa_w_hk45c.mdl"
WepHolster.defData["tfa_hk45"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_hk45"].BoneOffset = {Vector(0, -9, -4), Angle(0, 360, -360)}
----------------------------------------------------------------
WepHolster.defData["tfa_sig_p229r"] = {}
WepHolster.defData["tfa_sig_p229r"].Model = "models/weapons/tfa_w_sig_229r.mdl"
WepHolster.defData["tfa_sig_p229r"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_sig_p229r"].BoneOffset = {Vector(0, -9, -4), Angle(0, 360, -360)}
----------------------------------------------------------------
WepHolster.defData["tfa_luger"] = {}
WepHolster.defData["tfa_luger"].Model = "models/weapons/tfa_w_luger_p08.mdl"
WepHolster.defData["tfa_luger"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_luger"].BoneOffset = {Vector(0, -9, -4), Angle(0, 360, -360)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_ak47"] = {}
WepHolster.defData["tfa_csgo_ak47"].Model = "models/weapons/tfa_csgo/w_ak47.mdl"
WepHolster.defData["tfa_csgo_ak47"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_ak47"].BoneOffset = {Vector(3.8, -3, -3), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_aug"] = {}
WepHolster.defData["tfa_csgo_aug"].Model = "models/weapons/tfa_csgo/w_aug.mdl"
WepHolster.defData["tfa_csgo_aug"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_aug"].BoneOffset = {Vector(3.8, 2, -5.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_awp"] = {}
WepHolster.defData["tfa_csgo_awp"].Model = "models/weapons/tfa_csgo/w_awp.mdl"
WepHolster.defData["tfa_csgo_awp"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_awp"].BoneOffset = {Vector(3.8, -6, -3.5), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_famas"] = {}
WepHolster.defData["tfa_csgo_famas"].Model = "models/weapons/tfa_csgo/w_famas.mdl"
WepHolster.defData["tfa_csgo_famas"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_famas"].BoneOffset = {Vector(3.8, 2, -5.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_galil"] = {}
WepHolster.defData["tfa_csgo_galil"].Model = "models/weapons/tfa_csgo/w_galil.mdl"
WepHolster.defData["tfa_csgo_galil"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_galil"].BoneOffset = {Vector(3.8, -2, -5.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_m249"] = {}
WepHolster.defData["tfa_csgo_m249"].Model = "models/weapons/tfa_csgo/w_m249.mdl"
WepHolster.defData["tfa_csgo_m249"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_m249"].BoneOffset = {Vector(3.8, 2, -5.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_m4a1"] = {}
WepHolster.defData["tfa_csgo_m4a1"].Model = "models/weapons/tfa_csgo/w_m4a1.mdl"
WepHolster.defData["tfa_csgo_m4a1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_m4a1"].BoneOffset = {Vector(3.8, 0, -2.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_m4a4"] = {}
WepHolster.defData["tfa_csgo_m4a4"].Model = "models/weapons/tfa_csgo/w_m4a4.mdl"
WepHolster.defData["tfa_csgo_m4a4"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_m4a4"].BoneOffset = {Vector(3.8, 0, -3.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_negev"] = {}
WepHolster.defData["tfa_csgo_negev"].Model = "models/weapons/tfa_csgo/w_negev.mdl"
WepHolster.defData["tfa_csgo_negev"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_negev"].BoneOffset = {Vector(4.5, -6, -0.5), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_sg556"] = {}
WepHolster.defData["tfa_csgo_sg556"].Model = "models/weapons/tfa_csgo/w_sg556.mdl"
WepHolster.defData["tfa_csgo_sg556"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_sg556"].BoneOffset = {Vector(3.8, 0, -3.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_nova"] = {}
WepHolster.defData["tfa_csgo_nova"].Model = "models/weapons/tfa_csgo/w_nova.mdl"
WepHolster.defData["tfa_csgo_nova"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_nova"].BoneOffset = {Vector(3.8, 0, -4.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_xm1014"] = {}
WepHolster.defData["tfa_csgo_xm1014"].Model = "models/weapons/tfa_csgo/w_xm1014.mdl"
WepHolster.defData["tfa_csgo_xm1014"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_xm1014"].BoneOffset = {Vector(3.8, 0, -4.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_scar20"] = {}
WepHolster.defData["tfa_csgo_scar20"].Model = "models/weapons/tfa_csgo/w_scar20.mdl"
WepHolster.defData["tfa_csgo_scar20"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_scar20"].BoneOffset = {Vector(3.8, 0, -4.5), Angle(-175, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_g3sg1"] = {}
WepHolster.defData["tfa_csgo_g3sg1"].Model = "models/weapons/tfa_csgo/w_g3sg1.mdl"
WepHolster.defData["tfa_csgo_g3sg1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_g3sg1"].BoneOffset = {Vector(3.8, 0, -4.5), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_ssg08"] = {}
WepHolster.defData["tfa_csgo_ssg08"].Model = "models/weapons/tfa_csgo/w_scout.mdl"
WepHolster.defData["tfa_csgo_ssg08"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_ssg08"].BoneOffset = {Vector(3.8, -10, -1.5), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_mp5"] = {}
WepHolster.defData["tfa_csgo_mp5"].Model = "models/weapons/tfa_csgo/w_mp5.mdl"
WepHolster.defData["tfa_csgo_mp5"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_mp5"].BoneOffset = {Vector(3.5, 1, 8), Angle(-10, 0, 200)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_p90"] = {}
WepHolster.defData["tfa_csgo_p90"].Model = "models/weapons/tfa_csgo/w_p90.mdl"
WepHolster.defData["tfa_csgo_p90"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_p90"].BoneOffset = {Vector(3.5, 4, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_sawedoff"] = {}
WepHolster.defData["tfa_csgo_sawedoff"].Model = "models/weapons/tfa_csgo/w_sawedoff.mdl"
WepHolster.defData["tfa_csgo_sawedoff"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_sawedoff"].BoneOffset = {Vector(3.5, 2, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_ump45"] = {}
WepHolster.defData["tfa_csgo_ump45"].Model = "models/weapons/tfa_csgo/w_ump45.mdl"
WepHolster.defData["tfa_csgo_ump45"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_ump45"].BoneOffset = {Vector(3.5, 2, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_bizon"] = {}
WepHolster.defData["tfa_csgo_bizon"].Model = "models/weapons/tfa_csgo/w_bizon.mdl"
WepHolster.defData["tfa_csgo_bizon"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_bizon"].BoneOffset = {Vector(3.5, 2, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_mp7"] = {}
WepHolster.defData["tfa_csgo_mp7"].Model = "models/weapons/tfa_csgo/w_mp7.mdl"
WepHolster.defData["tfa_csgo_mp7"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_csgo_mp7"].BoneOffset = {Vector(5, -4, 2), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_mac10"] = {}
WepHolster.defData["tfa_csgo_mac10"].Model = "models/weapons/tfa_csgo/w_mac10.mdl"
WepHolster.defData["tfa_csgo_mac10"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_csgo_mac10"].BoneOffset = {Vector(5, -4, 3), Angle(-10, 0, 160)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_tec9"] = {}
WepHolster.defData["tfa_csgo_tec9"].Model = "models/weapons/tfa_csgo/w_tec9.mdl"
WepHolster.defData["tfa_csgo_tec9"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["tfa_csgo_tec9"].BoneOffset = {Vector(5, -4, 2), Angle(-10, 0, 160)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_mag7"] = {}
WepHolster.defData["tfa_csgo_mag7"].Model = "models/weapons/tfa_csgo/w_mag7.mdl"
WepHolster.defData["tfa_csgo_mag7"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_mag7"].BoneOffset = {Vector(3.5, 2, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_mp9"] = {}
WepHolster.defData["tfa_csgo_mp9"].Model = "models/weapons/tfa_csgo/w_mp9.mdl"
WepHolster.defData["tfa_csgo_mp9"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_csgo_mp9"].BoneOffset = {Vector(3.5, 3, 4), Angle(-10, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_cz75"] = {}
WepHolster.defData["tfa_csgo_cz75"].Model = "models/weapons/tfa_csgo/w_cz75.mdl"
WepHolster.defData["tfa_csgo_cz75"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_cz75"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_deagle"] = {}
WepHolster.defData["tfa_csgo_deagle"].Model = "models/weapons/tfa_csgo/w_deagle.mdl"
WepHolster.defData["tfa_csgo_deagle"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_deagle"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_fiveseven"] = {}
WepHolster.defData["tfa_csgo_fiveseven"].Model = "models/weapons/tfa_csgo/w_fiveseven.mdl"
WepHolster.defData["tfa_csgo_fiveseven"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_fiveseven"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_glock18"] = {}
WepHolster.defData["tfa_csgo_glock18"].Model = "models/weapons/tfa_csgo/w_glock18.mdl"
WepHolster.defData["tfa_csgo_glock18"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_glock18"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_p2000"] = {}
WepHolster.defData["tfa_csgo_p2000"].Model = "models/weapons/tfa_csgo/w_p2000.mdl"
WepHolster.defData["tfa_csgo_p2000"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_p2000"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_p250"] = {}
WepHolster.defData["tfa_csgo_p250"].Model = "models/weapons/tfa_csgo/w_p250.mdl"
WepHolster.defData["tfa_csgo_p250"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_p250"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_revolver"] = {}
WepHolster.defData["tfa_csgo_revolver"].Model = "models/weapons/tfa_csgo/w_revolver.mdl"
WepHolster.defData["tfa_csgo_revolver"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_revolver"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_usp"] = {}
WepHolster.defData["tfa_csgo_usp"].Model = "models/weapons/tfa_csgo/w_usp.mdl"
WepHolster.defData["tfa_csgo_usp"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_usp"].BoneOffset = {Vector(3, -8, -1), Angle(5, 272, -75)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_flash"] = {}
WepHolster.defData["tfa_csgo_flash"].Model = "models/weapons/tfa_csgo/w_flash.mdl"
WepHolster.defData["tfa_csgo_flash"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_flash"].BoneOffset = {Vector(0, 5.5, -6.5), Angle(0, 275, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_molly"] = {}
WepHolster.defData["tfa_csgo_molly"].Model = "models/weapons/tfa_csgo/w_molotov.mdl"
WepHolster.defData["tfa_csgo_molly"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_molly"].BoneOffset = {Vector(-2.5, 2.2, -7.5), Angle(-90, 90, -180)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_frag"] = {}
WepHolster.defData["tfa_csgo_frag"].Model = "models/weapons/tfa_csgo/w_frag.mdl"
WepHolster.defData["tfa_csgo_frag"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_frag"].BoneOffset = {Vector(2, 4, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_incen"] = {}
WepHolster.defData["tfa_csgo_incen"].Model = "models/weapons/tfa_csgo/w_incend.mdl"
WepHolster.defData["tfa_csgo_incen"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_incen"].BoneOffset = {Vector(1, 7.5, 3), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_smoke"] = {}
WepHolster.defData["tfa_csgo_smoke"].Model = "models/weapons/tfa_csgo/w_smoke.mdl"
WepHolster.defData["tfa_csgo_smoke"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_smoke"].BoneOffset = {Vector(1, -5, 5), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_csgo_decoy"] = {}
WepHolster.defData["tfa_csgo_decoy"].Model = "models/weapons/tfa_csgo/w_decoy.mdl"
WepHolster.defData["tfa_csgo_decoy"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_csgo_decoy"].BoneOffset = {Vector(.5, -1.5, -8), Angle(-90, 90, -180)}
----------------------------------------------------------------
WepHolster.defData["dod_k98"] = {}
WepHolster.defData["dod_k98"].Model = "models/weapons/w_k98.mdl"
WepHolster.defData["dod_k98"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_k98"].BoneOffset = {Vector(3.8, -12, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_k98_g"] = {}
WepHolster.defData["dod_k98_g"].Model = "models/weapons/w_k98_rg.mdl"
WepHolster.defData["dod_k98_g"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_k98_g"].BoneOffset = {Vector(3.8, -12, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_k98_scope"] = {}
WepHolster.defData["dod_k98_scope"].Model = "models/weapons/w_k98s.mdl"
WepHolster.defData["dod_k98_scope"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_k98_scope"].BoneOffset = {Vector(3.8, -12, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_carbine"] = {}
WepHolster.defData["dod_carbine"].Model = "models/weapons/w_m1carb.mdl"
WepHolster.defData["dod_carbine"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_carbine"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_garand"] = {}
WepHolster.defData["dod_garand"].Model = "models/weapons/w_garand.mdl"
WepHolster.defData["dod_garand"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_garand"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_garand_g"] = {}
WepHolster.defData["dod_garand_g"].Model = "models/weapons/w_k98_rg.mdl"
WepHolster.defData["dod_garand_g"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_garand_g"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1903"] = {}
WepHolster.defData["dod_m1903"].Model = "models/weapons/w_spring.mdl"
WepHolster.defData["dod_m1903"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1903"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1918"] = {}
WepHolster.defData["dod_m1918"].Model = "models/weapons/w_bar.mdl"
WepHolster.defData["dod_m1918"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1918"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1919"] = {}
WepHolster.defData["dod_m1919"].Model = "models/weapons/w_30cal.mdl"
WepHolster.defData["dod_m1919"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1919"].BoneOffset = {Vector(4.5, -20, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_mg42"] = {}
WepHolster.defData["dod_mg42"].Model = "models/weapons/w_mg42bu.mdl"
WepHolster.defData["dod_mg42"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_mg42"].BoneOffset = {Vector(4.5, -15, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_stg44"] = {}
WepHolster.defData["dod_stg44"].Model = "models/weapons/w_mp44.mdl"
WepHolster.defData["dod_stg44"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_stg44"].BoneOffset = {Vector(4.5, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_t20"] = {}
WepHolster.defData["dod_t20"].Model = "models/weapons/w_garand.mdl"
WepHolster.defData["dod_t20"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_t20"].BoneOffset = {Vector(4.5, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1928"] = {}
WepHolster.defData["dod_m1928"].Model = "models/weapons/w_thompson.mdl"
WepHolster.defData["dod_m1928"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1928"].BoneOffset = {Vector(4.5, -4, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1a1"] = {}
WepHolster.defData["dod_m1a1"].Model = "models/weapons/w_thompson.mdl"
WepHolster.defData["dod_m1a1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1a1"].BoneOffset = {Vector(4.5, -4, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1a1_carbine"] = {}
WepHolster.defData["dod_m1a1_carbine"].Model = "models/weapons/w_m1carb.mdl"
WepHolster.defData["dod_m1a1_carbine"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m1a1_carbine"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m2"] = {}
WepHolster.defData["dod_m2"].Model = "models/weapons/w_m1carb.mdl"
WepHolster.defData["dod_m2"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_m2"].BoneOffset = {Vector(3.8, -10, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_bazooka"] = {}
WepHolster.defData["dod_bazooka"].Model = "models/weapons/w_bazooka.mdl"
WepHolster.defData["dod_bazooka"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_bazooka"].BoneOffset = {Vector(4.8, 2, 1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_panzer"] = {}
WepHolster.defData["dod_panzer"].Model = "models/weapons/w_pschreck.mdl"
WepHolster.defData["dod_panzer"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_panzer"].BoneOffset = {Vector(4.8, 2, 1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_mp40"] = {}
WepHolster.defData["dod_mp40"].Model = "models/weapons/w_mp40.mdl"
WepHolster.defData["dod_mp40"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_mp40"].BoneOffset = {Vector(6, -9, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_c96"] = {}
WepHolster.defData["dod_c96"].Model = "models/weapons/w_c96.mdl"
WepHolster.defData["dod_c96"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_c96"].BoneOffset = {Vector(6, 1, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_m1911"] = {}
WepHolster.defData["dod_m1911"].Model = "models/weapons/w_colt.mdl"
WepHolster.defData["dod_m1911"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_m1911"].BoneOffset = {Vector(0, -8.8, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["dod_p38"] = {}
WepHolster.defData["dod_p38"].Model = "models/weapons/w_p38.mdl"
WepHolster.defData["dod_p38"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_p38"].BoneOffset = {Vector(0, -9, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["dod_welrod"] = {}
WepHolster.defData["dod_welrod"].Model = "models/weapons/welrod.mdl"
WepHolster.defData["dod_welrod"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_welrod"].BoneOffset = {Vector(0, -9, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["dod_frag"] = {}
WepHolster.defData["dod_frag"].Model = "models/weapons/w_frag.mdl"
WepHolster.defData["dod_frag"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_frag"].BoneOffset = {Vector(2, 4, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_stick"] = {}
WepHolster.defData["dod_stick"].Model = "models/weapons/w_stick.mdl"
WepHolster.defData["dod_stick"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_stick"].BoneOffset = {Vector(2, 4, 6), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_smoke_ger"] = {}
WepHolster.defData["dod_smoke_ger"].Model = "models/weapons/w_smoke_ger.mdl"
WepHolster.defData["dod_smoke_ger"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_smoke_ger"].BoneOffset = {Vector(1, -5, 5), Angle(-95, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["dod_smoke_us"] = {}
WepHolster.defData["dod_smoke_us"].Model = "models/weapons/w_smoke_us.mdl"
WepHolster.defData["dod_smoke_us"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["dod_smoke_us"].BoneOffset = {Vector(.5, -1.5, -8), Angle(-90, 90, -180)}
----------------------------------------------------------------
WepHolster.defData["dod_spade"] = {}
WepHolster.defData["dod_spade"].Model = "models/weapons/w_spade.mdl"
WepHolster.defData["dod_spade"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["dod_spade"].BoneOffset = {Vector(6, -1, 1), Angle(-10, 0, 90)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_c96_carbine_long"] = {}
WepHolster.defData["tfa_pig_doi_c96_carbine_long"].Model = "models/weapons/doi_weapons_prem/w_tfa_pig_c96_carbine_long.mdl"
WepHolster.defData["tfa_pig_doi_c96_carbine_long"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_c96_carbine_long"].BoneOffset = {Vector(4.8, -6, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_g43"] = {}
WepHolster.defData["tfa_pig_doi_g43"].Model = "models/weapons/doi_weapons_prem/w_tfa_pig_gewehr.mdl"
WepHolster.defData["tfa_pig_doi_g43"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_g43"].BoneOffset = {Vector(4.8, -6, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_g43_scoped"] = {}
WepHolster.defData["tfa_pig_doi_g43_scoped"].Model = "models/weapons/doi_weapons_prem/w_tfa_pig_gewehr_scoped.mdl"
WepHolster.defData["tfa_pig_doi_g43_scoped"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_g43_scoped"].BoneOffset = {Vector(4.8, -6, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_kar98k"] = {}
WepHolster.defData["tfa_pig_doi_kar98k"].Model = "models/weapons/doi_weapons_prem/w_tfa_pig_kar98k.mdl"
WepHolster.defData["tfa_pig_doi_kar98k"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_kar98k"].BoneOffset = {Vector(4.8, -1, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_kar98k_scoped"] = {}
WepHolster.defData["tfa_pig_doi_kar98k_scoped"].Model = "models/weapons/doi_weapons_prem/w_tfa_pig_kar98k_scoped.mdl"
WepHolster.defData["tfa_pig_doi_kar98k_scoped"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_kar98k_scoped"].BoneOffset = {Vector(4.8, -1, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_kar98b"] = {}
WepHolster.defData["tfa_pig_doi_kar98b"].Model = "models/weapons/dpi_weapon_perm/w_tfa_pig_kar98k.mdl"
WepHolster.defData["tfa_pig_doi_kar98b"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_kar98b"].BoneOffset = {Vector(4.8, -1, -1), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_mp40"] = {}
WepHolster.defData["tfa_pig_doi_mp40"].Model = "models/weapons/dpi_weapon_perm/w_tfa_pig_mp40.mdl"
WepHolster.defData["tfa_pig_doi_mp40"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_mp40"].BoneOffset = {Vector(5.5, -8, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_stg44"] = {}
WepHolster.defData["tfa_pig_doi_stg44"].Model = "models/weapons/tfa_pig_doi/w_tfa_pig_stg44.mdl"
WepHolster.defData["tfa_pig_doi_stg44"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_stg44"].BoneOffset = {Vector(5.5, 2, 4), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cod4_ak_new"] = {}
WepHolster.defData["cod4_ak_new"].Model = "models/weapons/w_cod4_ak47_c.mdl"
WepHolster.defData["cod4_ak_new"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_ak_new"].BoneOffset = {Vector(5.5, -3, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_74u_new"] = {}
WepHolster.defData["cod4_74u_new"].Model = "models/weapons/w_cod4_ak74u_c.mdl"
WepHolster.defData["cod4_74u_new"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_74u_new"].BoneOffset = {Vector(5.5, -3, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_barrett_new"] = {}
WepHolster.defData["cod4_barrett_new"].Model = "models/weapons/w_cod4_barrett50cal.mdl"
WepHolster.defData["cod4_barrett_new"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_barrett_new"].BoneOffset = {Vector(5.5, -8, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_dragunov_c"] = {}
WepHolster.defData["cod4_dragunov_c"].Model = "models/weapons/w_cod4_drag.mdl"
WepHolster.defData["cod4_dragunov_c"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_dragunov_c"].BoneOffset = {Vector(5.5, -9, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_g3"] = {}
WepHolster.defData["cod4_g3"].Model = "models/weapons/w_cod4_g3_new.mdl"
WepHolster.defData["cod4_g3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_g3"].BoneOffset = {Vector(5.5, -9, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_g36"] = {}
WepHolster.defData["cod4_g36"].Model = "models/weapons/w_cod4_g36.mdl"
WepHolster.defData["cod4_g36"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_g36"].BoneOffset = {Vector(5.5, -5, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m1014"] = {}
WepHolster.defData["cod4_m1014"].Model = "models/weapons/w_cod4_m1014_1.mdl"
WepHolster.defData["cod4_m1014"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m1014"].BoneOffset = {Vector(5.5, -7, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m14"] = {}
WepHolster.defData["cod4_m14"].Model = "models/weapons/w_cod4_m14.mdl"
WepHolster.defData["cod4_m14"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m14"].BoneOffset = {Vector(5.5, -7, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m16"] = {}
WepHolster.defData["cod4_m16"].Model = "models/weapons/w_cod4_m16a4.mdl"
WepHolster.defData["cod4_m16"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m16"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m21sd"] = {}
WepHolster.defData["cod4_m21sd"].Model = "models/weapons/w_cod4_m21sd.mdl"
WepHolster.defData["cod4_m21sd"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m21sd"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m249saw"] = {}
WepHolster.defData["cod4_m249saw"].Model = "models/weapons/w_cod4_m249saw.mdl"
WepHolster.defData["cod4_m249saw"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m249saw"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m40a3"] = {}
WepHolster.defData["cod4_m40a3"].Model = "models/weapons/w_cod4_m40a3.mdl"
WepHolster.defData["cod4_m40a3"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m40a3"].BoneOffset = {Vector(5.5, -9, -1.5), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m4a1"] = {}
WepHolster.defData["cod4_m4a1"].Model = "models/weapons/w_cod4_m4a1.mdl"
WepHolster.defData["cod4_m4a1"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m4a1"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_m60"] = {}
WepHolster.defData["cod4_m60"].Model = "models/weapons/w_cod4_m60.mdl"
WepHolster.defData["cod4_m60"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_m60"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_mp44_new"] = {}
WepHolster.defData["cod4_mp44_new"].Model = "models/weapons/w_cod4_mp44_c.mdl"
WepHolster.defData["cod4_mp44_new"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_mp44_new"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_r700"] = {}
WepHolster.defData["cod4_r700"].Model = "models/weapons/w_cod4_r700.mdl"
WepHolster.defData["cod4_r700"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_r700"].BoneOffset = {Vector(5.5, -11, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_rpd"] = {}
WepHolster.defData["cod4_rpd"].Model = "models/weapons/w_cod4_rpd.mdl"
WepHolster.defData["cod4_rpd"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_rpd"].BoneOffset = {Vector(5.5, -7, 0), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_w1200"] = {}
WepHolster.defData["cod4_w1200"].Model = "models/weapons/w_cod4_w1200.mdl"
WepHolster.defData["cod4_w1200"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_w1200"].BoneOffset = {Vector(5.5, -7, -1), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["cod4_uzi"] = {}
WepHolster.defData["cod4_uzi"].Model = "models/weapons/w_cod4_uzi.mdl"
WepHolster.defData["cod4_uzi"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cod4_uzi"].BoneOffset = {Vector(4, -5, 9), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["cod4_skorp_new"] = {}
WepHolster.defData["cod4_skorp_new"].Model = "models/weapons/w_cod4_skorp_c.mdl"
WepHolster.defData["cod4_skorp_new"].Bone = "ValveBiped.Bip01_Spine1"
WepHolster.defData["cod4_skorp_new"].BoneOffset = {Vector(5, -5, 9), Angle(-10, 0, 260)}
----------------------------------------------------------------
WepHolster.defData["cod4_mp5_new"] = {}
WepHolster.defData["cod4_mp5_new"].Model = "models/weapons/w_cod4_mp5_c.mdl"
WepHolster.defData["cod4_mp5_new"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_mp5_new"].BoneOffset = {Vector(5.5, -8, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cod4_mp5sd"] = {}
WepHolster.defData["cod4_mp5sd"].Model = "models/weapons/w_cod4_mp5sd.mdl"
WepHolster.defData["cod4_mp5sd"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_mp5sd"].BoneOffset = {Vector(5.5, -8, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cod4_p90"] = {}
WepHolster.defData["cod4_p90"].Model = "models/weapons/w_cod4_p90.mdl"
WepHolster.defData["cod4_p90"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["cod4_p90"].BoneOffset = {Vector(5.5, -8, 1), Angle(-10, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["cod4_colt45"] = {}
WepHolster.defData["cod4_colt45"].Model = "models/weapons/w_cod4_m191145.mdl"
WepHolster.defData["cod4_colt45"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cod4_colt45"].BoneOffset = {Vector(0, -8.8, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["cod4_deagle_new"] = {}
WepHolster.defData["cod4_deagle_new"].Model = "models/weapons/w_cod4_deagle.mdl"
WepHolster.defData["cod4_deagle_new"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cod4_deagle_new"].BoneOffset = {Vector(0, -8.8, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["cod4_m9"] = {}
WepHolster.defData["cod4_m9"].Model = "models/weapons/w_cod4_m9.mdl"
WepHolster.defData["cod4_m9"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["cod4_m9"].BoneOffset = {Vector(0, -8.8, -2), Angle(5, 270, -5)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6"] = {}
WepHolster.defData["tfa_swch_z6"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6_green"] = {}
WepHolster.defData["tfa_swch_z6_green"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6_green"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6_green"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6_purple"] = {}
WepHolster.defData["tfa_swch_z6_purple"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6_purple"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6_purple"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6_red"] = {}
WepHolster.defData["tfa_swch_z6_red"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6_red"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6_red"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6_white"] = {}
WepHolster.defData["tfa_swch_z6_white"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6_white"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6_white"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_swch_z6_yellow"] = {}
WepHolster.defData["tfa_swch_z6_yellow"].Model = "models/weapons/w_minigun.mdl"
WepHolster.defData["tfa_swch_z6_yellow"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_swch_z6_yellow"].BoneOffset = {Vector(4, 8, -3.6), Angle(90, 90, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_flintlockrifle"] = {}
WepHolster.defData["tfa_flintlockrifle"].Model = "models/weapons/rarri/w_flintlockrifle.mdl"
WepHolster.defData["tfa_flintlockrifle"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_flintlockrifle"].BoneOffset = {Vector(3.8, -14, -5), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_m1777"] = {}
WepHolster.defData["tfa_m1777"].Model = "models/weapons/rarri/w_m1777.mdl"
WepHolster.defData["tfa_m1777"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_m1777"].BoneOffset = {Vector(3.8, -14, -5.5), Angle(-175, 0, 0)}
----------------------------------------------------------------
WepHolster.defData["tfa_newlandpattern"] = {}
WepHolster.defData["tfa_newlandpattern"].Model = "models/weapons/rarri/w_newlandpattern.mdl"
WepHolster.defData["tfa_newlandpattern"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["tfa_newlandpattern"].BoneOffset = {Vector(.5, 5.5, 7), Angle(90, 0, -90)}
----------------------------------------------------------------
WepHolster.defData["tfa_pig_doi_bren"] = {}
WepHolster.defData["tfa_pig_doi_bren"].Model = "models/weapons/tfa_pig_doi/w_tfa_pig_bren.mdl"
WepHolster.defData["tfa_pig_doi_bren"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_pig_doi_bren"].BoneOffset = {Vector(5.5, 2, -1.5), Angle(0, 0, -180)}
----------------------------------------------------------------
WepHolster.defData["tfa_ravager"] = {}
WepHolster.defData["tfa_ravager"].Model = "models/weapons/w_tfa_ico_ravager_sn.mdl"
WepHolster.defData["tfa_ravager"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ravager"].BoneOffset = {Vector(8.5, -24, -9), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_doom_gauss"] = {}
WepHolster.defData["tfa_doom_gauss"].Model = "models/weapons/tfa_doom/w_gauss.mdl"
WepHolster.defData["tfa_doom_gauss"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_doom_gauss"].BoneOffset = {Vector(7.5, -4, -3.6), Angle(90, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ins2_codol_free"] = {}
WepHolster.defData["tfa_ins2_codol_free"].Model = "models/weapons/tfa_ins2/w_codol_freedom.mdl"
WepHolster.defData["tfa_ins2_codol_free"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ins2_codol_free"].BoneOffset = {Vector(5.5, -4, -1.6), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ins2_ksg"] = {}
WepHolster.defData["tfa_ins2_ksg"].Model = "models/weapons/tfa_ins2/w_ksg.mdl"
WepHolster.defData["tfa_ins2_ksg"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ins2_ksg"].BoneOffset = {Vector(5.5, -3, -1.6), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ins2_minimi"] = {}
WepHolster.defData["tfa_ins2_minimi"].Model = "models/weapons/tfa_ins2/w_minimi.mdl"
WepHolster.defData["tfa_ins2_minimi"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ins2_minimi"].BoneOffset = {Vector(5.5, -3, -1.6), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ins2_codol_msr"] = {}
WepHolster.defData["tfa_ins2_codol_msr"].Model = "models/weapons/tfa_ins2/w_codol_msr.mdl"
WepHolster.defData["tfa_ins2_codol_msr"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ins2_codol_msr"].BoneOffset = {Vector(5.5, -4, -1.6), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["tfa_ins2_rpg"] = {}
WepHolster.defData["tfa_ins2_rpg"].Model = "models/weapons/tfa_ins2/w_rpg.mdl"
WepHolster.defData["tfa_ins2_rpg"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["tfa_ins2_rpg"].BoneOffset = {Vector(5.5, 2, -1.6), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["weapon_752_m2_flamethrower"] = {}
WepHolster.defData["weapon_752_m2_flamethrower"].Model = "models/props_c17/SuitCase_Passenger_Physics.mdl"
WepHolster.defData["weapon_752_m2_flamethrower"].Bone = "ValveBiped.Bip01_Spine2"
WepHolster.defData["weapon_752_m2_flamethrower"].BoneOffset = {Vector(8, 1, -11), Angle(-175, 0, -0)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_steel_saber"] = {}
WepHolster.defData["weapon_mor_steel_saber"].Model = "models/morrowind/steel/saber/w_steel_saber.mdl"
WepHolster.defData["weapon_mor_steel_saber"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_steel_saber"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_iron_saber"] = {}
WepHolster.defData["weapon_mor_iron_saber"].Model = "models/morrowind/iron/saber/w_iron_saber.mdl"
WepHolster.defData["weapon_mor_iron_saber"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_iron_saber"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_ebony_broadsword"] = {}
WepHolster.defData["weapon_mor_ebony_broadsword"].Model = "models/morrowind/ebony/broadsword/w_ebony_broadsword.mdl"
WepHolster.defData["weapon_mor_ebony_broadsword"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_ebony_broadsword"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_imperial_broadsword"] = {}
WepHolster.defData["weapon_mor_imperial_broadsword"].Model = "models/morrowind/imperial/broadsword/w_imperial_broadsword.mdl"
WepHolster.defData["weapon_mor_imperial_broadsword"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_imperial_broadsword"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_iron_broadsword"] = {}
WepHolster.defData["weapon_mor_iron_broadsword"].Model = "models/morrowind/iron/broadsword/w_iron_broadsword.mdl"
WepHolster.defData["weapon_mor_iron_broadsword"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_iron_broadsword"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}
----------------------------------------------------------------
WepHolster.defData["weapon_mor_nordic_broadsword"] = {}
WepHolster.defData["weapon_mor_nordic_broadsword"].Model = "models/morrowind/nordic/broadsword/w_nordic_broadsword.mdl"
WepHolster.defData["weapon_mor_nordic_broadsword"].Bone = "ValveBiped.Bip01_Pelvis"
WepHolster.defData["weapon_mor_nordic_broadsword"].BoneOffset = {Vector(1, 9, -1), Angle(0, 90, 90)}