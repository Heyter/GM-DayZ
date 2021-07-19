PLUGIN.name = "ArcCW compatibility"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (!ArcCW) then return end

-- ProcessNPCSmoke very expensive on MP servers
PLUGIN.ProcessNPCSmoke = false

local pairs, ipairs, net = pairs, ipairs, net

ix.arccw_support = ix.arccw_support or {}
ix.arccw_support.free_atts = ix.arccw_support.free_atts or {}
ix.arccw_support.atts_slots = {}

function ix.arccw_support.FindAttachSlot(itemWeapon, attName)
	local slots = ix.arccw_support.atts_slots[itemWeapon.uniqueID]

	if (slots and slots[attName]) then
		local mods = itemWeapon:GetData("mods", {})

		for i in pairs(slots[attName]) do
			if (!mods[i]) then
				return i
			end
		end
	end
end

function PLUGIN:InitHooks()
	RunConsoleCommand("arccw_npc_atts", 0)

	if (CLIENT) then
		RunConsoleCommand("arccw_font", "Jura")
		RunConsoleCommand("arccw_hud_3dfun_decaytime", 0)
		RunConsoleCommand("arccw_hud_3dfun", 0)
		RunConsoleCommand("arccw_hud_3dfun_ammotype", 1)
		RunConsoleCommand("arccw_hud_3dfun_lite", 0)
		RunConsoleCommand("arccw_hud_3dfun_right", 2)
		RunConsoleCommand("arccw_hud_3dfun_up", 1)
		RunConsoleCommand("arccw_hud_3dfun_forward", 0)
		RunConsoleCommand("arccw_hud_size", 1)
		RunConsoleCommand("arccw_automaticreload", 1)
		RunConsoleCommand('arccw_attinv_hideunowned', 0)
		RunConsoleCommand('arccw_attinv_darkunowned', 0)
		RunConsoleCommand('arccw_attinv_onlyinspect', 0)
		RunConsoleCommand('arccw_attinv_simpleproscons', 0)
	end

	if (SERVER) then
		RunConsoleCommand('arccw_override_crosshair_off', 1)
		RunConsoleCommand("arccw_mult_defaultammo", 0)
		RunConsoleCommand("arccw_enable_dropping", 0)
		RunConsoleCommand("arccw_attinv_free", 0)
		RunConsoleCommand("arccw_attinv_loseondie", 0)
		RunConsoleCommand("arccw_malfunction", 2)
	end

	hook.Remove("PlayerSpawn", "ArcCW_SpawnAttInv")
	hook.Remove("PlayerCanPickupWeapon", "ArcCW_PlayerCanPickupWeapon")

	-- HUD
	if (CLIENT) then
		local hide = {
			["CHudHealth"] = true,
			["CHudBattery"] = true,
			["CHudAmmo"] = true,
			["CHudSecondaryAmmo"] = true,
		}

		hook.Add("HUDShouldDraw", "ArcCW_HideHUD", function(name)
			if !hide[name] then return end
			if !LocalPlayer():IsValid() then return end
			if !LocalPlayer():GetActiveWeapon().ArcCW then return end
			if ArcCW.HUDElementConVars[name] and ArcCW.HUDElementConVars[name] == false then return end

			return false
		end)

		ArcCW.PollingDefaultHUDElements = false
		ArcCW.HUDElementConVars = {
			["CHudAmmo"] = true,
			["CHudSecondaryAmmo"] = true,
		}

		function ArcCW:ShouldDrawHUDElement(ele)
			if (ArcCW.HUDElementConVars[ele]) then return true end
			return false
		end
	end

	function ArcCW:PlayerGetAtts(client, att)
		if (att == "") then
			return 999
		end

		local atttbl = ArcCW.AttachmentTable[att]

		if (IsValid(client) and att and atttbl) then
			if (atttbl.Free) then
				return 999
			end

			--if (!client:IsAdmin() and atttbl.AdminOnly) then
			--	return 0
			--end

			if (atttbl.InvAtt) then
				att = atttbl.InvAtt
			end

			if (client:GetCharacter():GetInventory():HasItem(att)) then
				return 1
			end
		end

		return 0
	end

	function ArcCW:PlayerGiveAtt(client, att)
		if (!IsValid(client)) then return end

		client.ArcCW_AttInv = client.ArcCW_AttInv or {}

		local atttbl = ArcCW.AttachmentTable[att]

		if (!atttbl) then
			ErrorNoHalt("[ArcCW:PlayerGiveAtt] Invalid attachment: " .. att)
			return
		end

		if (atttbl.InvAtt) then
			att = atttbl.InvAtt
		end

		if (client:GetCharacter():GetInventory():HasItem(att)) then
			client.ArcCW_AttInv[att] = 1
		else
			client.ArcCW_AttInv[att] = 0
		end
	end

	function ArcCW:PlayerTakeAtt(client, att)
		if (!IsValid(client)) then return end

		client.ArcCW_AttInv = client.ArcCW_AttInv or {}

		local atttbl = ArcCW.AttachmentTable[att]

		if (!atttbl) then
			ErrorNoHalt("[ArcCW:PlayerTakeAtt] Invalid attachment: " .. att)
			return
		end

		if (atttbl.InvAtt) then
			att = atttbl.InvAtt
		end

		if (client:GetCharacter():GetInventory():HasItem(att)) then
			client.ArcCW_AttInv[att] = 0
		else
			client.ArcCW_AttInv[att] = 1
		end
	end

	function ArcCW:PlayerSendAttInv(client)
		if (!IsValid(client)) then return end

		client.ArcCW_AttInv = {}

		local items = client:GetItems()

		if (items) then
			for _, v in pairs(items) do
				if (v.isAttachment and v.isArcCW) then
					client.ArcCW_AttInv[v.uniqueID] = 1
				end
			end
		end

		if (SERVER) then
			local atttbl

			net.Start("arccw_sendattinv")
				net.WriteUInt(table.Count(client.ArcCW_AttInv), 32)

				for att, count in pairs(client.ArcCW_AttInv) do
					atttbl = ArcCW.AttachmentTable[att]

					net.WriteUInt(atttbl.ID, ArcCW.GetBitNecessity())
					net.WriteUInt(count, 32)
				end
			net.Send(client)
		end
	end

	function ArcCW:PlayerCanAttach(client, wep, attname, slot, detach)
		-- The global variable takes priority over everything
		if !ArcCW.EnableCustomization then return false end

		-- Allow hooks to block or force allow attachment usage
		local ret = hook.Run("ArcCW_PlayerCanAttach", client, wep, attname, slot, detach)

		-- Followed by convar
		if ret == nil and GetConVar("arccw_enable_customization"):GetInt() < 0 then return false end

		return (ret == nil and true) or ret
	end

	if (!self.ProcessNPCSmoke) then
		ArcCW.NPCsCache = {}
		ArcCW.SmokeCache = {}

		hook.Remove("OnEntityCreated", "ArcCW_NPCSmokeCache")
		hook.Remove("EntityRemoved", "ArcCW_NPCSmokeCache")
		hook.Remove("Think", "ArcCW_NPCSmoke")
		ArcCW.ProcessNPCSmoke = nil
	end
