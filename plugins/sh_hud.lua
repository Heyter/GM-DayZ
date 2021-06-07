PLUGIN.name = "DayZ Hud"
PLUGIN.author = "Black Tea | STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then
	util.AddNetworkString("ixUpdateRep")
	util.AddNetworkString("ixHUDShineText")

	do
		local playerMeta = FindMetaTable("Player")

		function playerMeta:NotifyShine(text, time, color)
			net.Start("ixHUDShineText")
				net.WriteString(text)
				net.WriteUInt(time or 5, 16)
				net.WriteColor(color or color_white)
			net.Send(self)
		end
	end

	-- TODO? Удалить.
	function PLUGIN:PlayerLoadedCharacter(client, char)
		client:SetUserGroup('superadmin')
		char:GiveFlags("zptcCrenvV")
	end
else
	local SH_SZ = SH_SZ
	local Color, LocalPlayer, surface, math, ColorAlpha = Color, LocalPlayer, surface, math, ColorAlpha
	local FrameTime, CurTime = FrameTime, CurTime

	function PLUGIN:CanDrawAmmoHUD(weapon)
		if (weapon.ArcCW) then
			return false
		end
	end
	function PLUGIN:ShouldHideBars() return true end
	function PLUGIN:ShouldBarDraw() return false end

	-- OUTLINE ITEMS --
	do
		local color
		ix.option.Add("colorOutlineItems", ix.type.color, Color("sky_blue"), {
			category = "colors"
		})

		function PLUGIN:PreDrawOutlines()
			local entity = LocalPlayer():GetTraceEntity(120)

			if (IsValid(entity) and Schema.outlineItems[entity:GetClass()]) then
				color = ix.option.Get("colorOutlineItems", color_white)

				if (color.a != 255) then
					color.a = 255
				end

				outline.Add(entity, color, OUTLINE_MODE_VISIBLE)
			end
		end
	end
	-- OUTLINE ITEMS END --

	local hud = {}
	local sscale = ScreenScale
	local dbox = draw.RoundedBox

	hud.lang = {}

	function hud.ResetLang()
		hud.lang = {
			radiation = L("Radiation"):utf8upper(),
			well_fed = L("well_fed"):utf8upper(),
			safezone = L("safezone_title"):utf8upper(),
			hunger = L("needs_hunger"):utf8upper(),
			thirst = L("needs_thirst"):utf8upper(),
			stamina = L("Endurance"):utf8upper(),
			l = ix.option.Get("language", "english")
		}
	end

	function PLUGIN:LoadFonts()
		surface.CreateFont("ixDHUDNum", {
			font = "Jura",
			extended = true,
			size = ix.util.ScreenScaleH(12),
			weight = 100,
		})

		surface.CreateFont("nutDHUDIcon", {
			font = "fontello",
			extended = true, 
			size = sscale(12),
			weight = 1500, 
		})

		surface.CreateFont("nutDHUDIcon2", {
			font = "fontello",
			extended = true, 
			size = sscale(10), 
			weight = 400, 
		})

		surface.CreateFont("nutDHUDIcon3", {
			font = "fontello",
			extended = true, 
			size = sscale(6), 
			weight = 400, 
		})

		surface.CreateFont("nutDHUDFont", {
			font = "Jura",
			extended = true, 
			size = sscale(8), 
			weight = 400, 
		})

		surface.CreateFont("nutDHUDFont2", {
			font = "Jura",
			extended = true, 
			size = sscale(11), 
			weight = 400, 
		})

		hud.ResetLang()
	end

	local percHistories = {}
	function hud:percDisp(wok, title, percent, reverse)
		percHistories[title] = percHistories[title] or {}
		local meme = percHistories[title]
		meme.memes = meme.memes or percent
		meme.alpha = meme.alpha or 0

		local x, y, w, h = wok.x, wok.y, wok.w, wok.h

		surface.SetFont("ixNoticeFont")
		local tx = surface.GetTextSize(title)
		w = w / 4 + tx + sscale(2)

		dbox(wok.rnd or 8, x, y, w, h, ColorAlpha(color_black, 200))
		y = y - sscale(2)
		ix.util.DrawText(title, x + w/2, y + h/2, wok.textColor or color_white, TEXT_ALIGN_CENTER, 4, "ixNoticeFont")

		local colorFade = 100
		if (reverse == true) then
			if (percent >= 75) then
				colorFade = (RealTime() * 150) % 100
			end
		else
			if (percent < 25) then
				colorFade = (RealTime() * 150) % 100
			end
		end

		local colorWider = Color(255, 155 + colorFade, 155 + colorFade)

		if (meme.memes != percent) then
			meme.alpha = 255
		else
			if (meme.alpha > 0) then
				meme.alpha = math.max(meme.alpha - FrameTime() - 5, 0)
			end
		end

		local a, b = x + w/2, y + h/2
		ix.util.DrawText(percent .. "%", a, b, colorWider, TEXT_ALIGN_CENTER, 5, "ixDHUDNum")
		ix.util.DrawText(percent .. "%", a, b, ColorAlpha(colorWider, meme.alpha), TEXT_ALIGN_CENTER, 5, "ixDHUDNum")
		meme.memes = percent
		wok.w = w
	end

	function hud:edgyBar(wok, color)
		local x, y, w, h = wok.x, wok.y, wok.w, wok.h

		dbox(wok.rnd or 8, x, y, w, h, ColorAlpha(color_black, 200))
		local tx, ty = ix.util.DrawText("A", x + sscale(4), y + h/2 - sscale(1), color_white, 3, TEXT_ALIGN_CENTER, "nutDHUDIcon")

		local totallen = w - tx - sscale(12)

		local maxHP = LocalPlayer():GetMaxHealth()
		local HP = LocalPlayer():Health()

		self.awto = Lerp(FrameTime() * 5, self.awto or HP, HP)

		surface.SetDrawColor(192, 57, 43, 75)
		surface.DrawRect(x + sscale(8) + tx, y + sscale(3), totallen, h - sscale(6))

		surface.SetDrawColor(192, 57, 43)
		surface.DrawRect(x + sscale(8) + tx, y + sscale(3), totallen * math.min(maxHP, self.awto) / maxHP, h - sscale(6))

		HP = math.Clamp(math.Round(self.awto), 0, maxHP)
		local xHP = ix.util.DrawText(HP .. "%", x + sscale(8) + tx, y + h/2 - sscale(1), color_white, 3, TEXT_ALIGN_CENTER, "ixDHUDNum")

		if (LocalPlayer():ExtraHealth() > 0) then
			ix.util.DrawText(Format("(+%d)", LocalPlayer():ExtraHealth()), x + sscale(8) + tx + (xHP + sscale(4)), y + h/2 - sscale(1), color_white, 3, TEXT_ALIGN_CENTER, "ixDHUDNum")
		end
	end

	function hud:drawText(wok, title, font)
		font = font or "nutDHUDFont"

		local x, y, w, h = wok.x, wok.y, wok.w, wok.h

		surface.SetFont(font)
		local tx = surface.GetTextSize(title)
		w = w / 4 + tx + sscale(2)

		dbox(wok.rnd or 8, x, y, w, h, ColorAlpha(color_black, 200))
		ix.util.DrawText(title, x + w/2, y + h/2 - sscale(1), wok.textColor or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, font)
	end

	function hud:status(wok, text, icon, bNotFixSize)
		local x, y, w, h = wok.x, wok.y, wok.w, wok.h

		if (!bNotFixSize) then
			surface.SetFont("nutDHUDFont")
			local tx = surface.GetTextSize(text)
			w = w / 2 + tx + sscale(2)
		end

		dbox(wok.rnd or 8, x, y, w, h, ColorAlpha(color_black, 200))
		local tx, ty = ix.util.DrawText(icon or "Z", x + sscale(4), y + h/2 - sscale(1), color_white, 3, TEXT_ALIGN_CENTER, "nutDHUDIcon2")
		local next = w/2 + tx + sscale(2)
		ix.util.DrawText(text, next, y + h/2 - sscale(1), wok.textColor or color_white, 1, TEXT_ALIGN_CENTER, "nutDHUDFont")
	end

	local dirName = {
		[12] = "N",
		[0] = "E",
		[-12] = "S",
		[24] = "W",
		[-24] = "W",
	}

	function hud:compass(wok)
		local x, y, w, h = wok.x, wok.y, wok.w, wok.h

		dbox(wok.rnd or 8, x, y, w, h, ColorAlpha(color_black, 200))

		surface.SetDrawColor(color_white)
		local startX, endX = x + sscale(5), x + w - sscale(5)
		local displayW = (endX - startX)
		local angola = EyeAngles().y
		local dir = angola/7.5 -- 90 is north, -90 is south -180/180 is west 0 is east
		local macOpt = (displayW)/24
		local a, b = math.floor(dir-12), math.ceil(dir+12)

		a = (a + 24)%48 - 24
		b = (b + 24)%48 - 24

		for i = -24, 23 do
			-- POSITION DEPENDANCY

			if (a > b) then
				if (i > b and i < a) then
					continue
				end
			else
				if (i > b or i < a) then
					continue
				end
			end

			local pos
			if (a > b) then
				if (dir < 0) then -- 좌측
					if (i > 0) then
						pos = endX - macOpt*(i - 36 - dir)
					else
						pos = endX - macOpt*(i + 12 - dir)   
					end
				elseif (dir >= 0) then -- 우측 -- 마이너스가 오른쪽
					if (i < 0) then
						pos = endX - macOpt*(i + 60 - dir)
					else
						pos = endX - macOpt*(i + 12 - dir)   
					end
				end
			else
				pos = endX - macOpt*(i + 12 - dir)
			end

			pos = math.Clamp(pos, startX, endX)

			if (i%6 == 0) then
				if (dirName[i]) then
					ix.util.DrawText(dirName[i], pos, y + h - sscale(10), color_white, 1, TEXT_ALIGN_CENTER, "nutDHUDFont")
				end
				surface.DrawLine(pos, y + h - sscale(2), pos, y + h - sscale(6.5))
			else
				surface.DrawLine(pos, y + h - sscale(2), pos, y + h - sscale(5))
			end
		end

		--SCHEMA.targets = {

		for _, v in ipairs(ents.FindByClass("ix_item")) do
			if (LocalPlayer():GetPos():DistToSqr(v:GetPos()) < (262144)) then
				local angola = math.NormalizeAngle((v:GetPos() - LocalPlayer():GetPos()):Angle().y)
				local target = angola/7.5
				local pos
				
				if (a > b) then
					if (dir < 0) then -- 좌측
						if (target > 0) then
							pos = endX - macOpt*(target - 36 - dir)
						else
							pos = endX - macOpt*(target + 12 - dir)   
						end
					elseif (dir >= 0) then -- 우측 -- 마이너스가 오른쪽
						if (target < 0) then
							pos = endX - macOpt*(target + 60 - dir)
						else
							pos = endX - macOpt*(target + 12 - dir)   
						end
					end
				else
					pos = endX - macOpt*(target + 12 - dir)
				end

				pos = math.Clamp(pos, startX, endX)
				ix.util.DrawText("c", pos, y + h - sscale(10), color_white, 1, TEXT_ALIGN_CENTER, "nutDHUDIcon3")
			end
		end
	end

	hud.noti = {}

	local function addText(text, time, color)
		local wow = {str = 0, text = text, time = CurTime() + time, alpha = 0, aalpha = 155, gloss = false, color = color}

		hud.noti[#hud.noti + 1] = wow
	end

	net.Receive("ixHUDShineText", function()
		local text = net.ReadString()
		local time = net.ReadUInt(16)
		local color = net.ReadColor()

		addText(L(text), time or 5, color or color_white)
	end)

	net.Receive("ixUpdateRep", function()
		local bandit = net.ReadBool()
		local repDiff = net.ReadUInt(16)

		if (bandit) then
			addText(Format("%s -%d", L"reputation", repDiff), 4, Color("red"))
		else
			addText(Format("%s +%d", L"reputation", repDiff), 4, Color("dark_lime"))
		end
	end)

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function hud:drawNotifications()
		local x, y = ScrW()/2, ScrH()/4*3

		local blyat = 0
		local cnt = 0
		for k, v in pairs(hud.noti) do
			cnt = cnt + 1

			v.y = v.y or y + blyat
			v.y = Lerp(FrameTime() * 10, v.y, y + blyat)

			if (cnt > 5) then
				v.time = CurTime() + 3
				continue
			end

			if (v.time < CurTime()) then
				if (v.alpha < 5) then
					table.remove(hud.noti, k)

					continue
				end

				v.alpha = Lerp(FrameTime()*3, v.alpha, 0)
			else
				v.alpha = Lerp(FrameTime()*3, v.alpha, 255)
			end

			if (v.gloss) then
				v.aalpha = Lerp(FrameTime()*5, v.aalpha, 0)
			else
				if (v.aalpha > 150) then
					v.gloss = true
				end

				v.aalpha = Lerp(FrameTime()*15, v.aalpha, 255)
			end

			v.str = Lerp(FrameTime()*4, v.str, 4)
			local tx, ty = ix.util.DrawText(v.text, x, v.y, ColorAlpha(v.color or color_white, v.alpha), 1, TEXT_ALIGN_CENTER, "nutDHUDFont2")
			surface.SetMaterial(GLOW_MATERIAL)
			surface.SetDrawColor(ColorAlpha(v.color or color_white, v.aalpha))
			blyat = blyat + ty*1.1

			tx, ty = tx*(2 + v.str*0.8), ty*(v.str*1.3)

			surface.DrawTexturedRect(x - tx/2, v.y - ty/2, tx, ty)
		end
	end

	--do
		-- ix_item toScreen
		--local rangeSize, angleCos = 80, math.cos(math.rad(45))
		--local shadowColor = Color(66, 66, 66)
		--hook.Add("PostDrawTranslucentRenderables", "PostDrawTranslucentRenderables.ix_item", function(bDepth, bSkybox)
			-- if (bDepth or bSkybox or !LocalPlayer():GetCharacter()) then return end

			-- local startPos = LocalPlayer():EyePos()
			-- local dir = LocalPlayer():GetAimVector()

			-- local entities = ents.FindInCone(startPos, dir, rangeSize, angleCos)

			-- for _, ent in ipairs(entities) do
				-- if (IsValid(ent) and ent:GetClass() == "ix_item") then
					-- if (IsValid(ix.gui.entityInfo) and ix.gui.entityInfo.entity == ent) then continue end

					-- local item = ent:GetItemTable()
					-- local quantity = ent:GetData("quantity", 1)
					-- local text = item:GetName()

					-- if (quantity >= 2) then
						-- text = Format("%s (x%d)", text, quantity)
					-- end

					-- cam.Start2D()
						-- local centerScreen = ent:GetPos():ToScreen()
						-- draw.SimpleTextOutlined(text, "ixNoticeFont",
							-- centerScreen.x, centerScreen.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, shadowColor
						-- )
					-- cam.End2D()
				-- end
			-- end
		--end)
	--end

	local breathSound = Sound("gmodz/player/stamina.wav")
	function PLUGIN:Think()
		if (hud.lang.tick or 0) < CurTime() then
			if (hud.lang.l != ix.option.Get("language", "english")) then
				hud.ResetLang()
			end

			hud.lang.tick = CurTime() + 1
		end

		local client = LocalPlayer()
		local playedHeartbeatSound = false

		if (client:Alive()) then
			local health = client:GetHealth()
			local maxHealth = client:GetMaxHealth()

			if (health < maxHealth) then
				if (!self.HeartbeatSound) then
					self.HeartbeatSound = CreateSound(client, "player/heartbeat1.wav")
				end

				if (CurTime() >= (self.NextHeartbeat or 0)) then
					self.NextHeartbeat = CurTime() + ( 0.75 + ( (1.25 / maxHealth) * health ) )
					self.HeartbeatSound:PlayEx(0.75 - ( (0.7 / maxHealth) * health ), 100)
				end

				playedHeartbeatSound = true
			end
		end

		if (!playedHeartbeatSound and self.HeartbeatSound) then
			if (client:Alive()) then
				self.HeartbeatSound:FadeOut(10)
			else
				self.HeartbeatSound:Stop()
			end
		end

		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter() and v:Alive() and v:GetNetVar("brth")) then
				v.BreathSound = v:StartLoopingSound(breathSound)
			elseif (v.BreathSound) then
				v:StopLoopingSound(v.BreathSound)
				v.BreathSound = nil
			end
		end
	end

	gameevent.Listen("player_disconnect")
	hook.Add("player_disconnect", "HUD.player_disconnect", function(data)
		local client = Player(data.userid)

		if (client.BreathSound) then
			client:StopLoopingSound(client.BreathSound)
			client.BreathSound = nil
		end
	end)

	do
		local ColorModify = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}

		local color = 0
		function PLUGIN:RenderScreenspaceEffects()
			if (LocalPlayer():Alive()) then
				color = 1 - (LocalPlayer():GetHealth() / LocalPlayer():GetMaxHealth())
				-- color = math.Approach(color, math.Clamp(1 - math.Clamp(LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0, 1), 0, 1), FrameTime() * 3)

				if (color > 0) then
					ColorModify["$pp_colour_colour"] = math.Clamp(1 - color, 0, 1)

					DrawColorModify(ColorModify)
				end
			end
		end
	end

	function PLUGIN:HUDPaint()
		local client = LocalPlayer()
		if (!client:GetCharacter() or !client:Alive()) then return end

		hud:drawNotifications()

		local margin = sscale(5)
		local w, h = ScrW(), ScrH()

		local perc = {}
		perc.w = sscale(150)
		perc.h = sscale(15)
		perc.x = w/2 - perc.w/2
		perc.y = h - perc.h - sscale(5)
		hud:compass(perc)

		perc = {}
		perc.w = sscale(100)
		perc.h = sscale(15)
		perc.x = sscale(5)
		perc.y = h - perc.h - sscale(5)
		hud:edgyBar(perc)

		local oldX = perc.x
		perc.h = sscale(15)
		perc.x = perc.x + perc.w + sscale(5)
		perc.w = sscale(50)
		perc.y = perc.y

		-- Reputation
		local repData = Schema.ranks[client:GetReputationLevel()] or Schema.ranks[0]

		perc.textColor = repData[2]
		hud:drawText(perc, L(repData[1]))

		-- Human needs
		local getHunger = math.Round((1 - client:GetHungerPercent()) * 100)
		local getThirst = math.Round((1 - client:GetThirstPercent()) * 100)

		perc.textColor = color_white
		perc.w = sscale(30)
		perc.h = sscale(25)
		perc.x = oldX
		perc.y = perc.y - perc.h - margin
		hud:percDisp(perc, hud.lang.hunger, getHunger)
		perc.x = perc.x + perc.w + margin
		hud:percDisp(perc, hud.lang.thirst, getThirst)
		perc.x = perc.x + perc.w + margin
		hud:percDisp(perc, hud.lang.stamina, math.Round(client:GetLocalVar("stm", 0)))

		perc.w = sscale(50)
		perc.h = sscale(15)
		perc.x = sscale(5)

		if (client:GetNetVar("bleeding")) then
			local prefix, color = ix.bleeding:Format()

			perc.textColor = color
			perc.y = perc.y - perc.h - margin
			hud:status(perc, prefix, "5")
		end

		-- blood loss effect
		local bleeding_level
		for _, v in ipairs(player.GetAll()) do
			if (IsValid(v) and v:Health() > 0) then
				bleeding_level = v:GetNetVar("bleeding")

				if (bleeding_level and (v.nextBloodDrop or 0) < CurTime()) then
					local bone_pos = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine"))
					if (!bone_pos) then continue end

					local effect = EffectData()
						effect:SetOrigin(bone_pos)
						effect:SetMagnitude(1)
					util.Effect("blooddrop", effect, nil)

					v.nextBloodDrop = CurTime() + math.max(0.25, 0.5 + ix.bleeding.max_level - bleeding_level)
				end
			end
		end

		if (client:IsBrokenLeg()) then -- НОГА ПОВРЕЖДЕНА
			perc.textColor = Color("red")
			perc.y = perc.y - perc.h - margin
			hud:status(perc, L("broken_leg"))
		end

		-- Safezone
		if (!client:CanEnterSafe()) then
			perc.y = perc.y - perc.h - margin
			perc.textColor = Color("red")

			local time = math.max(0, 0 - (CurTime() - client:GetLocalVar("penalty", 0)))
			hud:status(perc, L"cannot_enter_safezone" .. " " .. string.ToMinutesSeconds(time), "R")
		elseif (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.PROTECTED) then
			perc.y = perc.y - perc.h - margin
			perc.textColor = Color(50, 200, 50)

			hud:status(perc, hud.lang.safezone, "R")
		elseif (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.ENTERING) then
			local sz = SH_SZ.m_Safe

			if (sz and sz.opts.ptime) then
				perc.y = perc.y - perc.h - margin
				perc.textColor = Color(200, 200, 50)

				local time = math.max(math.ceil(sz.enter + sz.opts.ptime - CurTime()), 0)
				hud:status(perc, hud.lang.safezone .. " " .. string.ToMinutesSeconds(math.max(0, time - 1)), "R")
			end
		end

		-- PVP
		local pvpTime = math.max(0, 0 - (CurTime() - client:GetPVPTime()))
		if (pvpTime != 0) then
			perc.y = perc.y - perc.h - margin
			perc.textColor = Color("red")

			hud:status(perc, L"combat_logged" .. " " .. string.ToMinutesSeconds(pvpTime), "R") -- В БОЮ
		end

		if (hook.Run("CanPlayerRegenHealth", client) != false) then
			if (getHunger >= 90 and getThirst >= 90) then
				perc.textColor = Color("light_lime")
				perc.y = perc.y - perc.h - margin
				hud:status(perc, hud.lang.well_fed, "j") -- СЫТ
			end
		end

		local rad = client:GetRadiationTotal()

		if (rad > 0) then
			perc.textColor = rad >= 500 and Color("red") or Color("yellow")
			perc.y = perc.y - perc.h - margin
			hud:status(perc, hud.lang.radiation .. ": " .. math.Round(rad), "Z") -- СЫТ
		end

		hook.Run("HUDExtraPaint", client, perc, hud, margin)
	end
end
