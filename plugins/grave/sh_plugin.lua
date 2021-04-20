PLUGIN.name = "Grave"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Grave when the player die."

ix.util.Include("sv_plugin.lua")

ix.config.Add("GraveLifetime", 300, "How long it takes for a grave to decay in seconds.", nil, {
	data = {min = 30, max = 9999},
	category = PLUGIN.name
})

if (CLIENT) then
	function PLUGIN:LoadFonts()
		surface.CreateFont("GraveTitle",
		{
			font = "Trebuchet MS",
			size = 44,
			weight = 500,
			extended = true,
			outline = true
		})

		surface.CreateFont("GraveTitleLarge",
		{
			font = "Trebuchet MS",
			size = 52,
			weight = 500,
			extended = true,
			outline = true
		})
	end

	function PLUGIN:CharacterLoaded()
		for k, v in ipairs(player.GetHumans()) do
			if (IsValid(v)) then
				ix.steam.GetAvatar(v:SteamID64())
			end
		end
	end
end