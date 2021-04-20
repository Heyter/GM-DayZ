PLUGIN.name = "Weapon Select"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "A replacement for the default weapon selection."

if (SERVER) then return end

if (CLIENT) then
	ix.hotbar = ix.hotbar or {
		activeSlot = 0,
		lastSwitch = 0,
		animDelay = 2,
		animLength = 1,
		weaponSlots = {},
		panel = nil
	}

	function PLUGIN:LoadFonts(font)
		surface.CreateFont("GmodZ_HB_SlotLabel", {
			font = font,
			size = 16,
			weight = 300
		})

		surface.CreateFont("GmodZ_HB_ActiveSlot", {
			font = font,
			size = ScreenScale(18),
			weight = 0
		})

		surface.CreateFont("GmodZ_HB_InactiveSlot", {
			font = font,
			size = ScreenScale(12),
			weight = 0
		})
	end

	function ix.hotbar.OnIndexChanged(weapon)
		if (IsValid(weapon)) then
			ix.hotbar.lastSwitch = CurTime() + ix.hotbar.animDelay

			if (!IsValid(ix.hotbar.panel)) then
				ix.hotbar.panel = vgui.Create("gmodz_hotbar")
			end

			ix.hotbar.panel:InvalidateLayout(true)
		end
	end

	function ix.hotbar.Hide()
		if (!IsValid(ix.hotbar.panel)) then return end

		ix.hotbar.panel:Remove()
		ix.hotbar.panel = nil
	end

	function ix.hotbar.ReformatWeaponSelect()
		if (IsValid(ix.hotbar.panel)) then return end

		local items = {}
		ix.hotbar.weaponSlots = {}
		ix.hotbar.weaponSlots[1] = 0 -- hands

		local weapons = LocalPlayer():GetWeapons()
		local model, name

		for k, v in pairs(LocalPlayer():GetItems() or {}) do
			if (v.isWeapon and v:GetData("equip")) then
				for k2, v2 in ipairs(weapons) do
					if (v.class == v2:GetClass() and !items[v.class]) then
						name = v2:GetPrintName():utf8upper()
						model = #v2:GetWeaponWorldModel() > 0 and v2:GetWeaponWorldModel() or v:GetWeaponViewModel()
						ix.hotbar.weaponSlots[#ix.hotbar.weaponSlots + 1] = {k2, v2, name, model}
						items[v.class] = true
					end
				end
			end
		end

		for k, v in ipairs(weapons) do
			if (items[v:GetClass()]) then goto SKIP end

			name = v:GetPrintName():utf8upper()
			model = #v:GetWeaponWorldModel() > 0 and v:GetWeaponWorldModel() or v:GetWeaponViewModel()

			if (v:GetClass() == "ix_hands") then
				ix.hotbar.weaponSlots[1] = {k, v, name, model}
			else
				ix.hotbar.weaponSlots[#ix.hotbar.weaponSlots + 1] = {k, v, name, model}
			end

			::SKIP::
		end
	end


	function PLUGIN:HUDShouldDraw(name)
		if (name == "CHudWeaponSelection") then
			return false
		end
	end

	function PLUGIN:PlayerBindPress(client, bind, pressed)
		bind = bind:lower()

		if (!pressed or !bind:find("invprev") and !bind:find("invnext")
		and !bind:find("slot") and !bind:find("attack")) then
			return
		end

		local currentWeapon = client:GetActiveWeapon()
		local bValid = IsValid(currentWeapon)
		local bTool

		if (client:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and client:KeyDown(IN_ATTACK))) then
			return
		end

		if (bValid and currentWeapon:GetClass() == "gmod_tool") then
			local tool = client:GetTool()
			bTool = tool and (tool.Scroll != nil)
		end

		if (!bind:find("attack")) then
			ix.hotbar.ReformatWeaponSelect()
		end

		if (bind:find("invprev") and !bTool) then
			local oldIndex = ix.hotbar.activeSlot
			ix.hotbar.activeSlot = math.min(ix.hotbar.activeSlot + 1, #ix.hotbar.weaponSlots)

			if (oldIndex != ix.hotbar.activeSlot and ix.hotbar.weaponSlots[ix.hotbar.activeSlot]) then
				ix.hotbar.OnIndexChanged(ix.hotbar.weaponSlots[ix.hotbar.activeSlot][2])
			end

			return true
		elseif (bind:find("invnext") and !bTool) then
			local oldIndex = ix.hotbar.activeSlot
			ix.hotbar.activeSlot = math.max(ix.hotbar.activeSlot - 1, 1)

			if (oldIndex != ix.hotbar.activeSlot and ix.hotbar.weaponSlots[ix.hotbar.activeSlot]) then
				ix.hotbar.OnIndexChanged(ix.hotbar.weaponSlots[ix.hotbar.activeSlot][2])
			end

			return true
		elseif (bind:find("slot")) then
			ix.hotbar.activeSlot = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, #ix.hotbar.weaponSlots)

			if (ix.hotbar.weaponSlots[ix.hotbar.activeSlot]) then
				ix.hotbar.OnIndexChanged(ix.hotbar.weaponSlots[ix.hotbar.activeSlot][2])
			end

			return true
		elseif (bind:find("attack") and IsValid(ix.hotbar.panel)) then
			local weapon = ix.hotbar.weaponSlots[ix.hotbar.activeSlot]

			if (weapon and IsValid(weapon[2])) then
				LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", weapon[2]) or "HL2Player.Use")

				input.SelectWeapon(weapon[2])
				ix.hotbar.Hide()
			end

			return true
		end
	end

	function PLUGIN:Think()
		if (!IsValid(LocalPlayer()) or !LocalPlayer():Alive()) then
			ix.hotbar.Hide()
		end
	end

	function PLUGIN:ScoreboardShow()
		ix.hotbar.Hide()
	end
end
