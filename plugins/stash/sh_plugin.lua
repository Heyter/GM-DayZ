PLUGIN.name = "Stash"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "You save your junk in the stash."

ix.config.Add("maxStash", 100, "Макс. размер хранилища по умолчанию.", nil, {
	data = {min = 1, max = 1000},
	category = PLUGIN.name
})

ix.util.Include("sv_plugin.lua", "server")

if (CLIENT) then
	function PLUGIN:LoadFonts()
		surface.CreateFont("StashTextSmall",
		{
			font = "Jura",
			size = 32,
			weight = 100,
			extended = true,
		})

		surface.CreateFont("StashTextLarge",
		{
			font = "Jura",
			size = 72,
			weight = 500,
			extended = true,
		})
	end
end