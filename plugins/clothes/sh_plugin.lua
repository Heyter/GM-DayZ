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
		LocalPlayer().ixClothes = {}
	end)
end

hook.Add("PlayerSpeedModifier", "Clothes.PlayerSpeedModifier", function(client, walkSpeed)
	for _, v in pairs(client:GetClothesItem()) do
		if (v.speedModify) then
			client.playerSpeedModifier = client.playerSpeedModifier + v.speedModify
		end
	end
end)

-- brth = отдышка
hook.Add("PlayerJumpModifier", "Clothes.PlayerJumpModifier", function(client, brth)
	for _, v in pairs(client:GetClothesItem()) do
		if (v.jumpModify) then
			client.playerJumpModifier = math.max(0, client.playerJumpModifier + v.jumpModify)
		end
	end
end)

if (SERVER) then
	hook.Add("PlayerFootstep", "Clothes.PlayerFootstep", function(client, _, foot, soundName, _)
		for _, v in pairs(client:GetClothesItem()) do
			if (v.isArmor and v.runSounds) then
				client:EmitSound(v.runSounds[foot])
				return true
			end
		end

		client:EmitSound(soundName)
		return true
	end)
else
	hook.Add("PlayerFootstep", "Clothes.PlayerFootstep", function()
		return true
	end)
end

--[[ function PLUGIN:EntityEmitSound(data)
    if !data.Entity:IsPlayer() then return end

    if (data.SoundName):find("player/footsteps") then
		return false
    end
end ]]