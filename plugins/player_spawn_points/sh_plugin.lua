PLUGIN.name = "Player Spawn Points"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

local PLUGIN = PLUGIN
PLUGIN.spawners = PLUGIN.spawners or {}

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

			if (IsValid(wep) and wep:GetClass() == 'gmod_tool' and GetConVarString("gmod_toolmode") == "player_spawn_points_tool") then
				for _, v in ipairs(PLUGIN.spawners) do
					if (IsValid(v.drawModel) and v.position) then
						v.drawModel:SetPos(v.position)

						if (v.angles) then
							v.drawModel:SetAngles(v.angles)
						end

						v.drawModel:SetupBones()
						v.drawModel:DrawModel()
					end
				end
			else
				for _, v in ipairs(PLUGIN.spawners) do
					if (IsValid(v.drawModel)) then
						v.drawModel:SetNoDraw(true)
					end
				end
			end
		end)
	end)

	local owner, w, h, ft, clmp
	clmp = math.Clamp
	local aprg, aprg2 = 0, 0

	function ix.hud.DrawDeath() end

	hook.Add("PreDrawHUD", "ix.hud.DrawDeath", function()
		cam.Start2D()
			owner = LocalPlayer()
			ft = FrameTime()
			w, h = ScrW(), ScrH()

			if (owner:GetCharacter()) then
				if (owner:Alive()) then
					if (aprg != 0) then
						aprg2 = clmp(aprg2 - ft*1.3, 0, 1)
						if (aprg2 == 0) then
							aprg = clmp(aprg - ft*.7, 0, 1)
						end
					end
				else
					if (aprg2 != 1) then
						aprg = clmp(aprg + ft*.5, 0, 1)
						if (aprg == 1) then
							aprg2 = clmp(aprg2 + ft*.4, 0, 1)
						end
					end
				end
			end

			if (IsValid(ix.gui.characterMenu) and ix.gui.characterMenu:IsVisible() or !owner:GetCharacter()) then
				return
			end

			surface.SetDrawColor(0, 0, 0, math.ceil((aprg^.5) * 200))
			surface.DrawRect(-1, -1, w+2, h+2)

			ix.util.DrawText(
				string.utf8upper(L"youreDead"), w/2, h/2, ColorAlpha(color_white, aprg2 * 255), 1, 1, "ixMenuButtonHugeFont", aprg2 * 255
			)
		cam.End2D()
	end)

	hook.Add( "HUDShouldDraw", "Hide_CHudDamageIndicator", function( name )
		if (name == "CHudDamageIndicator" and LocalPlayer():Health() <= 0) then
			return false
		end
	end)

	local function DeathTimer()
		local client = LocalPlayer and LocalPlayer() or nil
		if (!client) then return end

		if (client.GetCharacter and client:GetCharacter()) then
			if (client:Alive()) then
				if (IsValid(ix.gui.death_menu)) then
					LocalPlayer().deathTime = nil
					ix.gui.death_menu:SetMouseInputEnabled(false)
					ix.gui.death_menu:Remove()
				end
			else
				if (!IsValid(ix.gui.death_menu)) then
					client.deathTime = client.deathTime or RealTime() + ix.config.Get("spawnTime", 5)
					ix.gui.death_menu = vgui.Create("ixDeathScreenMenu")
					ix.gui.death_menu:SetMouseInputEnabled(true)

					hook.Run("LocalPlayerDeath")
				end
			end
		end
	end

	timer.Create("ixDeathScreenMenu", 0.25, 0, DeathTimer)

	gameevent.Listen("entity_killed")
	hook.Add("entity_killed", "ixDeathScreenMenu", function(data) 
		local victim = data.entindex_killed

		if (victim and victim == LocalPlayer():EntIndex()) then
			DeathTimer()
		end
	end)
end