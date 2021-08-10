local function VBarPaint(panel)
	local vbar = panel:GetVBar()
    vbar.Paint = function() end
    vbar.btnUp.Paint = function() end
    vbar.btnDown.Paint = function() end
    vbar.btnGrip.Paint = function(panel, w, h)
        if (panel.Depressed) then
            draw.RoundedBox(4, 2, 1, 6, h - 2, ColorAlpha(color_white, 75))
            return
        end

        if (panel:IsHovered()) then
            draw.RoundedBox(4, 2, 1, 6, h - 2, ColorAlpha(color_white, 50))
            return
        end

        draw.RoundedBox(4, 2, 1, 6, h - 2, ColorAlpha(color_white, 25))
    end
end

local function AddButonFooter(parent, text, addictive, callback)
	local btn = parent:Add("DButton")
	btn:Dock(TOP)
	btn:SetTextColor(color_white)
	btn:DockMargin(0, 0, 0, 5)
	btn:SetText(text)
	btn.DoClick = callback
	btn.Paint = function(t, w, h)
		derma.SkinFunc("PaintButton2", t, w, h, t:IsHovered() and ix.config.Get("color"))
	end

	if (addictive) then
		parent:SetTall(parent:GetTall() + btn:GetTall())
	else
		parent:SetTall(btn:GetTall())
	end

	return btn
end

local imgur_patterns = {
	"https?://[www%.]*.?i.imgur.com/(%w+)",
	"https?://[www%.]*.?imgur.com/a/(%w+)",
	"https?://[www%.]*.?imgur.com/gallery/(%w+)"
}

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() * 0.6, ScrH() * 0.7)
	self:SetTitle(L"squad_menu_title")
	self:Center()
	self:MakePopup()
	self:SetDraggable(true)
	-- self:SetSkin("Default")

	self.netData = {}
	self.categoryPanels = {}
	self.memberTags = {}

	self.lblTitle:SetFont("MapFont")
	self.lblTitle.UpdateColours = function(label)
		return label:SetTextStyleColor(color_white)
	end

	self.header = self:Add("Panel")
	self.header:Dock(TOP)

	self.leftPanel = self:Add("DScrollPanel")
	self.leftPanel:SetWide(self:GetWide() * 0.5 - 7)
	self.leftPanel:Dock(LEFT)
	self.leftPanel:DockMargin(0, 4, 0, 4)
	self.leftPanel:SetPaintBackground(false)
	VBarPaint(self.leftPanel)

	self.rightPanel = self:Add("Panel")
	self.rightPanel:SetWide(self:GetWide() * 0.5 - 7)
	self.rightPanel:Dock(RIGHT)
	self.rightPanel:DockMargin(0, 4, 0, 4)

	self.logoSideLeft = self.leftPanel:Add("Panel")
	self.logoSideLeft:SetTall(128)
	self.logoSideLeft:Dock(TOP)
	self.logoSideLeft:DockMargin(4, 4, 0, 4)
end

function PANEL:IsLeader()
	return self.leader
end

function PANEL:IsOfficer()
	return self.officer
end

function PANEL:SetMembers(data, bNotTnitLeftSide)
	local text_rank
	local localSteamID64 = LocalPlayer():SteamID64()

	self:AddCategory("Leader")
	self:AddCategory("Officers")
	self:AddCategory("Members")

	for sid, rank in pairs(data.members) do
		if (IsValid(self.memberTags[sid])) then
			if (self.memberTags[sid].sq_rank != rank) then
				self.memberTags[sid]:Remove()
				self.memberTags[sid] = nil
			else
				continue
			end
		end

		text_rank = "Members"

		if (rank == 2) then
			text_rank = "Leader"
		elseif (rank == 1) then
			text_rank = "Officers"
		end

		if (!self.categoryPanels[text_rank]) then continue end

		local nametag = self.categoryPanels[text_rank][1]:Add("ixSquadMemberTag")
		nametag.name:SetFont("squadNameTag")
		nametag:SetAvatar(sid)
		nametag:SizeToContents()
		nametag.sq_rank = rank

		self.memberTags[sid] = nametag

		if (sid == localSteamID64) then
			if (rank == 2) then
				self.leader = true
			elseif (rank == 1) then
				self.officer = true
			end
		end
	end

	self.data = data
	if (!bNotTnitLeftSide) then
		self:InitLeftSide(data)
	end
end

