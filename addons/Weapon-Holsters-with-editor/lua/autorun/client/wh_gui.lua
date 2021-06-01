--[[
   __  ___        __      __                                
  /  |/  /__ ____/ /__   / /  __ __                         
 / /|_/ / _ `/ _  / -_) / _ \/ // /                         
/_/  /_/\_,_/\_,_/\__/ /_.__/\_, /                          
   ___       __             /___/         ___           __  
  / _ \___  / /_ _____ ___ / /____ ____  / _ \__ ______/ /__
 / ___/ _ \/ / // / -_|_-</ __/ -_) __/ / // / // / __/  '_/
/_/   \___/_/\_, /\__/___/\__/\__/_/   /____/\_,_/\__/_/\_\ 
            /___/                                           
https://steamcommunity.com/profiles/76561198057599363
]]
local Menu = {
	Main = {},
	Editor = {}
}

local playerBones = {"ValveBiped.Bip01_Head1", "ValveBiped.Bip01_Pelvis", "ValveBiped.Bip01_Spine", "ValveBiped.Bip01_Spine1", "ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_Spine4", "ValveBiped.Anim_Attachment_RH", "ValveBiped.Bip01_R_Hand", "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_Foot", "ValveBiped.Bip01_R_Toe0", "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_R_Shoulder", "ValveBiped.Bip01_R_Elbow", "ValveBiped.Bip01_Neck1", "ValveBiped.Anim_Attachment_LH", "ValveBiped.Bip01_L_Hand", "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Clavicle", "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_L_Toe0", "ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Shoulder", "ValveBiped.Bip01_L_Elbow"}

local function KeyboardOn(pnl)
	if (IsValid(Menu.Main.Frame) and IsValid(pnl) and pnl:HasParent(Menu.Main.Frame)) then
		Menu.Main.Frame:SetKeyboardInputEnabled(true)
	end
end

hook.Add("OnTextEntryGetFocus", "lf_weapon_properties_editor_keyboard_on", KeyboardOn)

local function KeyboardOff(pnl)
	if (IsValid(Menu.Main.Frame) and IsValid(pnl) and pnl:HasParent(Menu.Main.Frame)) then
		Menu.Main.Frame:SetKeyboardInputEnabled(false)

		if pnl.OnValueChange then
			pnl:OnValueChange()
		end
	end
end

hook.Add("OnTextEntryLoseFocus", "lf_weapon_properties_editor_keyboard_off", KeyboardOff)
-- Blur Code by: https://facepunch.com/member.php?u=237675
local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

local function removeHolstWep(class)
	for pl, weps in pairs(WepHolster.HolsteredWeps) do
		for cls, wep in pairs(weps) do
			if class == "" or cls == class then
				wep:Remove()
				WepHolster.HolsteredWeps[pl][cls] = nil
			end
		end
	end
end

local function setEditing(class, bool)
	if class ~= "" then
		if WepHolster.wepInfo[class] then
			WepHolster.wepInfo[class].isEditing = bool
		end
	else
		for k, v in pairs(WepHolster.wepInfo) do
			WepHolster.wepInfo[k].isEditing = bool
		end
	end

	for pl, weps in pairs(WepHolster.HolsteredWeps) do
		for cls, wep in pairs(weps) do
			if cls == class or class == "" then
				if bool then
					wep:SetMaterial("models/wireframe")
					--print("wireframe화 gui")
					--print(WepHolster.wepInfo[cls].isEditing)
					--print("wireframe 해제 gui")
					--print(WepHolster.wepInfo[cls].isEditing)
				else
					wep:Remove()
					WepHolster.HolsteredWeps[pl][cls] = nil
					WepHolster.wepInfo[cls].isEditing = nil
				end
			end
		end
	end
end

function Menu.Editor:Init(class)
	local Frame = vgui.Create("DFrame", Menu.Main.Frame)
	local fw, fh = 600, 350
	local pw, ph = fw - 10, fh - 34
	Frame:SetPos(ScrW() - fw - 10, (ScrH() / 2) - (fh / 2))
	Frame:SetSize(fw, fh)
	Frame:SetTitle(class)
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:SetScreenLock(false)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()
	Frame:SetKeyboardInputEnabled(false)

	function Frame:Paint(w, h)
		DrawBlur(self, 2)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

		return true
	end

	function Frame.lblTitle:Paint(w, h)
		draw.SimpleTextOutlined(Frame.lblTitle:GetText(), "DermaDefaultBold", 1, 2, Color(255, 255, 255, 255), 0, 0, 1, Color(0, 0, 0, 255))

		return true
	end

	local pnl = Frame:Add("DPanel")
	pnl:Dock(FILL)
	pnl:DockPadding(10, 10, 10, 10)
	local prop = pnl:Add("DCategoryList")
	prop:Dock(FILL)

	local function AddLineText(list, text, val, class)
		local line = list:Add("DPanel")
		line:DockPadding(5, 2, 5, 2)
		line:SetDrawBackground(false)
		local id

		if val then
			local lbl = line:Add("DLabel")
			lbl:Dock(LEFT)
			lbl:SetWide(239)
			lbl:SetDark(true)
			lbl:SetText(text)
			id = line:Add("DTextEntry")
			id:Dock(FILL)
			id:SetText(val or "")
		else
			local lbl = line:Add("DLabel")
			lbl:Dock(FILL)
			lbl:SetText(text)
		end

		return line, id
	end

	local function AddLineInt(list, text, val, min, max)
		local line = list:Add("DPanel")
		line:DockPadding(5, 2, 5, 2)
		line:SetPaintBackground(false)
		local id

		if val then
			id = line:Add("DNumSlider")
			id:Dock(FILL)
			id:SetDark(true)
			id:SetDecimals(3)
			id:SetMinMax(min, max)
			id:SetText(text)
			id:SetValue(val or 0)
		else
			local lbl = line:Add("DLabel")
			lbl:Dock(FILL)
			lbl:SetText(text)
		end

		return line, id
	end

	local cat = prop:Add(class)
	local list = vgui.Create("DListLayout")
	cat:SetContents(list)
	local line, rModel = AddLineText(list, "Model:", WepHolster.wepInfo[class].Model, class)

	rModel.OnValueChange = function(val)
		val = rModel:GetValue()
		WepHolster.wepInfo[class].Model = val
		setEditing(class, true)
		removeHolstWep(class)
	end

	local line, rBone = AddLineText(list, "Bone:", WepHolster.wepInfo[class].Bone)
	WepHolster.lookingBone = WepHolster.wepInfo[class].Bone

	if rBone then
		rBone.OnValueChange = function(val)
			val = rBone:GetValue()

			if table.HasValue(playerBones, val) then
				WepHolster.wepInfo[class].Bone = val
				setEditing(class, true)
				WepHolster.lookingBone = val
			end
		end

		local c = line:Add("DComboBox")
		c:Dock(RIGHT)
		c:SetWide(40)
		c:SetSortItems(false)
		c:SetValue("...")

		for _, v in pairs(playerBones) do
			c:AddChoice(v)
		end

		function c:OnSelect(index, value)
			rBone:SetText(value)
			rBone:OnValueChange()
			c:SetValue("...")
		end
	end

	local line, rVectorX = AddLineInt(list, "Position x:", WepHolster.wepInfo[class].BoneOffset[1].x, -20, 20, class)

	rVectorX.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[1].x = rVectorX:GetValue()
		setEditing(class, true)
	end

	local line, rVectorY = AddLineInt(list, "Position y:", WepHolster.wepInfo[class].BoneOffset[1].y, -20, 20, class)

	rVectorY.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[1].y = rVectorY:GetValue()
		setEditing(class, true)
	end

	local line, rVectorZ = AddLineInt(list, "Position z:", WepHolster.wepInfo[class].BoneOffset[1].z, -20, 20, class)

	rVectorZ.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[1].z = rVectorZ:GetValue()
		setEditing(class, true)
	end

	local line, rAngleP = AddLineInt(list, "Angle pitch:", WepHolster.wepInfo[class].BoneOffset[2].p, -180, 180, class)

	rAngleP.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[2].p = rAngleP:GetValue()
		setEditing(class, true)
	end

	local line, rAngleY = AddLineInt(list, "Angle yaw:", WepHolster.wepInfo[class].BoneOffset[2].y, -180, 180, class)

	rAngleY.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[2].y = rAngleY:GetValue()
		setEditing(class, true)
	end

	local line, rAngleR = AddLineInt(list, "Angle roll:", WepHolster.wepInfo[class].BoneOffset[2].r, -180, 180, class)

	rAngleR.OnValueChanged = function(value)
		WepHolster.wepInfo[class].BoneOffset[2].r = rAngleR:GetValue()
		setEditing(class, true)
	end

	local subpnl = pnl:Add("DPanel")
	subpnl:Dock(BOTTOM)
	subpnl:DockMargin(0, 20, 0, 0)
	subpnl:SetHeight(20)
	subpnl:SetDrawBackground(false)
	local lw = (pw - 10) / 2 - 10
	local b = subpnl:Add("DComboBox")
	b:Dock(LEFT)
	b:SetWide(lw)
	b:SetValue("Reset")
	b:SetSortItems(false)
	b:AddChoice("to saved data if available")
	b:AddChoice("to default if available")

	b.OnSelect = function(index, value, data)
		Frame:Close()

		if value == 2 then
			local oldwhdata = WepHolster.wepInfo[class]
			net.Start("resetWHDataToDefault")
			net.WriteString(class)
			net.SendToServer()

			timer.Simple(0.1, function()
				local different

				for k, v in pairs(WepHolster.wepInfo[class]) do
					if (k == "Model" or k == "Bone") and string.lower(oldwhdata[k]) ~= string.lower(v) then
						different = true
						print(k .. ": " .. v)
						--	print(_..": "..vec_ang)
					elseif k == "BoneOffset" then
						for _, vec_ang in pairs(v) do
							if vec_ang ~= oldwhdata[k][_] then
								different = true
							end
						end
					end
				end

				-- '==' operator is not working on table.. fuck.
				if different then
					setEditing(class, true)
				end
			end)
		elseif not WepHolster.wepInfo[class].notSavedYet then
			net.Start("reloadWH")
			net.WriteString(class)
			net.SendToServer()
			setEditing(class, false)
		end

		timer.Simple(0.1, function()
			Menu.Editor:Init(class)
			removeHolstWep(class)
		end)
	end

	local b = subpnl:Add("DComboBox")
	b:Dock(RIGHT)
	b:SetWide(lw)
	b:SetValue("Delete")
	b:AddChoice("Are you sure?")

	b.OnSelect = function(index, value, data)
		net.Start("deleteWHData")
		net.WriteString(class)
		net.SendToServer()

		timer.Simple(0.1, function()
			Menu.Main.Frame:Close()
			Menu.Main:Init()
		end)
	end

	local b = pnl:Add("DButton")
	b:Dock(BOTTOM)
	b:DockMargin(0, 10, 0, 0)
	b:SetHeight(30)
	b:SetText("Apply Changes")

	b.DoClick = function()
		setEditing(class, false)
		WepHolster.wepInfo[class].notSavedYet = nil
		net.Start("applyWepHolsterData")
		net.WriteString(class)
		net.WriteTable(WepHolster.wepInfo[class])
		net.SendToServer()
		Frame:Close()
	end

	Frame.OnClose = function()
		--[[
		net.Start("reloadWH")
		net.WriteString(class)
		net.SendToServer()
		Menu.Main.Frame:Close()
		timer.Simple(0.1, function()
			removeHolstWep(class)
			Menu.Main:Init()
		end)
		]]
		WepHolster.lookingBone = nil
	end
end

local function addWeapon(class, model)
	WepHolster.wepInfo[class] = WepHolster.wepInfo[class] or {
		Model = model or "models/weapons/w_rif_ak47.mdl",
		Bone = "ValveBiped.Bip01_R_Clavicle",
		BoneOffset = {Vector(13, 4, 5), Angle(90, 0, 100)},
		notSavedYet = true
	}

	Menu.Main.Frame:Close()
	Menu.Main:Init()
	Menu.Editor:Init(class)
	setEditing(class, true)
end

function Menu.Main:Init()
	Menu.Main.Frame = vgui.Create("DFrame")
	local Frame = Menu.Main.Frame
	local fw, fh = 400, ScrH() - 20
	local pw, ph = fw - 10, fh - 34
	Frame:SetPos(10, 10)
	Frame:SetSize(fw, fh)
	Frame:SetTitle("Weapon Holsters Editor")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:SetScreenLock(false)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()
	Frame:SetKeyboardInputEnabled(false)

	function Frame:Paint(w, h)
		DrawBlur(self, 2)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

		return true
	end

	function Frame.lblTitle:Paint(w, h)
		draw.SimpleTextOutlined(Frame.lblTitle:GetText(), "DermaDefaultBold", 1, 2, Color(255, 255, 255, 255), 0, 0, 1, Color(0, 0, 0, 255))

		return true
	end

	local pnl = Frame:Add("DPanel")
	pnl:Dock(FILL)
	pnl:DockPadding(10, 10, 10, 10)
	local b = pnl:Add("DButton")
	b:Dock(TOP)
	b:DockMargin(0, 0, 0, 1)
	b:SetHeight(25)
	b:SetText("Add weapon by class:")

	b.DoClick = function()
		local name = tostring(Menu.Main.WeaponEntry:GetValue())

		if name == "" then
			return
		end

		addWeapon(name)
	end

	Menu.Main.WeaponEntry = pnl:Add("DTextEntry")
	Menu.Main.WeaponEntry:Dock(TOP)
	Menu.Main.WeaponEntry:DockMargin(0, 0, 0, 10)
	Menu.Main.WeaponEntry:SetHeight(20)
	Menu.Main.WeaponEntry:SetTooltip("Just right-click on the weapon icon in the spawn menu, click Copy to Clipboard, and paste it here.")
	--[[
	local help = pnl:Add("DLabel") -- Fuck you, I'll use SetTooltip instead.
	help:Dock(TOP)
	help:DockMargin(0, 0, 0, 10)
	help:SetHeight(26)
	help:SetText("Just right-click on the weapon icon in the spawn menu,\nclick Copy to Clipboard, and paste it here.")
	]]
	b = pnl:Add("DButton")
	b:Dock(TOP)
	b:DockMargin(0, 0, 0, 10)
	b:SetHeight(24)
	b:SetText("Add weapon you currently holding")

	b.DoClick = function()
		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) then
			addWeapon(weapon:GetClass(), weapon:GetWeaponWorldModel())
		end
	end

	--[[
	local help = pnl:Add("DLabel")
	help:Dock(TOP)
	help:DockMargin(0, 0, 0, 5)
	help:SetHeight(13)
	help:SetText("Click the bar to sort the list, and double click the weapon to edit:")
]]
	Menu.Main.WeaponList = pnl:Add("DListView")
	Menu.Main.WeaponList:Dock(FILL)
	Menu.Main.WeaponList:SetMultiSelect(false)
	Menu.Main.WeaponList:AddColumn("Category")
	Menu.Main.WeaponList:AddColumn("Name")
	Menu.Main.WeaponList:AddColumn("Class")
	Menu.Main.WeaponList:SetTooltip("Click the bar to sort the list, and double click the weapon to edit.")

	function Menu.Main.WeaponList:DoDoubleClick(id, sel)
		local wepclass = tostring(sel:GetValue(3))

		if WepHolster.wepInfo[wepclass] then
			Menu.Editor:Init(wepclass)
		end
	end

	function Menu.Main.WeaponList:Populate()
		self:Clear()

		for k, v in pairs(WepHolster.wepInfo) do
			local swep = weapons.Get(k)
			self:AddLine(swep and swep.Category or "Other", swep and swep.PrintName or WepHolster.HL2Weps[k] or k, k)
		end

		self:SortByColumn(1)
	end

	Menu.Main.WeaponList:Populate()
	local credit = pnl:Add("DLabel")
	credit:Dock(BOTTOM)
	credit:DockMargin(0, 10, 0, 0)
	credit:SetHeight(13)
	credit:SetText("Made by Polyester Duck")
	local b = pnl:Add("DComboBox")
	b:Dock(BOTTOM)
	b:DockMargin(0, 10, 0, 0)
	b:SetHeight(20)
	b:SetValue("RESET EVERYTHING TO DEFAULT")
	b:AddChoice("ARE YOU REALLY SURE?")

	b.OnSelect = function(index, value, data)
		setEditing("", false)
		net.Start("resetWholeWHDataToDefault")
		net.SendToServer()
		Frame:Close()
		timer.Simple(0.1, Menu.Main.Init)
	end

	Frame.OnClose = function()
		--[[
		net.Start("reloadWholeWH")
		net.SendToServer()
		for pl, weps in pairs(WepHolster.HolsteredWeps) do
			for cls, wep in pairs(weps) do
				wep:Remove()
				WepHolster.HolsteredWeps[pl][cls] = nil
			end
		end
		]]
		WepHolster.lookingBone = nil
	end
end

function Menu.Toggle()
	if LocalPlayer():IsSuperAdmin() then
		if IsValid(Menu.Main.Frame) then
			Menu.Main.Frame:Close()
		else
			Menu.Main:Init()
		end
	else
		if IsValid(Menu.Main.Frame) then
			Menu.Main.Frame:Close()
		end
	end
end

concommand.Add("weapon_holsters_editor", Menu.Toggle)

local function clientTrickBox(panel, con_name, func_onchange)
	local con = GetConVar(con_name)

	if not con then
		return
	end

	local tickbox = vgui.Create("DCheckBoxLabel", panel)
	tickbox:SetText(con:GetHelpText() or "Unknown setting.")
	tickbox:SetValue(con:GetBool())
	tickbox.con_name = con_name
	tickbox:SetDark(true)

	function tickbox:OnChange(b)
		RunConsoleCommand(self.con_name, b and "1" or "0")

		if func_onchange then
			func_onchange()
		end
	end

	function tickbox:Think()
		if not self.con_name then
			return
		end

		local ucon = GetConVar(self.con_name)

		if (ucon:GetBool() or true) ~= self:GetValue() then
			self:SetChecked(ucon:GetBool())
		end
	end

	panel:AddItem(tickbox)
end

local function requestSetting(con, arg)
	if type(arg) == "boolean" then
		arg = arg and "1" or "0"
	end

	net.Start("WepHolsters_Settings")
	net.WriteString(con)
	net.WriteString(arg)
	net.SendToServer()
end

local function adminTrickBox(panel, con_name)
	local con = GetConVar(con_name)

	if not con then
		return
	end

	local tickbox = vgui.Create("DCheckBoxLabel", panel)
	tickbox:SetText(con:GetHelpText() or "Unknown setting.")
	tickbox:SetValue(con:GetBool())
	tickbox.con_name = con_name
	tickbox:SetDark(true)

	function tickbox:OnChange(b)
		requestSetting(self.con_name, b and "1" or "0")
	end

	function tickbox:Think()
		if not self.con_name then
			return
		end

		local ucon = GetConVar(self.con_name)

		if (ucon:GetBool() or true) ~= self:GetValue() then
			self:SetChecked(ucon:GetBool())
		end
	end

	panel:AddItem(tickbox)
end

-- Spawn Menu entry.
local function SpawnMenu_Entry(panel)
	panel:AddControl("Label", {
		Text = "Client Settings:"
	})

	clientTrickBox(panel, "cl_weapon_holsters", function()
		removeHolstWep("")
	end)

	panel:AddControl("Label", {
		Text = "Administrator Settings:"
	})

	adminTrickBox(panel, "sv_weapon_holsters")

	local a = panel:AddControl("Button", {
		Label = "Open Editor",
		Command = "weapon_holsters_editor"
	})

	a:SetSize(0, 50)
	a:SetEnabled(LocalPlayer():IsSuperAdmin())
end

hook.Add("PopulateToolMenu", "weapon_holsters_editor_spawnmenu", function()
	spawnmenu.AddToolMenuOption("Options", "Player", "weapon_holsters_editor_spawnmenu_entry", "Weapon Holsters", "", "", SpawnMenu_Entry, {})
end)

hook.Add("HUDPaint", "whBoneIndicator", function()
	if WepHolster.lookingBone then
		for k, ply in pairs(player.GetAll()) do
			lp = LocalPlayer()
			local bone = ply:LookupBone(WepHolster.lookingBone)
			local matrix = ply:GetBoneMatrix(bone)

			if not matrix then
				return
			end

			local pos = matrix:GetTranslation()
			pos = pos:ToScreen()
			local wihe = 6
			draw.RoundedBox(2, pos.x - wihe / 2, pos.y - wihe / 2, wihe, wihe, Color(0, 0, 0, 200))
			wihe = wihe - 2
			draw.RoundedBox(2, pos.x - wihe / 2, pos.y - wihe / 2, wihe, wihe, Color(255, 255, 255, 255))
		end
	end
end)