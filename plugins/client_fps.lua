PLUGIN.name = "Boost FPS"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

do
	local hooks = {
		{'PostDrawEffects', 'RenderWidgets'},
		{'PlayerTick', 'TickWidgets'},
		{'PlayerInitialSpawn', 'PlayerAuthSpawn'},
		{'RenderScene', 'RenderStereoscopy'},
		{'LoadGModSave', 'LoadGModSave'},
		{"RenderScreenspaceEffects", "RenderColorModify"},
		{"RenderScreenspaceEffects", "RenderBloom"},
		{"RenderScreenspaceEffects", "RenderToyTown"},
		{"RenderScreenspaceEffects", "RenderTexturize"},
		{"RenderScreenspaceEffects", "RenderSunbeams"},
		{"RenderScreenspaceEffects", "RenderSobel"},
		{"RenderScreenspaceEffects", "RenderSharpen"},
		{"RenderScreenspaceEffects", "RenderMaterialOverlay"},
		{"RenderScreenspaceEffects", "RenderMotionBlur"},
		{"RenderScene", "RenderSuperDoF"},
		{"GUIMousePressed", "SuperDOFMouseDown"},
		{"GUIMouseReleased", "SuperDOFMouseUp"},
		{"PreventScreenClicks", "SuperDOFPreventClicks"},
		{"PostRender", "RenderFrameBlend"},
		{"PreRender", "PreRenderFrameBlend"},
		{"Think", "DOFThink"},
		{"RenderScreenspaceEffects", "RenderBokeh"},
		{"NeedsDepthPass", "NeedsDepthPass_Bokeh"},
		{"PostDrawEffects", "RenderWidgets"},
		{"PostDrawEffects", "RenderHalos"},
	}

	hook.Add('Initialize', 'hlib.widgets', function()
		hook.Remove('Initialize', 'hlib.widgets')

		for k, v in ipairs(hooks) do
			hook.Remove(v[1], v[2])
		end

		widgets.PlayerTick = nil

		timer.Remove("HostnameThink")
		timer.Remove("CheckHookTimes")

		hooks = nil
	end)
end

if (CLIENT) then
	do
		local ents = ents
		local badEnts = {
			[1] = 'class C_PhysPropClientside',
			[2] = 'class C_ClientRagdoll',
		}

		hook.Add('OnEntityCreated', 'hlib.cleanup', function(entity)
			if (entity:GetClass() == badEnts[1] or entity:GetClass() == badEnts[2]) then
				timer.Simple(10, function()
					for i = 1, ents.GetCount() do
						local ent = ents.GetAll()[i]

						if (ent:GetClass() == badEnts[1] or ent:GetClass() == badEnts[2]) then
							ent:Remove()
							ent = nil
						end
					end

					RunConsoleCommand('r_cleardecals')
				end)
			end
		end)
	end
end

if (SERVER) then
	hook.Add("PropBreak", "RPGM.AntiConstraintCrash", function(attacker, ent)
		if IsValid(ent) and ent:GetPhysicsObject():IsValid() then
			constraint.RemoveAll(ent)
		end
	end)
end