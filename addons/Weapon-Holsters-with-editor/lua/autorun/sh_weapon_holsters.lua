if not ConVarExists("sv_weapon_holsters") then
	CreateConVar("sv_weapon_holsters",1, { FCVAR_REPLICATED, FCVAR_ARCHIVE,FCVAR_SERVER_CAN_EXECUTE }, "Enable Weapon Holsters (server side)" )
end
WepHolster = WepHolster or {}
WepHolster.HL2Weps = {
	["weapon_pistol"] = "Pistol",
	["weapon_357"] = "357",
	["weapon_frag"] = "Frag Grenade",
	["weapon_slam"] = "SLAM",
	["weapon_crowbar"] = "Crowbar",
	["weapon_stunstick"] = "Stunstick",
	["weapon_shotgun"] = "Shotgun",
	["weapon_rpg"] = "RPG Launcher",
	["weapon_smg1"] = "SMG",
	["weapon_ar2"] = "AR2",
	["weapon_crossbow"] = "Crossbow",
	["weapon_physcannon"] = "Gravity Gun",
	["weapon_physgun"] = "Physics Gun"
}
