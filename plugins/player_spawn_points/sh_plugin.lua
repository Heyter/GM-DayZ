PLUGIN.name = "Player Spawn Points"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}

if (SERVER) then util.AddNetworkString("ixPlayerSpawnerSync") end

ix.util.Include("sv_plugin.lua", "server")

if (CLIENT) then
	net.Receive("ixPlayerSpawnerSync", function()
		for _, v in ipairs(PLUGIN.spawners) do
			if (IsValid(v.drawModel)) then
				v.drawModel:Remove()
			end
		end

		PLUGIN.spawners = net.ReadTable()

		for _, v in ipairs(PLUGIN.spawners) do
			local model = ClientsideModel(LocalPlayer():GetModel())
			model:SetNoDraw(true)
			model:SetMaterial("models/wireframe")

			v.drawModel = model
		end

		hook.Add("PostDrawTranslucentRenderables", PLUGIN.name, function()
			local wep = LocalPlayer():GetActiveWeapon()

			if (IsValid(wep) and wep:GetClass() == 'gmod_tool' and LocalPlayer():GetTool("player_spawn_points")) then
				for _, v in ipairs(PLUGIN.spawners) do
					if (IsValid(v.drawModel)) then
						v.drawModel:SetPos(v.position)
						v.drawModel:SetAngles(v.angles)
						v.drawModel:SetupBones()
						v.drawModel:DrawModel()
					end
				end
			end
		end)
	end)
end