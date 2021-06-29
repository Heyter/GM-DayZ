PLUGIN.name = "NPC Looting"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Rewards for npc killing"

ix.config.Add("npcBoxDecayTime", 180, "How long it takes for a box to decay in seconds.", nil, {
	data = {min = 10, max = 600},
	category = PLUGIN.name
})

ix.util.Include("sv_plugin.lua")