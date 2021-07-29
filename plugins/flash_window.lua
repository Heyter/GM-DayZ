PLUGIN.name = "Flash window"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then return end

ix.option.Add("flashWindow", ix.type.bool, true, {
	category = "chat"
})

function PLUGIN:InitPostEntity()
    if (ix.option.Get("flashWindow", true) and system.IsWindows() and !system.HasFocus()) then
		system.FlashWindow()
	end
end

PLUGIN.MessageReceived = PLUGIN.InitPostEntity