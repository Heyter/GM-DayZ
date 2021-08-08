local function L(s, ...)
	return string.format(SH_SZ.Language[s] or s, ...)
end

function SH_SZ:GetStepText(step, numstep)
	local t = step.type
	if (t == "place") then
		return L("place_point_x", numstep)
	elseif (t == "confirm") then
		return L"finalize_placement"
	end
end

function SH_SZ:MakePoint(parent, pos, mx, my)
	local ep = LocalPlayer():EyePos()
	local av = LocalPlayer():GetAimVector()

	local pnt = self:QuickButton("P", function() end, parent)
	pnt:SetSize(24, 24)
	pnt:SetPos(mx - 12, my - 12)
	pnt.m_v3DPos = pos
	pnt.OnMousePressed = function(me, mc)
		if (mc == MOUSE_LEFT) then
			parent.m_DraggingPoint = me
		end
	end
	pnt.OnMouseReleased = function(me, mc)
		if (mc == MOUSE_LEFT and parent.m_DraggingPoint == me) then
			parent.m_DraggingPoint = nil
		end
	end
	pnt.OnCursorMoved = function(me)
		if (parent.m_DraggingPoint == me) then
			me:DoMove()
		end
	end
	pnt.Think = function(me)
		if (ep ~= LocalPlayer():EyePos() or av ~= LocalPlayer():GetAimVector()) then
			ep = LocalPlayer():EyePos()
			av = LocalPlayer():GetAimVector()

			local ts = me.m_v3DPos:ToScreen()
			local x, y = ts.x, ts.y
			me:SetPos(math.Clamp(x - 12, 0, ScrW() - 1), math.Clamp(y - 12, 0, ScrH() - 1))
			me:SetPaintedManually(x <= 0 or x >= ScrW() or y <= 0 or y >= ScrH())
		end
	end
	pnt.DoMove = function(me)
		local mx, my = gui.MousePos()
		me:SetPos(mx - me:GetWide() * 0.5, my - me:GetTall() * 0.5)

		local sp = LocalPlayer():GetShootPos()
		local t = {
			start = sp,
			endpos = sp + gui.ScreenToVector(mx, my) * 16384,
			filter = ents.GetAll(),
		}
		local tr = util.TraceLine(t)
		me.m_v3DPos = tr.HitPos
	end

		local function AddAxis(axis, ap, dir, col)
			cam.Start3D()
				local ap = (pos + dir * 64):ToScreen()
			cam.End3D()

			local ax = self:QuickButton(axis, function() end, parent)
			ax:SetSize(16, 16)
			ax:SetPos(ap.x - 8, ap.y - 8)
			ax.m_Background = col
			ax.OnMousePressed = pnt.OnMousePressed
			ax.OnMouseReleased = pnt.OnMouseReleased
			ax.OnCursorMoved = pnt.OnCursorMoved
			ax.DoMove = function()
				debugoverlay.Line(pos, pos + dir * 16384, 1, color_white, true)

				cam.Start3D()
					local np = gui.ScreenToVector(gui.MousePos())
				cam.End3D()

				local pp = np:Cross(pos)
				debugoverlay.Line(pp, pp + dir * 512, 1, Color(255, 0, 0), true)
			end
		end

		-- local x = AddAxis("X", xp, Vector(1, 0, 0), Color(255, 0, 0))
		-- local y = AddAxis("Y", yp, Vector(0, 1, 0), Color(0, 255, 0))
		-- local z = AddAxis("Z", zp, Vector(0, 0, 1), Color(0, 0, 255))

	pnt.OnRemove = function(me)
		-- if (IsValid(x)) then x:Remove() end
		-- if (IsValid(y)) then y:Remove() end
		-- if (IsValid(z)) then z:Remove() end
	end

	return pnt
end

local shape = SH_SZ.Shapes.cube
local points = {}
local sz_size = SH_SZ.MaximumSize
local sz_options = table.Copy(SH_SZ.DefaultOptions)
local curstep = 1
local curcat = 1
local cur, cursz
local last_mx, last_my
local moving_cam = false

local function step()
	return shape.steps[curstep]
end

local function advance_step()
	curstep = curstep + 1

	local new = step()
	_SZ_EDITOR_SIZE:SetVisible(new.type == "confirm")
end