end

PLUGIN:InitHooks()

function PLUGIN:InitPostEntity()
	self:InitHooks()

	do
		local item, class, oldItem
		local attachments = {}

		for _, SWEP in ipairs(weapons.GetList()) do
			class = SWEP.ClassName

			if (weapons.IsBasedOn(class, "arccw_base") and !class:find("base")) then
				item = ix.item.list[class]

				if (item and item.isArcCW and item.isWeapon) then
					item.class = class

					if (#item.description == 0) then
						item.description = SWEP.Trivia_Desc or ""
					end

					if (#item.model == 0) then
						item.model = SWEP.WorldModel or "models/weapons/w_pistol.mdl"
					end

					if (#item.name == 0) then
						item.name = SWEP.PrintName or SWEP.TrueName
					end

					ix.arccw_support.atts_slots[item.uniqueID] = ix.arccw_support.atts_slots[item.uniqueID] or {}

					item.attachments = {}

					-- pretty heavy.
					if (SWEP.Attachments) then
						local slots = {}

						for i, k in ipairs(SWEP.Attachments) do
							if (!k.PrintName or k.Hidden or k.Blacklisted or k.Integral) then goto SKIP end

							slots = {i}
							table.Add(slots, k.MergeSlots or {})

							for _, slot in ipairs(slots) do
								for _, attID in ipairs(ArcCW:GetAttsForSlot((SWEP.Attachments[slot] or {}).Slot, SWEP)) do
									if (!item.attachments[attID]) then
										item.attachments[attID] = slot
									else
										-- bruh
										ix.arccw_support.atts_slots[item.uniqueID][attID] = ix.arccw_support.atts_slots[item.uniqueID][attID] or {}
										ix.arccw_support.atts_slots[item.uniqueID][attID][slot] = ix.arccw_support.atts_slots[item.uniqueID][attID][slot] or {}
										ix.arccw_support.atts_slots[item.uniqueID][attID][slot] = true
									end
								end
							end
							
							::SKIP::
						end
					end

					if (SWEP.Primary.Ammo and #SWEP.Primary.Ammo > 0) then
						for _, itemAmmo in pairs(ix.item.list) do
							if ((itemAmmo.base == "base_ammo" or itemAmmo.base == "base_arccw_ammo") and itemAmmo.ammo == SWEP.Primary.Ammo) then
								item.ammo = itemAmmo.uniqueID
								-- ix.item.list[item.ammo].maxRounds = SWEP.Primary.ForceDefaultClip or SWEP.Primary.ClipSize
								break
							end
						end
					end

					SWEP.Primary.DefaultClip = 0
					SWEP.InitialDefaultClip = nil

					if (CLIENT) then
						function SWEP:GetPresets() return {} end
						function SWEP:LoadPreset() end
						function SWEP:SavePreset() end
						function SWEP:CreatePresetSave() end
						function SWEP:CreatePresetMenu() end
						function SWEP:ClosePresetMenu() end
					end
				end
			end
		end

		for attID, v in pairs(ArcCW.AttachmentTable) do
			if (v.Free) then
				ix.arccw_support.free_atts[attID] = 1
			else
				oldItem = ix.item.list[attID]

				item = oldItem or ix.item.Register(attID, "base_arccw_attachments", nil, nil, true)
				item.name = oldItem and item.name or v.PrintName or v.ShortName

				if (oldItem) then
					if (#item.description == 0) then
						item.description = v.Description
					end

					if (#item.model == 0) then
						item.model = v.Model or "models/Items/BoxMRounds.mdl"
					end
				else
					item.description = v.Description
					item.model = v.Model or "models/Items/BoxMRounds.mdl"
				end

				-- item.slot = oldItem and item.slot or v.Slot

				if (v.DroppedModel and v.DroppedModel != item.model) then
					function item:OnGetDropModel(entity)
						return v.DroppedModel
					end
				end
			end
		end
	end
end

function PLUGIN:InitializedPlugins()
	game.AddAmmoType({
		name = "762x39mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 2000,
		minsplash = 5,
		maxsplash = 10
	})
end

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	ix.arccw_support.cache_weapons = ix.arccw_support.cache_weapons or {}

	local oldWeapon
	function PLUGIN:PlayerWeaponChanged(client, weapon)
		if (!IsValid(weapon) or oldWeapon == weapon) then return end
		oldWeapon = weapon

		local weaponItem
		local items = client:GetItems()

		if (items) then
			for _, v in pairs(items) do
				if (v.class == weapon:GetClass() and v:GetData("equip")) then
					weaponItem = v

					break
				end
			end
		end

		if (weaponItem) then
			ix.arccw_support.cache_weapons[weapon] = weaponItem
			client.StopArcAttach = CurTime() + 1
		end
	end

	function PLUGIN:ArcCW_PlayerCanAttach(client, weapon, attID, slot, detach)
		if (ix.arccw_support.free_atts[attID]) then
			return
		end

		if (client.StopArcAttach or 0) > CurTime() then
			return false
		end

		local inventory = client:GetCharacter():GetInventory()

		if (!inventory) then
			return false
		end

		if (!detach) then
			if (!inventory:HasItem(attID)) then
				return false
			end
		else
			local weaponItem = ix.arccw_support.cache_weapons[weapon]

			if (weaponItem) then
				local mods = weaponItem:GetData("mods", {})

				if (table.IsEmpty(mods) or !mods[slot] or !inventory:FindEmptySlot(weaponItem.width, weaponItem.height, true)) then
					return false
				end
			end
		end
	end
end