/*
* About time I made a library for general use!
* You can copy this file for your own server/personal use.
* What you can't do is use it in a commercial project without my approval (add me at http://steamcommunity.com/id/shendow/)
* I won't provide much support if you run into trouble editing this file.
*/

local base_table = SH_SZ
local font_prefix = "SH_SZ."

--
local matClose = Material("shenesis/general/close.png", "noclamp smooth")

local function get_scale()
	local sc = math.Clamp(ScrH() / 1080, 0.7, 1)
	if (!th) then
		th = 48 * sc
		m = th * 0.25
	end

	return sc
end

function base_table:GetPadding()
	return th
end

function base_table:GetMargin()
	return m
end

function base_table:GetScreenScale()
	return get_scale()
end

function base_table:CreateFonts(scale)
	local font = self.Font
	local font_bold = self.FontBold

	local sizes = {
		[12] = "Small",
		[16] = "Medium",
		[20] = "Large",
		[24] = "Larger",
		[32] = "Largest",
		[200] = "3D",
	}

	for s, n in pairs (sizes) do
		surface.CreateFont(font_prefix .. n, {font = font, size = s * scale})
		surface.CreateFont(font_prefix .. n .. "B", {font = font_bold, size = s * scale})
	end
end

hook.Add("InitPostEntity", font_prefix .. "CreateFonts", function()
	base_table:CreateFonts(get_scale())
end)

function base_table:MakeWindow(title)
	local scale = get_scale()
	local styl = self.Style

	local pnl = vgui.Create("EditablePanel")
	pnl.m_bDraggable = true
	pnl.SetDraggable = function(me, b)
		me.m_bDraggable = b
	end
	pnl.Paint = function(me, w, h)
		if (me.m_fCreateTime) then
			Derma_DrawBackgroundBlur(me, me.m_fCreateTime)
		end

		draw.RoundedBox(4, 0, 0, w, h, styl.bg)
	end
	pnl.OnClose = function() end
	pnl.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:AlphaTo(0, 0.1, 0, function()
			me:Remove()
		end)
		me:OnClose()
	end

		local header = vgui.Create("DPanel", pnl)
		header:SetTall(th)
		header:Dock(TOP)
		header.Paint = function(me, w, h)
			draw.RoundedBoxEx(4, 0, 0, w, h, styl.header, true, true, false, false)
		end
		header.Think = function(me)
			if (me.Hovered and pnl.m_bDraggable) then
				me:SetCursor("sizeall")
			end

			local drag = me.m_Dragging
			if (drag) then
				local mx, my = math.Clamp(gui.MouseX(), 1, ScrW() - 1), math.Clamp(gui.MouseY(), 1, ScrH() - 1)
				local x, y = mx - drag[1], my - drag[2]

				pnl:SetPos(x, y)
			end
		end
		header.OnMousePressed = function(me)
			if (pnl.m_bDraggable) then
				me.m_Dragging = {gui.MouseX() - pnl.x, gui.MouseY() - pnl.y}
				me:MouseCapture(true)
			end
		end
		header.OnMouseReleased = function(me)
			me.m_Dragging = nil
			me:MouseCapture(false)
		end

			local titlelbl = self:QuickLabel(title, font_prefix .. "Larger", styl.text, header)
			titlelbl:Dock(LEFT)
			titlelbl:DockMargin(m, 0, 0, 0)
			pnl.m_Title = titlelbl

			local close = vgui.Create("DButton", header)
			close:SetText("")
			close:SetWide(th)
			close:Dock(RIGHT)
			close.Paint = function(me, w, h)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, styl.close_hover, false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, styl.hover, false, true, false, false)
				end

				surface.SetDrawColor(me:IsDown() and styl.text_down or styl.text)
				surface.SetMaterial(matClose)
				surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, 16 * scale, 16 * scale, 0)
			end
			close.DoClick = function(me)
				pnl:Close()
			end
			pnl.m_Close = close

	return pnl
end

