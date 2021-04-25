PLUGIN.name = "NPC Looting"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

ix.config.Add("corpseDecayTime", 180, "How long it takes for a corpse to decay in seconds. Set to 0 to never decay.", nil, {
	data = {min = 0, max = 1800},
	category = PLUGIN.name
})

ix.util.Include("sv_plugin.lua")