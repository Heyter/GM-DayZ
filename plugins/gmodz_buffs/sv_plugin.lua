util.AddNetworkString("ixBuffAdd")
util.AddNetworkString("ixBuffRemove")
util.AddNetworkString("ixBuffClears")

function PLUGIN:OnCharacterDisconnect(client)
	client:ClearBuffs(true)
end

function PLUGIN:PlayerSpawn(client)
	if (client.clearBuffs) then
		client:ClearBuffs()
		client.clearBuffs = nil
	end
end

function PLUGIN:PlayerDeath(client)
	client.clearBuffs = true
end