function base_table:QuickLabel(t, f, c, p)
	local l = vgui.Create("DLabel", p)
	l:SetText(t)
	l:SetFont(f:Replace("{prefix}", font_prefix))
	l:SetColor(c)
	l:SizeToContents()

	return l
end

function base_table:QuickButton(t, cb, p, f, c)
	local styl = self.Style

	local b = vgui.Create("DButton", p)
	b:SetText(t)
	b:SetFont((f or "{prefix}Medium"):Replace("{prefix}", font_prefix))
	b:SetColor(c or styl.text)
	b:SizeToContents()
	b.DoClick = function(me)
		cb(me)
	end
	b.Paint = function(me, w, h)
		draw.RoundedBox(4, 0, 0, w, h, me.m_Background or styl.inbg)

		if (me.Hovered) then
			draw.RoundedBox(4, 0, 0, w, h, styl.hover)
		end

		if (me:IsDown()) then
			draw.RoundedBox(4, 0, 0, w, h, styl.hover)
		end
	end

	return b
end

function base_table:QuickEntry(tx, parent)
	local styl = self.Style

	local entry = vgui.Create("DTextEntry", parent)
	entry:SetText(tx or "")
	entry:SetFont("SH_SZ.Medium")
	entry:SetDrawLanguageID(false)
	entry:SetUpdateOnType(true)
	entry.Paint = function(me, w, h)
		draw.RoundedBox(4, 0, 0, w, h, styl.textentry)
		me:DrawTextEntryText(me:GetTextColor(), me:GetHighlightColor(), me:GetCursorColor())
	end

	return entry
end

function base_table:PaintScroll(panel)
	local styl = self.Style

	local scr = panel:GetVBar()
	scr.Paint = function(_, w, h)
		draw.RoundedBox(4, 0, 0, w, h, /* styl.header */ styl.bg)
	end

	scr.btnUp.Paint = function(_, w, h)
		draw.RoundedBox(4, 2, 0, w - 4, h - 2, styl.inbg)
	end
	scr.btnDown.Paint = function(_, w, h)
		draw.RoundedBox(4, 2, 2, w - 4, h - 2, styl.inbg)
	end

	scr.btnGrip.Paint = function(me, w, h)
		draw.RoundedBox(4, 2, 0, w - 4, h, styl.inbg)

		if (me.Hovered) then
			draw.RoundedBox(4, 2, 0, w - 4, h, styl.hover2)
		end

		if (me.Depressed) then
			draw.RoundedBox(4, 2, 0, w - 4, h, styl.hover2)
		end
	end
end