local function reset()
	for _, pnt in pairs (points) do
		pnt:Remove()
	end

	points = {}
	curstep = 1
	_SZ_EDITOR_SIZE:SetVisible(false)
end

hook.Add("PostDrawTranslucentRenderables", "SH_SZ.PostDrawTranslucentRenderables", function()
	if (_SZ_EDITOR_OPEN and #points >= shape.points) then
		local pts = {}
		for _, v in ipairs (points) do
			table.insert(pts, v.m_v3DPos)
		end

		cam.Start3D()
			shape.render(pts, sz_size, color_white)
		cam.End3D()
	end
end)

local ss, styl, th, m, m2 = SH_SZ:GetScreenScale(), SH_SZ.Style, SH_SZ:GetPadding(), SH_SZ:GetMargin(), SH_SZ:GetMargin() * 0.5

function SH_SZ:MakeTabAdd(body)
	local tab_add = vgui.Create("DPanel", body)
	tab_add:SetDrawBackground(false)
	tab_add:Dock(FILL)

		local lbl = self:QuickLabel(L"safezone_type", "{prefix}Large", styl.text, tab_add)
		lbl:Dock(TOP)
		lbl:DockMargin(0, 0, 0, m2)

		local types = vgui.Create("DPanel", tab_add)
		types:SetTall(32 * ss + m * 2)
		types:Dock(TOP)
		types.Paint = function(me, w, h)
			draw.RoundedBox(4, 0, 0, w, h, styl.inbg)
		end

		for tid, typ in pairs (self.Shapes) do
			local mat = Material(typ.icon, "noclamp smooth")

			local tbtn = vgui.Create("DButton", types)
			tbtn:SetToolTip(L(typ.name))
			tbtn:SetText("")
			tbtn:SetSize(types:GetTall(), types:GetTall())
			tbtn:Dock(LEFT)
			tbtn.Paint = function(me, w, h)
				if (shape.id == typ.id) then
					draw.RoundedBox(4, m2, m2, w - m, h - m, styl.header)
				end

				surface.SetMaterial(mat)
				surface.SetDrawColor(styl.text)
				surface.DrawTexturedRect(w * 0.5 - 16 * ss, h * 0.5 - 16 * ss, 32 * ss, 32 * ss)
			end
			tbtn.DoClick = function(me, w, h)
				shape = typ
				reset()
			end
		end

		local lbl = self:QuickLabel(L"options", "{prefix}Large", styl.text, tab_add)
		lbl:Dock(TOP)
		lbl:DockMargin(0, m2, 0, m2)

		local opts = vgui.Create("DScrollPanel", tab_add)
		opts:Dock(FILL)
		opts:GetCanvas():DockPadding(m2, m2, m2, m2)
		opts.Paint = function(me, w, h)
			draw.RoundedBox(4, 0, 0, w, h, styl.inbg)
		end
		self:PaintScroll(opts)

			local function AddOption(id, text)
				local opt = sz_options[id] or self.DefaultOptions[id]

				local lbl = self:QuickLabel(L(text), "{prefix}Medium", styl.text, opts)
				lbl:SetMouseInputEnabled(true)
				lbl:SetKeyboardInputEnabled(true)
				lbl:SetTextInset(lbl:GetTall() + m2, 0)
				lbl:Dock(TOP)
				lbl:DockMargin(0, 0, 0, m2)

				if (isbool(opt)) then
					local btn = self:QuickButton("", function()
						sz_options[id] = not sz_options[id]
					end, lbl)
					btn:SetSize(lbl:GetTall(), lbl:GetTall())
					btn.Paint = function(me, w, h)
						local ok = sz_options[id]
						draw.RoundedBox(4, 0, 0, w, h, ok and styl.header or styl.bg)

						if (ok) then
							draw.SimpleText("✓", "SH_SZ.Medium", w * 0.5, h * 0.5, styl.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					end
				elseif (isnumber(opt)) then
					local entry = self:QuickEntry(opt, lbl)
					entry:SetNumeric(true)
					entry:SetSize(lbl:GetTall() * 2, lbl:GetTall())
					entry:DockMargin(0, m, 0, m)
					entry.OnValueChange = function(me, tx)
						sz_options[id] = tonumber(tx) or 0
					end

					lbl:SetTextInset(entry:GetWide() + m2, 0)
				elseif (isstring(opt)) then
					local entry = self:QuickEntry(opt, lbl)
					entry:SetSize(lbl:GetTall() * 10, lbl:GetTall())
					entry:DockMargin(0, m, 0, m)
					entry.OnValueChange = function(me, tx)
						sz_options[id] = tx
					end

					lbl:SetTextInset(entry:GetWide() + m2, 0)
				end
			end

			AddOption("name", "name")
			AddOption("namecolor", "name_color")
			AddOption("entermsg", "enter_message")
			AddOption("leavemsg", "leave_message")
			AddOption("hud", "enable_hud_indicator")
			AddOption("noatk", "prevent_attacking_with_weapons")
			AddOption("nonpc", "automatically_remove_npcs")
			AddOption("noprop", "delete_non_admin_props")
			AddOption("ptime", "time_until_protection_enables")

		local btns = vgui.Create("DPanel", tab_add)
		btns:SetDrawBackground(false)
		btns:Dock(BOTTOM)
		btns:DockMargin(0, m, 0, 0)

			local resetbtn = self:QuickButton(L"reset", function() end, btns)
			resetbtn:SetWide(100 * ss)
			resetbtn:Dock(LEFT)
			resetbtn.DoClick = function()
				reset()
			end

			local confirm = self:QuickButton(L"confirm", function() end, btns)
			confirm:SetWide(100 * ss)
			confirm:Dock(RIGHT)
			confirm.DoClick = function()
				if (#points < shape.points) then
					return end

				net.Start("SH_SZ.New")
					net.WriteUInt(shape.id, 16)

					for i = 1, shape.points do
						net.WriteVector(points[i].m_v3DPos)
					end

					net.WriteFloat(sz_size)

					net.WriteUInt(table.Count(sz_options), 16)
					for opt, val in pairs (sz_options) do
						net.WriteString(opt)
						net.WriteType(val)
					end
				net.SendToServer()

				reset()
			end

		btns.Think = function()
			confirm:SetVisible(step().type == "confirm")
		end

	return tab_add
end

function SH_SZ:MakeTabEdit(body)
	cur, cursz = nil, nil

	local tab_edit = vgui.Create("DPanel", body)
	tab_edit:SetVisible(false)
	tab_edit:SetDrawBackground(false)
	tab_edit:Dock(FILL)

		local scroll = vgui.Create("DScrollPanel", tab_edit)
		scroll:SetWide(120 * ss)
		scroll:Dock(LEFT)
		scroll:GetCanvas():DockPadding(m2, m2, m2, m2)
		scroll.Paint = function(me, w, h)
			draw.RoundedBox(4, 0, 0, w, h, styl.inbg)
		end
		self:PaintScroll(scroll)

		local edit = vgui.Create("DScrollPanel", tab_edit)
		edit:SetVisible(false)
		edit:Dock(FILL)
		edit:DockMargin(m, 0, 0, 0)
		edit:GetCanvas():DockPadding(m2, m2, m2, m2)
		edit.Paint = scroll.Paint
		tab_edit.m_Edit = edit
		self:PaintScroll(edit)

			edit.BuildList = function(me, sz)
				me:Clear()

				local lbl = self:QuickLabel(L"options", "{prefix}Large", styl.text, edit)
				lbl:Dock(TOP)
				lbl:DockMargin(0, 0, 0, m2)

				local function AddOption(id, text)
					local opt = sz.opts[id] or self.DefaultOptions[id]

					local lbl = self:QuickLabel(L(text), "{prefix}Medium", styl.text, edit)
					lbl:SetMouseInputEnabled(true)
					lbl:SetKeyboardInputEnabled(true)
					lbl:SetTextInset(lbl:GetTall() + m2, 0)
					lbl:Dock(TOP)
					lbl:DockMargin(0, 0, 0, m2)

					if (isbool(opt)) then
						local btn = self:QuickButton("", function()
							sz.opts[id] = not sz.opts[id]
						end, lbl)
						btn:SetSize(lbl:GetTall(), lbl:GetTall())
						btn.Paint = function(me, w, h)
							local ok = sz.opts[id]
							draw.RoundedBox(4, 0, 0, w, h, ok and styl.header or styl.bg)

							if (ok) then
								draw.SimpleText("✓", "SH_SZ.Medium", w * 0.5, h * 0.5, styl.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						end
					elseif (isnumber(opt)) then
						local entry = self:QuickEntry(opt, lbl)
						entry:SetNumeric(true)
						entry:SetSize(lbl:GetTall() * 2, lbl:GetTall())
						entry:DockMargin(0, m, 0, m)
						entry.OnValueChange = function(me, tx)
							sz.opts[id] = tonumber(tx) or 0
						end

						lbl:SetTextInset(entry:GetWide() + m2, 0)
					elseif (isstring(opt)) then
						local entry = self:QuickEntry(opt, lbl)
						entry:SetSize(lbl:GetTall() * 10, lbl:GetTall())
						entry:DockMargin(0, m, 0, m)
						entry.OnValueChange = function(me, tx)
							sz.opts[id] = tx
						end

						lbl:SetTextInset(entry:GetWide() + m2, 0)
					end
				end

				AddOption("name", "name")
				AddOption("namecolor", "name_color")
				AddOption("entermsg", "enter_message")
				AddOption("leavemsg", "leave_message")
				AddOption("hud", "enable_hud_indicator")
				AddOption("noatk", "prevent_attacking_with_weapons")
				AddOption("nonpc", "automatically_remove_npcs")
				AddOption("noprop", "delete_non_admin_props")
				AddOption("ptime", "time_until_protection_enables")

				me:SetVisible(true)
			end

		local btns = vgui.Create("DPanel", tab_edit)
		btns:SetVisible(false)
		btns:SetDrawBackground(false)
		btns:Dock(BOTTOM)
		btns:DockMargin(0, m, 0, 0)
		tab_edit.m_Buttons = btns

			local save = self:QuickButton(L"save", function() end, btns)
			save:SetWide(100 * ss)
			save:Dock(RIGHT)
			save.DoClick = function()
				net.Start("SH_SZ.Edit")
					net.WriteUInt(cur, 16)

					local shape = self.ShapesIndex[cursz.shape]
					for i = 1, shape.points do
						net.WriteVector(points[i].m_v3DPos)
						self.SafeZones[cur].points[i] = points[i].m_v3DPos
					end

					net.WriteFloat(sz_size)
					self.SafeZones[cur].size = sz_size

					net.WriteUInt(table.Count(cursz.opts), 16)
					for k, v in pairs (cursz.opts) do
						net.WriteString(k)
						net.WriteType(v)
						self.SafeZones[cur].opts[k] = v
					end
				net.SendToServer()

				if (IsValid(cursz.btn)) then
					cursz.btn:SetText(cursz.opts.name or "?")
				end
			end

			local tp = self:QuickButton(L"teleport_there", function() end, btns)
			tp:SetWide(100 * ss)
			tp:Dock(RIGHT)
			tp:DockMargin(m, 0, m, 0)
			tp.DoClick = function(me)
				net.Start("SH_SZ.Teleport")
					net.WriteUInt(cur, 16)
				net.SendToServer()

				me.m_vTeleporting = LocalPlayer():GetPos()
			end
			tp.Think = function(me)
				-- Update button positions
				if (me.m_vTeleporting and me.m_vTeleporting ~= LocalPlayer():GetPos()) then
					timer.Simple(0, function()
						for _, pnt in pairs (points) do
							if (!IsValid(pnt)) then
								return end

							local ts = pnt.m_v3DPos:ToScreen()
							pnt:SetPos(ts.x - pnt:GetWide() * 0.5, ts.y - pnt:GetTall() * 0.5)

							me.m_vTeleporting = nil
						end
					end)
				end
			end

			local delete = self:QuickButton(L"delete", function() end, btns)
			delete:SetColor(styl.close_hover)
			delete:SetWide(100)
			delete:Dock(RIGHT)
			delete.DoClick = function()
				net.Start("SH_SZ.Delete")
					net.WriteUInt(cur, 16)
				net.SendToServer()

				if (IsValid(cursz.btn)) then
					edit:SetVisible(false)
					btns:SetVisible(false)
					_SZ_EDITOR_SIZE:SetVisible(false)
					cursz.btn:Remove()

					for _, pnt in pairs (points) do
						if (!IsValid(pnt)) then
							return end

						pnt:Remove()
					end
					points = {}

					table.remove(self.SafeZones, cur)
					cur, cursz = nil, nil
				end
			end

		for i, sz in pairs (self.SafeZones) do
			local btn = self:QuickButton(sz.opts.name or "?", function(me)
				if (cur == i) then
					return end

				cur = i
				cursz = table.Copy(sz)
				shape = self.ShapesIndex[sz.shape]

				reset()

				for _, o in pairs (self.SafeZones) do
					o.btn:SetColor(styl.text)
				end

				me:SetColor(styl.header)

				edit:BuildList(cursz)
				btns:SetVisible(true)
				_SZ_EDITOR_SIZE:SetVisible(true)
				_SZ_EDITOR_SIZE:Set(sz.size, true)

				for _, point in pairs (sz.points) do
					local ts = point:ToScreen()

					local pnt = self:MakePoint(_SZ_EDITOR_CANVAS, point, ts.x, ts.y)
					table.insert(points, pnt)
				end
			end, scroll)
			btn:Dock(TOP)
			btn:DockMargin(0, 0, 0, m2)
			btn.m_Background = styl.bg
			sz.btn = btn
		end

	return tab_edit
end

local UpdateEditor = false
function SH_SZ:ShowEditor()
	if (IsValid(_SZ_EDITOR)) then _SZ_EDITOR:Close() end
	if (IsValid(_SZ_EDITOR_SIZE)) then _SZ_EDITOR_SIZE:Close() end

	if !(CAMI.PlayerHasAccess(LocalPlayer(), "Safezone - edit", nil)) then return end

	UpdateEditor = false

	ss = self:GetScreenScale()
	styl = self.Style
	th, m = self:GetPadding(), self:GetMargin()
	m2 = m * 0.5

	shape = SH_SZ.Shapes.cube
	points = {}
	sz_size = SH_SZ.MaximumSize
	sz_options = table.Copy(self.DefaultOptions)
	curstep = 1
	curcat = 1
	last_mx, last_my = gui.MousePos()
	moving_cam = false

	local tab_add, tab_edit

	local cont = vgui.Create("DPanel")
	cont:SetDrawBackground(false)
	cont:Dock(FILL)
	cont.OnMousePressed = function(me, mc)
		if (mc == MOUSE_RIGHT) then
			moving_cam = true
			last_mx, last_my = gui.MousePos()
		end
	end
	cont.OnMouseReleased = function(me, mc)
		if (mc == MOUSE_RIGHT) then
			moving_cam = false
		end

		if (step().type ~= "place" or !tab_add:IsVisible()) then
			return end

		if (mc == MOUSE_LEFT) then
			local mx, my = gui.MousePos()

			local sp = LocalPlayer():GetShootPos()
			local t = {
				start = sp,
				endpos = sp + gui.ScreenToVector(mx, my) * 16384,
				filter = ents.GetAll(),
			}
			local tr = util.TraceLine(t)

			local pnt = self:MakePoint(me, tr.HitPos, mx, my)
			table.insert(points, pnt)

			advance_step()
		end
	end
	cont.OnCursorMoved = function(me)
		local pnt = me.m_DraggingPoint
		if (IsValid(pnt)) then
			pnt:DoMove()
		end

		if (moving_cam) then
			local x, y = gui.MousePos()
			local dx, dy = x - last_mx, y - last_my
			if (dx ~= 0 or dy ~= 0) then
				local ang = LocalPlayer():EyeAngles()
				LocalPlayer():SetEyeAngles(ang - Angle(-dy * 0.25, dx * 0.25, 0))
				last_mx, last_my = x, y
			end
		end
	end
	cont.PaintOver = function(me, w, h)
		if (!tab_add:IsVisible()) then
			return end

		local mx, my = gui.MousePos()
		local wi, he = w * 0.25, 24 * ss
		local x, y = w * 0.5 - wi * 0.5, h * 0.7 - he * 0.5

		local mult = 1
		if (mx >= x and mx <= x + wi and my >= y and my <= y + he) then
			mult = 0.5
		end

		surface.SetAlphaMultiplier(mult)
			draw.RoundedBoxEx(4, x, y, wi * 0.1, he, styl.header, true, false, true, false)
			draw.RoundedBoxEx(4, x + wi * 0.1, y, wi * 0.9, he, styl.inbg, false, true, false, true)

			draw.SimpleText(curstep .. "/" .. #shape.steps, "SH_SZ.Large", x + wi * 0.05, y + he * 0.5, styl.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(self:GetStepText(step(), curstep), "SH_SZ.Large", x + wi * 0.1 + he * 0.25, y + he * 0.5, styl.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		surface.SetAlphaMultiplier(1)
	end
	_SZ_EDITOR_CANVAS = cont

	local frame = self:MakeWindow("Safe Zone Editor")
	frame:SetSize(self.WindowSize.w * ss, self.WindowSize.h * ss)
	frame:SetPos(th, th)
	frame:MakePopup()
	frame.OnClose = function()
		cont:Remove()
		_SZ_EDITOR_SIZE:Close()
		_SZ_EDITOR_OPEN = false

		if (!UpdateEditor) then
			net.Start("SH_SZ.Closed")
			net.SendToServer()
		end
	end
	frame.Think = function(this)
		if ((this.nextThink or 0) > CurTime()) then return end

		if (UpdateEditor) then
			_SZ_EDITOR:Close()
			UpdateEditor = false
			self:ShowEditor()
		end

		this.nextThink = CurTime() + 0.2
	end
	_SZ_EDITOR = frame
	_SZ_EDITOR_OPEN = true

		local cats = vgui.Create("DScrollPanel", frame)
		cats:SetWide(100 * ss)
		cats:Dock(LEFT)
		cats.Paint = function(me, w, h)
			surface.SetDrawColor(styl.inbg)
			surface.DrawRect(0, 0, w, h)
		end
		self:PaintScroll(cats)

			local cat_add = self:QuickButton(L"add", function() end, cats)
			cat_add:SetContentAlignment(4)
			cat_add:SetTextInset(m + 4, 0)
			cat_add:SetTall(40 * ss)
			cat_add:Dock(TOP)
			cat_add.m_iCatID = 1
			cat_add.PaintOver = function(me, w, h)
				if (curcat == me.m_iCatID) then
					surface.SetDrawColor(styl.header)
					surface.DrawRect(0, 0, 4, h)
				end
			end
			cat_add.DoClick = function()
				reset()
				curcat = 1

				tab_add:SetVisible(true)
				tab_edit:SetVisible(false)
			end

			local cat_list = self:QuickButton(L"edit", function() end, cats)
			cat_list:SetContentAlignment(4)
			cat_list:SetTextInset(m + 4, 0)
			cat_list:SetTall(40 * ss)
			cat_list:Dock(TOP)
			cat_list.m_iCatID = 2
			cat_list.PaintOver = cat_add.PaintOver
			cat_list.DoClick = function()
				reset()
				curcat = 2

				tab_add:SetVisible(false)
				tab_edit:SetVisible(true)

				cur, cursz = nil, nil
				tab_edit.m_Edit:Clear()
				tab_edit.m_Edit:SetVisible(false)
				tab_edit.m_Buttons:SetVisible(false)
			end

		local body = vgui.Create("DPanel", frame)
		body:SetDrawBackground(false)
		body:Dock(FILL)
		body:DockPadding(m, m, m, m)

			tab_add = self:MakeTabAdd(body)
			tab_edit = self:MakeTabEdit(body)

	local frame = self:MakeWindow(L"size")
	frame:SetVisible(false)
	frame.m_Close:Remove()
	frame:SetSize(200 * ss, 300 * ss)
	frame:MoveBelow(_SZ_EDITOR, th)
	frame:AlignLeft(th)
	_SZ_EDITOR_SIZE = frame

		local re_size = vgui.Create("DPanel", frame)
		re_size:SetDrawBackground(false)
		re_size:Dock(FILL)
		re_size:InvalidateParent(true)

			local size_adj = self:QuickButton("▲ " .. self.MaximumSize, function() end, re_size)
			size_adj:SetWide(re_size:GetWide())
			size_adj.OnMousePressed = function(me)
				me.m_iOldY = gui.MouseY()
				me.m_bDragging = true
			end
			size_adj.OnMouseReleased = function(me)
				me.m_bDragging = false
			end
			size_adj.OnCursorExited = size_adj.OnMouseReleased
			size_adj.Set = function(me, f, p)
				me:SetText("▲ " .. f)
				sz_size = f

				if (p) then
					me.y = (re_size:GetTall() - me:GetTall()) * (1 - f / self.MaximumSize)
				end
			end
			size_adj.Think = function(me)
				if (me.m_bDragging) then
					local my = gui.MouseY()
					local oy = me.m_iOldY
					if (oy) then
						local dy = my - oy
						local new = math.Clamp(me.y + dy, 0, re_size:GetTall() - me:GetTall())
						me.y = new

						local frac = me.y / (re_size:GetTall() - me:GetTall())
						local height = math.Round((1 - frac) * self.MaximumSize)
						me:Set(height)
					end

					me.m_iOldY = my
				end
			end

		local fill = self:QuickButton(L"fill_vertically", function()
			local fi = 0
			for _, pnt in pairs (points) do
				local pos = pnt.m_v3DPos
				local t = {start = pos, endpos = pos + Vector(0, 0, 16384), filter = ents.GetAll()}
				local tr = util.TraceLine(t)

				local zdist = math.Round(math.abs(tr.HitPos.z - pos.z))
				if (fi == 0 or zdist < fi) then
					fi = zdist
				end
			end

			fi = math.min(fi, self.MaximumSize)

			if (fi > 0) then
				size_adj:Set(fi, true)
			end
		end, frame)
		fill:Dock(TOP)

		re_size.Paint = function(me, w, h)
			surface.SetAlphaMultiplier(0.5)
				surface.SetDrawColor(styl.header)
				surface.DrawRect(0, size_adj.y, w, h)
			surface.SetAlphaMultiplier(1)
		end
		frame.Set = function(me, ...)
			size_adj:Set(...)
		end
end

local undomodelblend = false

hook.Add("PreDrawViewModel", "SH_SZ.PreDrawViewModel", function()
	if (_SZ_EDITOR_OPEN) then
		undomodelblend = true
		render.SetBlend(0)
	end
end)

hook.Add("PreDrawPlayerHands", "SH_SZ.PreDrawPlayerHands", function()
	if (_SZ_EDITOR_OPEN) then
		undomodelblend = true
		render.SetBlend(0)
	end
end)

hook.Add("CreateMove", "SH_SZ.CreateMove", function(cmd)
	if (!_SZ_EDITOR_OPEN) then
		return end

	local layout = SH_SZ.CameraControls
	if (input.IsKeyDown(layout.forward)) then
		cmd:SetForwardMove(10000)
	elseif (input.IsKeyDown(layout.back)) then
		cmd:SetForwardMove(-10000)
	end

	if (input.IsKeyDown(layout.left)) then
		cmd:SetSideMove(-10000)
	elseif (input.IsKeyDown(layout.right)) then
		cmd:SetSideMove(10000)
	end
end)

hook.Add("HUDPaint", "SH_SZ.HUDPaintCamera", function(cmd)
	if (!_SZ_EDITOR_OPEN) then
		return end

	local x, y = _SZ_EDITOR:GetPos()
	y = y * 2 + _SZ_EDITOR:GetTall()

	if (IsValid(_SZ_EDITOR_SIZE)) then
		x = x * 2 + _SZ_EDITOR_SIZE:GetWide()
	end

	local layout = SH_SZ.CameraControls
	local keyz = input.GetKeyName(layout.forward) .. "/" .. input.GetKeyName(layout.left) .. "/" .. input.GetKeyName(layout.back) .. "/" .. input.GetKeyName(layout.right)

	draw.SimpleText(keyz:upper() .. ": " .. L"move_camera", "SH_SZ.Large", x, y, SH_SZ.Style.text)
	draw.SimpleText(L"rotate_camera", "SH_SZ.Large", x, y + draw.GetFontHeight("SH_SZ.Large"), SH_SZ.Style.text)
end)

hook.Add("PostDrawViewModel", "SH_SZ.PostDrawViewModel", function()
	if (undomodelblend) then
		undomodelblend = false
		render.SetBlend(1)
	end
end)

net.Receive("SH_SZ.Menu", function()
	local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		ErrorNoHalt("[SAFEZONE] Unable to decompress area data!\n")
		return
	end

	SH_SZ.SafeZones = util.JSONToTable(uncompressed)
	UpdateEditor = true

	if (net.ReadBool()) then
		SH_SZ:ShowEditor()
	end
end)