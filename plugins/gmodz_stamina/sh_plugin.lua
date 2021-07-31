PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Adds a stamina system to limit running."

-- luacheck: push ignore 631
ix.config.Add("staminaDrain", 1, "How much stamina to drain per tick (every quarter second). This is calculated before attribute reduction.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaRegeneration", 0.5, "How much stamina to regain per tick (every quarter second).", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaCrouchRegeneration", 0.75, "How much stamina to regain per tick (every quarter second) while crouching.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("punchStamina", 10, "How much stamina punches use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})

ix.config.Add("jumpStamina", 10, "How much stamina jumpes use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})

ix.util.Include("sv_plugin.lua", "server")

function PLUGIN:PlayerJumpModifier(client, brth)
	if (brth) then
		client.playerJumpModifier = 5
	end
end