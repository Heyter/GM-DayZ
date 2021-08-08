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
	ix.option.Add("entityShadows", ix.type.bool, false, {
		category = "performance"
	})

	do
		local bad_ents = {['class C_PhysPropClientside'] = true, ['class C_ClientRagdoll'] = true}
		timer.Create("CleanupGarbage", 60, 0, function()
			for _, v in ipairs(ents.GetAll()) do
				if (bad_ents[v:GetClass()]) then
					SafeRemoveEntity(v)
					RunConsoleCommand('r_cleardecals')
				end
			end
		end)
	end

	hook.Add("OnEntityCreated", "GmodZ.DisableShadows", function(entity)
		if (ix.option.Get("entityShadows", false)) then
			entity:DrawShadow(false)
		end
	end)

	hook.Add("InitPostEntity", "GmodZ.DisableShadows", function()
		if (ix.option.Get("entityShadows", false)) then
			for _, entity in ipairs(ents.GetAll()) do
				entity:DrawShadow(false)
			end
		end
	end)
end

if (SERVER) then
	hook.Add("PropBreak", "RPGM.AntiConstraintCrash", function(attacker, ent)
		if IsValid(ent) and ent:GetPhysicsObject():IsValid() then
			constraint.RemoveAll(ent)
		end
	end)
end