function PANEL:InitLeftSide(data)
	if (self:IsLeader()) then
		self.entryName = self.header:Add("DTextEntry")
		self.entryName:SetFont("ixMenuButtonFont")
		self.entryName:SetPlaceholderText(L"squad_menu_holdername")
		self.entryName:SetPlaceholderColor(color_white)
		self.entryName:SetTall(32)
		self.entryName:Dock(TOP)
		self.entryName:SetUpdateOnType(true)
		self.entryName.OnEnter = function(_, value)
			if (#value > 0 and value != self.data.name) then
				self.netData["name"] = value:Trim()
			end
		end
		self.entryName.AllowInput = function(t, newCharacter)
			if (string.len(t:GetText() .. newCharacter) > 48) then
				surface.PlaySound("common/talk.wav")
				return true
			end
		end
		self.entryName.Think = function(t)
			local text = t:GetText()

			if (text:utf8len() > 48) then
				local newText = text:utf8sub(0, 48)

				t:SetText(newText)
				t:SetCaretPos(newText:utf8len())
			end
		end
		self.entryName.Paint = function(t, w, h)
			surface.SetDrawColor(90, 90, 90, 255)
			surface.DrawRect(0, 0, w, h)

			if (t.GetPlaceholderText and t.GetPlaceholderColor and t:GetPlaceholderText() and t:GetPlaceholderText():Trim() != "" and t:GetPlaceholderColor() and ( !t:GetText() or #t:GetText() == 0 )) then

				local oldText = t:GetText()
				t:SetText(t:GetPlaceholderText())
				t:DrawTextEntryText(color_white, ix.config.Get("color"), color_white)
				t:SetText(oldText)

				return
			end

			t:DrawTextEntryText(color_white, ix.config.Get("color"), color_white)
		end
	else
		self.entryName = self.header:Add("DLabel")
		self.entryName:SetFont("ixMenuButtonFont")
		self.entryName:SetTall(32)
		self.entryName:Dock(TOP)
		self.entryName:SetContentAlignment(5)
	end

	self.entryName:SetText(data.name)

	self.squad_color = self.header:Add("Panel")
	self.squad_color.color = data.color or color_white
	self.squad_color:Dock(TOP)
	self.squad_color:DockMargin(0, 4, 0, 4)
	self.squad_color:SetTall(8)
	self.squad_color.Paint = function(t, w, h)
		draw.RoundedBox(4, 0, 0, w, h, self.netData["color"] or t.color or color_white)
	end

	self.header:SetTall(self.entryName:GetTall() + self.squad_color:GetTall() + 4)

	local logo_lbl = self.logoSideLeft:Add("DLabel")
	logo_lbl:SetFont("ixSmallFont")
	logo_lbl:SetText(L"squad_menu_text_logo")
	logo_lbl:SetTextColor(color_white)
	logo_lbl:Dock(TOP)

	if (self:IsLeader()) then
		self.squadImg = self.logoSideLeft:Add("DImageButton")
		self.squadImg.DoClick = function(t)
			Derma_StringRequest(
				L"squad_menu_text_logo2", 
				L"squad_menu_holderlogo",
				"",
				function(text)
					if (#text == 0) then
						self.netData["logoID"] = "ovW4MBM"

						ix.util.FetchImage("ovW4MBM", function(mat)
							self.squadImg:SetMaterial(mat or Material("icon16/cross.png")) -- ix.util.GetMaterial
						end)
					else
						for _, v in ipairs(imgur_patterns) do
							local logoID = text:match(v)

							if (logoID) then
								self.netData["logoID"] = logoID
								break
							end
						end

						if (self.netData["logoID"]) then
							ix.util.FetchImage(self.netData["logoID"], function(mat)
								self.squadImg:SetMaterial(mat or Material("icon16/cross.png")) -- ix.util.GetMaterial
							end)
						end
					end
				end,
				function(text) end
			)
		end
	else
		self.squadImg = self.logoSideLeft:Add("DImage")
	end

	self.squadImg:SetSize(128, 128)
	self.squadImg:Dock(LEFT)

    ix.util.FetchImage(data.logo or "ovW4MBM", function(mat) -- squad logo
		self.squadImg:SetMaterial(mat or Material("icon16/cross.png"))
    end)

	self:InitRightSide(data)
end

function PANEL:InitRightSide(data)
	local message_lbl = self.rightPanel:Add("DLabel")
	message_lbl:SetFont("ixSmallFont")
	message_lbl:SetText(L"squad_menu_messageday")
	message_lbl:SetTextColor(color_white)
	message_lbl:Dock(TOP)

	self.entryMessage = self.rightPanel:Add("RichText")
	self.entryMessage:Dock(FILL)
	self.entryMessage.text = data.description or ""
	self.entryMessage:SetText(self.entryMessage.text)
	self.entryMessage.PerformLayout = function(t)
		t:SetFontInternal("ixMenuButtonFontSmall")
		t:SetFGColor(Color("green"))
	end

	-- Actions

	local a1 = self.rightPanel:Add("Panel")
	a1:Dock(BOTTOM)
	a1:DockMargin(0, 4, 0, 4)

	local actions_lbl = a1:Add("DLabel")
	actions_lbl:SetFont("ixSmallFont")
	actions_lbl:SetText("Actions")
	actions_lbl:SetTextColor(color_white)
	actions_lbl:Dock(TOP)

--[[ 	if (self:IsLeader()) then
		AddButonFooter(a1, "Squad logs", true, function(t)
			// TODO: реализовать логи
		end)
	end ]]

	if (self:IsLeader() or self:IsOfficer()) then
		AddButonFooter(a1, L"squad_menu_btn_invite", true, function(t)
			local menu = DermaMenu()

			for _, v in ipairs(player.GetAll()) do
				if (IsValid(v) and v != LocalPlayer() and LocalPlayer():GetPos():DistToSqr(v:GetPos()) < 160*160) then
					if (self.data.members[v:SteamID64()]) then continue end

					menu:AddOption(v:Name(), function()
						net.Start("ixSquadInvite")
							net.WriteEntity(v)
						net.SendToServer()
					end)
				end
			end

			menu:Open()
		end)
	end

	if (self:IsLeader()) then
		AddButonFooter(a1, L"squad_menu_btn_color", true, function(t)
			local color = vgui.Create("DColorCombo")
			color:SetupCloseButton(function() CloseDermaMenus() end)
			color:SetColor(color_white)
			color.OnValueChanged = function(_, col)
				self.netData["color"] = col
			end

			local menu = DermaMenu()
			menu:AddPanel(color)
			menu:SetPaintBackground(false)
			menu:Open(gui.MouseX() + 8, gui.MouseY() + 10)
		end)

		AddButonFooter(a1, L"squad_menu_btn_disband", true, function(t)
			Derma_Query(L"squad_menu_btn_ask_disband", L"squad_menu_btn_disband", L"text_yes", function()
				net.Start("ixSquadDisband")
				net.SendToServer()

				self:Remove()
			end, L"text_no")
		end)
	else
		AddButonFooter(a1, L"squad_menu_btn_leave", true, function(t)
			net.Start("ixSquadLeave")
			net.SendToServer()

			self:Remove()
		end)
	end

	a1:SetTall(a1:GetTall() + actions_lbl:GetTall())

	if (self:IsLeader()) then
		a1 = self.rightPanel:Add("Panel")
		a1:Dock(BOTTOM)
		a1:DockMargin(0, 4, 0, 4)

		AddButonFooter(a1, L"squad_menu_btn_editdesc", nil, function(t)
			if (IsValid(self.notepad)) then
				self.notepad:Remove()
			end

			self.notepad = self:Add("DFrame")
			self.notepad:SetSize(self.entryMessage:GetSize())
			self.notepad:MakePopup()
			self.notepad:SetPos(self:GetPos())
			self.notepad:SetTitle(L"squad_menu_messageday")

			self.descNotepad = self.notepad:Add("DTextEntry")
			self.descNotepad:SetFont("ixMenuButtonFontSmall")
			self.descNotepad:SetPlaceholderText(L"squad_menu_holderdesc")
			self.descNotepad:SetMultiline(true)
			self.descNotepad:Dock(FILL)
			self.descNotepad:SetText(self.entryMessage.text)
			self.descNotepad:SetUpdateOnType(true)
			self.descNotepad.AllowInput = function(t, newCharacter)
				if (string.len(t:GetText() .. newCharacter) > 2048) then
					surface.PlaySound("common/talk.wav")
					return true
				end
			end
			self.descNotepad.Think = function(t)
				local text = t:GetText()

				if (text:utf8len() > 2048) then
					local newText = text:utf8sub(0, 2048)

					t:SetText(newText)
					t:SetCaretPos(newText:utf8len())
				end
			end
			self.descNotepad.OnValueChange = function(_, value)
				self.notepad.save_desc = true

				self.entryMessage.text = value
				self.entryMessage:SetText(self.entryMessage.text)
			end
			self.descNotepad.Paint = function(t, w, h)
				surface.SetDrawColor(90, 90, 90, 255)
				surface.DrawRect(0, 0, w, h)

				if (t.GetPlaceholderText and t.GetPlaceholderColor and t:GetPlaceholderText() and t:GetPlaceholderText():Trim() != "" and t:GetPlaceholderColor() and ( !t:GetText() or #t:GetText() == 0 )) then

					local oldText = t:GetText()
					t:SetText(t:GetPlaceholderText())
					t:DrawTextEntryText(color_white, ix.config.Get("color"), color_white)
					t:SetText(oldText)

					return
				end

				t:DrawTextEntryText(color_white, ix.config.Get("color"), color_white)
			end

			self.closeNotepad = self.notepad:Add("DButton")
			self.closeNotepad:Dock(BOTTOM)
			self.closeNotepad:SetText(L"squad_menu_btn_save")
			self.closeNotepad:SetTall(32)
			self.closeNotepad.DoClick = function()
				if (self.notepad.save_desc) then
					self.netData["description"] = self.descNotepad:GetValue()
					self.entryMessage.text = self.netData["description"]
					self.entryMessage:SetText(self.netData["description"])
					self.entryMessage:PerformLayout()
				end

				self.notepad:Remove()
			end
		end)
	end
end

function PANEL:AddCategory(title)
	if (!self.categoryPanels[title]) then
		local cat = vgui.Create('DCollapsibleCategory', self.leftPanel)
		cat.Paint = function() end
		cat.Header:SetFont("ixSmallFont")
		cat.Header:SetContentAlignment(4)
		cat.Header.Paint = function(t, w, h)
			derma.SkinFunc("PaintButton2", t, w, h, t:IsHovered() and ix.config.Get("color"))
		end
		cat:SetLabel(L2("squad_menu_text_" .. title) or title)
		cat:Dock(TOP)
		cat.Think = function(t)
			if ((t.nextThink or 0) < CurTime()) then
				t.nextThink = CurTime() + 1
			else
				return
			end

			if (t.Contents) then
				if (#t.Contents:GetChildren() < 1) then
					t:Remove()
					self.categoryPanels[title] = nil
				else
					t:SetLabel(Format("%s: %d", title, #t.Contents:GetChildren()))
				end
			end
		end

		local slot = vgui.Create('DIconLayout', cat)
		slot:SetSpaceX(5)
		slot:SetSpaceY(5)
		slot:SetBorder(5)
		slot:Dock(TOP)
		slot:InvalidateLayout(true)

		cat:SetContents(slot)

		self.categoryPanels[title] = {slot, cat}
		return self.categoryPanels
	end
end

function PANEL:OnRemove()
	if (!table.IsEmpty(self.netData)) then
		net.Start("ixSquadSettings")
			net.WriteTable(self.netData)
		net.SendToServer()
	end
end

function PANEL:OnKeyCodeReleased(key_code)
	if (input.LookupKeyBinding(key_code) == "gm_showspare2") then
		self:Remove()
	end
end

function PANEL:Paint(w, h)
	derma.SkinFunc("PaintFrame2", self, w, h)
end

vgui.Register("ixSquadView", PANEL, "DFrame")

PANEL = {}

function PANEL:Init()
	self.name = self:Add("DLabel")
	self.avatar = self:Add("AvatarImage")
end

function PANEL:OnMousePressed(code)
	if (code == MOUSE_RIGHT) then
		local menu = DermaMenu()

		menu:AddOption(L("viewProfile"), function()
			gui.OpenURL("https://steamcommunity.com/profiles/" .. self.steamid)
		end):SetImage("icon16/report_user.png")

		if (LocalPlayer():SteamID64() != self.steamid) then
			menu:AddSpacer()
			menu:AddOption(L"squad_menu_opt_sendpm", function()
				Derma_StringRequest(
					L"squad_menu_opt_sendpm":utf8upper(), 
					L"squad_menu_opt_message",
					"",
					function(text)
						if (#text > 0) then
							for _, v in ipairs(player.GetAll()) do
								if (IsValid(v) and v:SteamID64() == self.steamid) then
									RunConsoleCommand("say", "/pm", v:Name(), text)
									break
								end
							end
						end
					end,
					function(text) end
				)
			end):SetImage("icon16/user_comment.png")
		end

		local squad = ix.squad.list[LocalPlayer():GetCharacter():GetSquadID()]

		if (squad and squad.members[self.steamid] and LocalPlayer():SteamID64() != self.steamid) then
			local rank = squad:GetRank(LocalPlayer())

			if (rank and rank != 0) then
				if (squad:IsLeader(LocalPlayer())) then
					if (squad.members[self.steamid] == 0) then
						menu:AddSpacer()
						menu:AddOption(L"squad_menu_btn_raiseofficer", function()
							Derma_Query(L"squad_menu_btn_ask_raiseofficer", L"squad_menu_btn_raise", L"text_yes", function()
								net.Start("ixSquadRankChange")
									net.WriteString(self.steamid)
								net.SendToServer()
							end, L"text_no")
						end):SetImage("icon16/user_go.png")
					else
						menu:AddSpacer()
						menu:AddOption(L"squad_menu_btn_demote", function()
							Derma_Query(L"squad_menu_btn_ask_demote", L"squad_menu_text_demote", L"text_yes", function()
								net.Start("ixSquadRankChange")
									net.WriteString(self.steamid)
								net.SendToServer()
							end, L"text_no")
						end):SetImage("icon16/user.png")
					end
				end

				if (rank != 0 and squad.members[self.steamid] == 0) then
					menu:AddSpacer()
					menu:AddOption(L"squad_menu_btn_kickmember", function()
						Derma_Query(L("squad_menu_text_kickmember", self.name:GetText(), squad.name), L"squad_menu_btn_kickmember", L"text_yes", function()
							net.Start("ixSquadKickMember")
								net.WriteString(self.steamid)
							net.SendToServer()
						end, L"text_no")
					end):SetImage("icon16/user_delete.png")
				end
			end
		end

		menu:Open()
	end
end

function PANEL:SetAvatar(steamid)
	self.noname = true

	self.avatar:SetSteamID(steamid, 32)
	self.name:SetText(steamid)

	for _, v in ipairs(player.GetAll()) do
		if (IsValid(v) and v:SteamID64() == steamid) then
			self.name:SetTextColor(ix.option.Get("squadTeamColor", Color(51, 153, 255)))
			self.name:SetText(v:Name())
			ix.steam.users[steamid] = v:Name()
			self.steamName = true
			self.noname = nil
			break
		end
	end

	self.steamid = steamid
	self.nextSteamQuery = nil
	self:UpdateNickname(steamid)
end

function PANEL:UpdateNickname(steamid)
	if (ix.steam.users[steamid]) then
		self.name:SetText(ix.steam.users[steamid])
		self.noname = nil
	elseif (!self.steamName and (self.nextSteamQuery or 0) < CurTime()) then
		local name = ix.steam.GetNickName(steamid)

		if name then 
			self.name:SetText(name)
			self.noname = nil
		end
	end
end

function PANEL:Think()
	if (self.next_think or 0) < CurTime() then
		if (self.noname and self.steamid) then
			self:UpdateNickname(self.steamid)
			self.nextSteamQuery = CurTime() + 10
		end

		local panel = ix.gui.squad
		if (IsValid(panel) and panel.data and !panel.data.members[self.steamid]) then
			panel.memberTags[self.steamid] = nil

			if (self.text_rank) then
				local cat = panel.categoryPanels[self.text_rank]

				if (cat and IsValid(cat[2])) then
					cat[2]:SetLabel(Format("%s: %d", self.text_rank, #cat[2].Contents:GetChildren()))
				end
			end

			self:Remove()
			return
		end

		self.next_think = CurTime() + 1
	end
end

function PANEL:Paint(w, h)
	if (self:IsHovered()) then
		self:SetCursor("hand")

		surface.SetDrawColor(46, 46, 46, 200)
		surface.DrawRect(self.avatar:GetWide(), 0, w - self.avatar:GetWide(), h)

		surface.SetDrawColor(ix.config.Get("color"))
		surface.DrawOutlinedRect(self.avatar:GetWide(), 0, w - self.avatar:GetWide(), h)
	else
		self:SetCursor("arrow")

		surface.SetDrawColor(35, 35, 35)
		surface.DrawRect(0, 0, w, h)
	end
end

function PANEL:PerformLayout(width, height)
	self.name:SetPos(width - self.name:GetWide() - 8, height / 2 - self.name:GetTall() / 2)
	self.avatar:MoveLeftOf(self.name, 16 * 0.5)
end

function PANEL:SizeToContents()
	self.name:SizeToContents()

	local tall = self.name:GetTall()
	self.avatar:SetSize(tall + 16, tall + 16)
	self:SetSize(self.name:GetWide() + self.avatar:GetWide() + 32 * 0.5, self.name:GetTall() + 16)
end

vgui.Register("ixSquadMemberTag", PANEL, "Panel")