function base_table:StringRequest(title, text, callback)
	local styl = self.Style

	if (IsValid(_LOUNGE_STRREQ)) then
		_LOUNGE_STRREQ:Remove()
	end

	local scale = get_scale()
	local wi, he = 600 * scale, 160 * scale

	local cancel = vgui.Create("DPanel")
	cancel:SetDrawBackground(false)
	cancel:StretchToParent(0, 0, 0, 0)
	cancel:MoveToFront()
	cancel:MakePopup()

	local pnl = self:MakeWindow(title)
	pnl:SetSize(wi, he)
	pnl:Center()
	pnl:MakePopup()
	pnl.m_fCreateTime = SysTime()
	_LOUNGE_STRREQ = pnl

	cancel.OnMouseReleased = function(me, mc)
		if (mc == MOUSE_LEFT) then
			pnl:Close()
		end
	end
	cancel.Think = function(me)
		if (!IsValid(pnl)) then
			me:Remove()
		end
	end

		local body = vgui.Create("DPanel", pnl)
		body:SetDrawBackground(false)
		body:Dock(FILL)
		body:DockPadding(m, m, m, m)

			local tx = self:QuickLabel(text, font_prefix .. "Large", styl.text, body)
			tx:SetContentAlignment(5)
			tx:SetWrap(tx:GetWide() > wi - m * 2)
			tx:Dock(FILL)

			local apply = vgui.Create("DButton", body)
			apply:SetText("OK")
			apply:SetColor(styl.text)
			apply:SetFont(font_prefix .. "Medium")
			apply:Dock(BOTTOM)
			apply.Paint = function(me, w, h)
				draw.RoundedBox(4, 0, 0, w, h, styl.inbg)

				if (me.Hovered) then
					draw.RoundedBox(4, 0, 0, w, h, styl.hover)
				end

				if (me:IsDown()) then
					draw.RoundedBox(4, 0, 0, w, h, styl.hover)
				end
			end

			local entry = vgui.Create("DTextEntry", body)
			entry:RequestFocus()
			entry:SetFont(font_prefix .. "Medium")
			entry:SetDrawLanguageID(false)
			entry:Dock(BOTTOM)
			entry:DockMargin(0, m, 0, m)
			entry.Paint = function(me, w, h)
				draw.RoundedBox(4, 0, 0, w, h, styl.textentry)
				me:DrawTextEntryText(me:GetTextColor(), me:GetHighlightColor(), me:GetCursorColor())
			end
			entry.OnEnter = function()
				apply:DoClick()
			end

			apply.DoClick = function()
				pnl:Close()
				callback(entry:GetValue())
			end

	pnl.OnFocusChanged = function(me, gained)
		if (!gained) then
			timer.Simple(0, function()
				if (!IsValid(me) or vgui.GetKeyboardFocus() == entry) then
					return end

				me:Close()
			end)
		end
	end

	pnl:SetWide(math.max(math.min(tx:GetWide() + m * 2, pnl:GetWide()), th * 2))
	pnl:CenterHorizontal()

	pnl:SetAlpha(0)
	pnl:AlphaTo(255, 0.1)
end

function base_table:Menu()
	local styl = self.Style

	if (IsValid(_LOUNGE_MENU)) then
		_LOUNGE_MENU:Remove()
	end

	local cancel = vgui.Create("DPanel")
	cancel:SetDrawBackground(false)
	cancel:StretchToParent(0, 0, 0, 0)
	cancel:MoveToFront()
	cancel:MakePopup()

	local pnl = vgui.Create("DPanel")
	pnl:SetDrawBackground(false)
	pnl:SetSize(20, 1)
	pnl.AddOption = function(me, text, callback)
		surface.SetFont(font_prefix .. "MediumB")
		local wi, he = surface.GetTextSize(text)
		wi = wi + m * 2
		he = he + m

		me:SetWide(math.max(wi, me:GetWide()))
		me:SetTall(pnl:GetTall() + he)

		local btn = vgui.Create("DButton", me)
		btn:SetText(text)
		btn:SetFont(font_prefix .. "MediumB")
		btn:SetColor(styl.text)
		btn:Dock(TOP)
		btn:SetSize(wi, he)
		btn.Paint = function(me, w, h)
			surface.SetDrawColor(styl.menu)
			surface.DrawRect(0, 0, w, h)

			if (me.Hovered) then
				surface.SetDrawColor(styl.hover)
				surface.DrawRect(0, 0, w, h)
			end

			if (me:IsDown()) then
				surface.SetDrawColor(styl.hover)
				surface.DrawRect(0, 0, w, h)
			end
		end
		btn.DoClick = function(me)
			callback()
			pnl:Close()
		end
	end
	pnl.Open = function(me)
		me:SetPos(gui.MouseX(), math.min(math.max(0, ScrH() - me:GetTall()), gui.MouseY()))
		me:MakePopup()
	end
	pnl.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:AlphaTo(0, 0.1, 0, function()
			me:Remove()
		end)
	end
	_LOUNGE_MENU = pnl

	cancel.OnMouseReleased = function(me, mc)
		pnl:Close()
	end
	cancel.Think = function(me)
		if (!IsValid(pnl)) then
			me:Remove()
		end
	end

	return pnl
end

function base_table:PanelPaint(name)
	local styl = self.Style
	local col = styl[name] or styl.bg

	return function(me, w, h)
		draw.RoundedBox(4, 0, 0, w, h, col)
	end
end

