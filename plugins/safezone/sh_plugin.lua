PLUGIN.name = "Safezone"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

ix.util.Include("sv_plugin.lua")

ix.command.Add("SafezoneEdit", {
	description = "Enters safezone edit mode",
	superAdminOnly = true,
	OnRun = function(self, client)
		SH_SZ:Sync(client)
	end
})

if (CLIENT) then
	ix.option.Add("drawSafezones", ix.type.bool, false, {
		category = "performance"
	})

	ix.option.Add("drawOutlineSZ", ix.type.bool, false, {
		category = "performance"
	})

	ix.option.Add("colorSafezones", ix.type.color, Color(0, 255, 0), {
		category = "colors"
	})

	ix.option.Add("colorSafezonePlayers", ix.type.color, ix.config.Get("color"), {
		category = "colors"
	})

	do
		local sizeRing, center, min, max, alpha, dist
		local safezoneColor = Color(0, 255, 0)

		hook.Add("PostDrawTranslucentRenderables", "PostDrawTranslucentRenderables.drawSafezones", function(bDepth, bSkybox)
			if (ix.option.Get("drawSafezones", false)) then return end
			if (bDepth or bSkybox or !LocalPlayer():GetCharacter()) then return end
			if (!SH_SZ or !SH_SZ.SafeZones or #SH_SZ.SafeZones == 0) then return end

			for _, sz in ipairs(SH_SZ.SafeZones) do
				center, min, max = SH_SZ:GetLocalZonePosition(sz.points[1], sz.points[2], sz.shape, sz.size)

				dist = LocalPlayer():GetPos():DistToSqr(center)
				if (dist > (4194304)) then continue end

				alpha = 255 - (math.Clamp((dist / (4161600)) * 255, 0, 255))
				if (alpha < 1) then continue end

				safezoneColor = ColorAlpha(ix.option.Get("colorSafezones", color_white), alpha)

				if (sz.shape == 1) then
					render.DrawBoundingBox(sz.points[1], sz.points[2], safezoneColor)
				elseif (sz.shape == 2) then
					sizeRing = sz.size + math.sin(RealTime() * 2) * 5
					render.StartWorldRings()
						render.AddWorldRing(center, sizeRing, 4, 32)
					render.FinishWorldRings(safezoneColor)
				end
			end
		end)
	end

	local players = {}
	local position, color

	function PLUGIN:PreDrawOutlines()
		if (ix.option.Get("drawOutlineSZ", false)) then return end
		if (!LocalPlayer():GetCharacter() or !SH_SZ) then return end

		if (LocalPlayer():GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) != SH_SZ.OUTSIDE) then
			players = {}

			for _, v in ipairs(player.GetAll()) do
				if (IsValid(v) and v != LocalPlayer() and v:Alive()) then
					position = select(1, v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine") or -1)) or v:LocalToWorld(v:OBBCenter())

					if (SH_SZ:IsWithinSafeZone(position)) then
						players[#players + 1] = v
					end
				end
			end

			if (#players > 0) then
				color = ix.option.Get("colorSafezonePlayers", ix.config.Get("color"))

				if (color.a != 255) then
					color.a = 255
				end

				outline.Add(players, color, OUTLINE_MODE_VISIBLE)
			end
		end
	end

	function PLUGIN:ShouldCollide(ent1, ent2)
		if (ent1:IsPlayer() and ent2:IsPlayer()) then
			if (ent1:IsStuck() and ent2:IsStuck()) then return false end

			local pos1 = select(1, ent1:GetBonePosition(ent1:LookupBone("ValveBiped.Bip01_Spine") or -1)) or ent1:LocalToWorld(ent1:OBBCenter())
			local pos2 = select(1, ent2:GetBonePosition(ent2:LookupBone("ValveBiped.Bip01_Spine") or -1)) or ent2:LocalToWorld(ent2:OBBCenter())

			if (SH_SZ:IsWithinSafeZone(pos1) or SH_SZ:IsWithinSafeZone(pos2)) then
				return false
			end
		end
	end
end