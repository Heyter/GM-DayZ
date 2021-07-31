PLUGIN.name = "Clothes"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Adds clothes items"

ix.util.Include("sv_plugin.lua")

FindMetaTable("Player").GetClothesItem = function(self)
	return (self.ixClothes or {})
end

if (CLIENT) then
	net.Receive("ixClothesSet", function()
		local category = net.ReadString()
		local id = net.ReadUInt(32)
		local client = LocalPlayer()

		if (client:Alive()) then
			client.ixClothes = client.ixClothes or {}

			if (id) then
				if (ix.item.instances[id]) then
					client.ixClothes[category] = ix.item.instances[id]
				end
			else
				client.ixClothes[category] = nil
			end
		else
			client.ixClothes = {}
		end
	end)

	net.Receive("ixClothesClear", function()
		client.ixClothes = {}
	end)
end

hook.Add("PlayerSpeedModifier", "Clothes.PlayerSpeedModifier", function(client, walkSpeed)
	for _, v in pairs(client:GetClothesItem()) do
		if (v.speedModify) then
			client.playerSpeedModifier = client.playerSpeedModifier + v.speedModify
		end
	end
end)