// https://facepunch.com/showthread.php?t=1522945&p=50524545&viewfull=1#post50524545
local sin, cos, rad = math.sin, math.cos, math.rad
local rad0 = rad(0)
local function DrawCircle(x, y, radius, seg)
	local cir = {
		{x = x, y = y}
	}

	for i = 0, seg do
		local a = rad((i / seg) * -360)
		table.insert(cir, {x = x + sin(a) * radius, y = y + cos(a) * radius})
	end

	table.insert(cir, {x = x + sin(rad0) * radius, y = y + cos(rad0) * radius})
	surface.DrawPoly(cir)
end

function base_table:Avatar(ply, siz, par)
	if (type(ply) == "Entity" and !IsValid(ply)) then
		return end

	if (isnumber(ply)) then
		ply = tostring(ply)
	end

	siz = siz or 32
	local hsiz = siz * 0.5

	local url = "http://steamcommunity.com/profiles/" .. (isstring(ply) and ply or ply:SteamID64() or "")

	local pnl = vgui.Create("DPanel", par)
	pnl:SetSize(siz, siz)
	pnl:SetDrawBackground(false)
	pnl.Paint = function() end

		local av = vgui.Create("AvatarImage", pnl)
		if (isstring(ply)) then
			av:SetSteamID(ply, siz)
		else
			av:SetPlayer(ply, siz)
		end
		av:SetPaintedManually(true)
		av:SetSize(siz, siz)
		av:Dock(FILL)

			local btn = vgui.Create("DButton", av)
			btn:SetToolTip("Click here to view " .. (isstring(ply) and "their" or ply:Nick() .. "'s") .. " Steam Profile")
			btn:SetText("")
			btn:Dock(FILL)
			btn.Paint = function() end
			btn.DoClick = function(me)
				gui.OpenURL(url)
			end

	pnl.Paint = function(me, w, h)
		render.ClearStencil()
		render.SetStencilEnable(true)

		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)

		render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilPassOperation(STENCILOPERATION_ZERO)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
		render.SetStencilReferenceValue(1)

		draw.NoTexture()
		surface.SetDrawColor(color_black)
		DrawCircle(hsiz, hsiz, hsiz, hsiz)

		render.SetStencilFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilReferenceValue(1)

		av:PaintManual()

		render.SetStencilEnable(false)
		render.ClearStencil()
	end

	return pnl
end

local c = {}
function base_table:GetName(sid, cb)
	if (c[sid]) then
		cb(c[sid])
		return
	end

	for _, v in pairs (player.GetAll()) do
		if (v:SteamID64() == sid) then
			c[sid] = v:Nick()
			cb(v:Nick())
			return
		end
	end

	steamworks.RequestPlayerInfo(sid)
	timer.Simple(1, function()
		cb(steamworks.GetPlayerName(sid))
		c[sid] = cb
	end)
end

function base_table:Notify(msg, dur, bg)
	if (IsValid(_SH_NOTIFY)) then
		_SH_NOTIFY:Close()
	end

	dur = dur or 3
	bg = bg or self.Style.header

	local fnt = font_prefix .. "Larger"

	local p = vgui.Create("DButton")
	p:MoveToFront()
	p:SetText(self.Language[msg] or msg)
	p:SetFont(fnt)
	p:SetColor(self.Style.text)
	p:SetSize(ScrW(), draw.GetFontHeight(fnt) + self:GetMargin() * 2)
	p:AlignTop(ScrH())
	p.Paint = function(me, w, h)
		surface.SetDrawColor(bg)
		surface.DrawRect(0, 0, w, h)
	end
	p.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:MoveTo(0, ScrH(), 0.2, 0, -1, function()
			me:Remove()
		end)
	end
	p.DoClick = p.Close
	_SH_NOTIFY = p

	p:MoveTo(0, ScrH() - p:GetTall(), 0.2, 0, -1, function()
		p:MoveTo(0, ScrH(), 0.2, dur, -1, function()
			p:Remove()
		end)
	end)
end