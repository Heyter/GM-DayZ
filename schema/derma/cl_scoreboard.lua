local draw, surface, math, IsValid, ScreenScale = draw, surface, math, IsValid, ScreenScale

local function clampV(value)
	return math.Clamp(value, -999999999, 999999999)
end

local PANEL = {}

-- Labels: kills, players, etc...
PANEL.cLabel = Color(150, 150, 150)

-- Border around the entire scoreboard color
PANEL.cBackgroundOutline = Color(0, 0, 0, 255)

-- Player outline color
PANEL.cPlayerOutline = Color(0, 0, 0, 100)

-- Background color
PANEL.cBackground = Color(10, 6, 4, 150)

-- Server title, player name
PANEL.fTitle = "ixSmallTitleFont"

-- Labels: kills, players, etc...
PANEL.fLabel = "ixToolTipText"

PANEL.labelOffset = 8

function PANEL:Init()
	if (IsValid(ix.gui.scoreboard)) then
		ix.gui.scoreboard:Remove()
	end

	self:Dock(FILL)

	ix.gui.scoreboard = self

	self.scroll = self:Add("DScrollPanel")
	self.scroll:Dock(FILL)
    self.scroll:DockMargin(0, 50, 0, 0)
	self.scroll.Paint = function(t, w, h)
		surface.SetDrawColor(self.cBackground)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(self.cBackgroundOutline)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local vbar = self.scroll:GetVBar()
    vbar.Paint = function() end
    vbar.btnUp.Paint = function() end
    vbar.btnDown.Paint = function() end
    vbar.btnGrip.Paint = function(panel, w, h)
        if (panel.Depressed) then
            draw.RoundedBox(4, 2, 1, 6, h - 2, Color(255, 255, 255, 75))
            return
        end

        if (panel:IsHovered()) then
            draw.RoundedBox(4, 2, 1, 6, h - 2, Color(255, 255, 255, 50))
            return
        end

        draw.RoundedBox(4, 2, 1, 6, h - 2, Color(255, 255, 255, 25))
    end

	self.scroll.Think = function(panel)
		if (RealTime() >= (panel.nextThink or 0)) then
			local bHasPlayers = false

			for _, v in ipairs(player.GetAll()) do
				if (!IsValid(v.ixScoreboardSlot)) then
					if (panel:AddPlayer(v)) then
						bHasPlayers = true
					end
				else
					v.ixScoreboardSlot:Update()
					bHasPlayers = true
				end
			end

			panel:SetVisible(bHasPlayers)
			panel:InvalidateLayout()
			panel.nextThink = RealTime() + 1
		end
	end

	self.scroll.AddPlayer = function(panel, client)
		if (!IsValid(client) or !client:GetCharacter() or hook.Run("ShouldShowPlayerOnScoreboard", client) == false) then
			return false
		end

		-- rows
		local row = panel:Add("DPanel")
		row:Dock(TOP)
		row:DockMargin(10, 7, 10, 0)
		row:SetTall(32)
		row.player = client
		row.character = client:GetCharacter()
		row.Paint = function(t, w, h)
			if (!IsValid(t) or !IsValid(client) or !t.character) then return end

			-- Black box
			surface.SetDrawColor(ColorAlpha(self.cBackground, 100))
			surface.DrawRect(0, 0, w, h)

			-- Outline
			surface.SetDrawColor(self.cPlayerOutline)
			surface.DrawOutlinedRect(0, 0, w, h)

			local repData = Schema.ranks[client:GetReputationLevel()] or Schema.ranks[0]
			local countryIcon = ix.geoip:GetMaterial(client)

			-- Name
			local name = client:Name()
			name = (name:utf8len() > 34 and string.format("%s...", name:utf8sub(1, 34)) or name)

			local tx = ix.util.DrawText(name, 40, h / 2, repData[2], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, self.fTitle)

			-- Usergroup icon
			local icon
			if (client:IsSuperAdmin()) then
				icon = "icon16/shield.png"
			elseif (client:IsAdmin()) then
				icon = "icon16/star.png"
			elseif (client:IsUserGroup("moderator") or client:IsUserGroup("operator")) then
				icon = "icon16/wrench.png"
			elseif (client:IsUserGroup("vip") or client:IsUserGroup("donator") or client:IsUserGroup("donor")) then
				icon = "icon16/heart.png"
			end

			icon = hook.Run("GetPlayerIcon", client) or icon

			-- Usergroup icon
			if (icon) then
				surface.SetDrawColor(color_white)
				surface.SetMaterial(Material(icon))
				surface.DrawTexturedRect(40 + tx + ScreenScale(4), h / 2 - 8, 16, 16)
			end

			-- Country flag
			if (countryIcon) then
				surface.SetMaterial(countryIcon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w * 0.57, h * 0.5 - Schema.countryIcon.h * 0.5 + 1, Schema.countryIcon.w, Schema.countryIcon.h)
			end

			-- Frags
			ix.util.DrawText("K:", w * 0.60, h / 2, self.cLabel, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.fLabel)
			ix.util.DrawText(clampV(client:Frags()), w * 0.60 + ScreenScale(self.labelOffset), h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, self.fTitle)

			-- Deaths
			ix.util.DrawText("D:", w * 0.75, h / 2, self.cLabel, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.fLabel)
			ix.util.DrawText(clampV(client:Deaths()), w * 0.75 + ScreenScale(self.labelOffset), h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, self.fTitle)

			-- Ping
			ix.util.DrawText("P:", w * 0.90, h / 2, self.cLabel, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.fLabel)

			local currentPing = client:Ping()
			local cPing = derma.GetColor(currentPing < 110 and "Success" or (currentPing < 165 and "Warning" or "Error"), t)
			ix.util.DrawText(math.min(999, currentPing), w * 0.90 + ScreenScale(self.labelOffset), h / 2, cPing, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, self.fTitle)
		end

		function row:Think()
			if (RealTime() >= (self.nextThink or 0)) then
				local client = self.player

				if (!IsValid(client) or !client:GetCharacter() or self.character != client:GetCharacter()) then
					self:Remove()
					self:GetParent():SizeToContents()
				end

				self.nextThink = RealTime() + 1
			end
		end

		row.avatar = row:Add("AvatarImage")
		row.avatar:SetSize(32, 32)
		row.avatar:SetPlayer(client)
		row.avatar:SetCursor("hand")
		row.avatar.PaintOver = function(t, w, h)
			-- Outline
			surface.SetDrawColor(self.cPlayerOutline)
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		row.avatar.OnMouseReleased = function(t, key)
			if (key == MOUSE_RIGHT) then
				local client = row.player

				if (IsValid(row) and IsValid(client)) then
					local menu = DermaMenu()

					menu:AddOption(L("viewProfile"), function()
						if IsValid(client) then client:ShowProfile() end
					end)

					menu:AddOption(L("copySteamID"), function()
						if IsValid(client) then SetClipboardText(client:IsBot() and client:EntIndex() or client:SteamID()) end
					end)

					if IsValid(client) then hook.Run("PopulateScoreboardPlayerMenu", client, menu) end
					menu:Open()
				end
			end
		end
		row.avatar:SetHelixTooltip(function(tooltip)
			local client = row.player

			if (IsValid(row) and IsValid(client)) then
				hook.Run("PopulatePlayerTooltip", client, tooltip)
			end
		end)

		if (LocalPlayer() != client) then
			row.voice = row:Add("DImageButton")
			row.voice:SetSize(16, 16)
			row.voice:Dock(RIGHT)
			row.voice:DockMargin(4, 4, 4, 4)
			row.voice.DoClick = function()
				if (IsValid(row) and IsValid(client)) then
					client:SetMuted(!client:IsMuted())
					row:Update()
				end
			end
			row.voice.m_Image.PaintAt = function(t, x, y, dw, dh)
				dw, dh = dw or t:GetWide(), dh or t:GetTall()

				t:LoadMaterial()
				if (!t.m_Material) then return true end

				surface.SetMaterial(t.m_Material)
				surface.SetDrawColor(t.m_Color.r, t.m_Color.g, t.m_Color.b, t.m_Color.a)
				surface.DrawTexturedRect(0, dh * 0.5 - 16 * 0.5 + 1, 16, 16)
			end
		end

		row.Update = function(t)
			if (IsValid(t.voice)) then
				t.voice:SetImage(client:IsMuted() and "icon16/sound_mute.png" or "icon16/sound.png")
			end
		end

		row:Update()
		panel:SizeToContents()
		client.ixScoreboardSlot = row

		return true
	end
end

function PANEL:Paint(w, h)
	-- Black box
	surface.SetDrawColor(self.cBackground)
	surface.DrawRect(0, 0, w, 36)

	-- Outline
	surface.SetDrawColor(self.cBackgroundOutline)
	surface.DrawOutlinedRect(0, 0, w, 36)

	ix.util.DrawText(GetHostName(), w * 0.01, 36 / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, self.fTitle)
	local tx = ix.util.DrawText(player.GetCount().."/"..game.MaxPlayers(), w * 0.99, 36 / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, self.fTitle)
	ix.util.DrawText("PLAYERS:", w - tx - ScreenScale(8), 36 / 2, self.cLabel, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, self.fLabel)
end

vgui.Register("ixScoreboard", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["scoreboard"] = function(container)
		container:Add("ixScoreboard")
	end
end)
