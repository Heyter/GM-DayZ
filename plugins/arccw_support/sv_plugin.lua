local timer, IsValid = timer, IsValid

function ix.arccw_support.Attach(itemWeapon, attID)
	if (!itemWeapon or !attID or !itemWeapon.isWeapon or !itemWeapon.attachments) then
		return false
	end

	if (table.IsEmpty(itemWeapon.attachments)) then
		return false
	end

	local client = itemWeapon.player or itemWeapon:GetOwner()

	if (IsValid(client) and (client.StopArcAttach or 0) < CurTime()) then
		local slot = itemWeapon.attachments[attID]
		if (!slot) then return false end

		local mods = itemWeapon:GetData("mods", {})

		if (mods[slot]) then
			slot = ix.arccw_support.FindAttachSlot(itemWeapon, attID)

			if (!slot) then return false end
		end

		if (mods[slot]) then
			client:NotifyLocalized("arccw_alreadyAttached")
			return false
		end

		local weapon = client.carryWeapons and client.carryWeapons[itemWeapon.weaponCategory]

		if (!IsValid(weapon)) then
			weapon = client:GetWeapon(itemWeapon.class)
		end

		if (IsValid(weapon) and weapon.ixItem and weapon.ixItem == itemWeapon) then
			weapon:Attach(slot, attID)
			client:EmitSound("weapons/crossbow/reload1.wav")

			return false
		else
			mods[slot] = attID
			itemWeapon:SetData("mods", mods, true)
			mods = nil

			client:EmitSound("weapons/crossbow/reload1.wav")
		end

		return true
	end

	return false
end

function ix.arccw_support.Detach(itemWeapon, attID)
	if (!itemWeapon or itemWeapon.invID == 0 or !attID or !itemWeapon.isWeapon or !itemWeapon.attachments) then
		return false
	end

	if (table.IsEmpty(itemWeapon.attachments)) then
		return false
	end

	local inventory = ix.item.inventories[itemWeapon.invID]
	if (!inventory) then return end

	local client = itemWeapon.player or itemWeapon:GetOwner()

	if (IsValid(client) and (client.StopArcAttach or 0) < CurTime()) then
		local slot = itemWeapon.attachments[attID]
		local mods = itemWeapon:GetData("mods", {})

		if (!slot or table.IsEmpty(mods)) then
			return false
		end

		if (!mods[slot]) then
			for slot2, attID2 in pairs(mods) do
				if (slot2 == slot) then goto SKIP end

				if (attID == attID2) then
					slot = slot2
					break
				end

				::SKIP::
			end
		end

		if (!mods[slot]) then
			return false
		end

		local weapon = client.carryWeapons and client.carryWeapons[itemWeapon.weaponCategory]

		if (!IsValid(weapon)) then
			weapon = client:GetWeapon(itemWeapon.class)
		end

		if (IsValid(weapon) and weapon.ixItem and weapon.ixItem == itemWeapon) then
			local attItem = ix.item.list[attID]

			if (!attItem or !inventory:FindEmptySlot(attItem.width, attItem.height, true)) then
				client:NotifyLocalized("noFit")
				return false
			end

			weapon:Detach(slot)
			client:EmitSound("weapons/crossbow/reload1.wav")

			return true
		else
			if (!inventory:Add(attID)) then
				client:NotifyLocalized("noFit")
				return false
			end

			mods[slot] = nil

			if (table.IsEmpty(mods)) then
				itemWeapon:SetData("mods", nil, true)
			else
				itemWeapon:SetData("mods", mods, true)
			end

			mods = nil

			client:EmitSound("weapons/crossbow/reload1.wav")
		end

		return true
	end
	
	return false
end

function ix.arccw_support.InitWeapon(client, weapon)
	if (IsValid(weapon) and IsValid(client)) then
		for _, i in pairs(weapon.Attachments) do
			if (!i.Integral) then
				i.Installed = nil
			end
		end

		local weaponItem = weapon.ixItem
		local items = client:GetItems()

		if (items and !weaponItem) then
			for _, v in pairs(items) do
				if (v.class == weapon:GetClass() and v:GetData("equip")) then
					weaponItem = v

					break
				end
			end
		end

		if (weaponItem) then
			local mods = weaponItem:GetData("mods", {})

			if (!table.IsEmpty(mods)) then
				for slot, attID in pairs(mods) do
					weapon.Attachments[slot].Installed = attID
				end
			end
		end

		client.StopArcAttach = CurTime() + 1
		weapon:NetworkWeapon(client)
	end
end

function ix.arccw_support.StackAmmo(itemSelf, combineItem)
	local maxRounds = itemSelf.maxRounds
	local rounds = itemSelf:GetData("rounds", itemSelf.ammoAmount)
	local combineRounds = combineItem:GetData("rounds", combineItem.ammoAmount)

	if (combineRounds >= maxRounds or rounds >= maxRounds) then return end
	local totalRounds = combineRounds + rounds

	if (totalRounds > maxRounds) then
		itemSelf:SetData("rounds", maxRounds, true)
		combineItem:SetData("rounds", totalRounds - maxRounds, true)
	else
		combineItem:Remove()
		itemSelf:SetData("rounds", rounds + combineRounds, true)
	end

	rounds, combineRounds, totalRounds, maxRounds = nil, nil, nil, nil
end

-- item = itemWeapon
function ix.arccw_support.EmptyClip(item)
	if (!item.ammoID or item.invID == 0) then return end
	local inventory = ix.item.inventories[item.invID]
	if (!inventory) then return end

	local client = item.player
	local weapon = client.carryWeapons and client.carryWeapons[item.weaponCategory]
	local ammo = 0

	if (!IsValid(weapon)) then
		weapon = client:GetWeapon(item.class)
	end

	if (IsValid(weapon)) then
		ammo = weapon:Clip1()

		if (ammo > 0) then
			if (!inventory:Add(item.ammoID, 1, { rounds = ammo })) then
				client:NotifyLocalized("noFit")
				return
			end

			weapon:SetClip1(0)
			client:UpdateInventoryAmmo(item.ammoID)
		end

		return
	end

	ammo = item:GetData("ammo", 0)

	if (ammo > 0) then
		if (!inventory:Add(item.ammoID, 1, { rounds = ammo })) then
			client:NotifyLocalized("noFit")
			return
		end

		item:SetData("ammo", nil, true)
		client:EmitSound("weapons/clipempty_rifle.wav")
	end
end

util.AddNetworkString("ixArcCWAmmoSplit")

net.Receive("ixArcCWAmmoSplit", function(_, client)
	if ((client.ixAmmoSplitTry or 0) < CurTime()) then
		client.ixAmmoSplitTry = CurTime() + 0.33
	else
		return
	end

	if (!client:GetCharacter() or !client:Alive()) then return end

	local item = ix.item.instances[net.ReadUInt(32)]
	if (!item or item.invID == 0 or (item.base or "") != "base_arccw_ammo") then return end

	local inventory = ix.item.inventories[item.invID]
	if (!inventory) then return end

	local rounds = item:GetData("rounds", item.ammoAmount)
	if (rounds <= 1) then return end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, rounds)
	if (amount == 0 or amount == rounds) then return end

	if (inventory:Add(item.uniqueID, 1, {rounds = amount}, nil, nil, nil, true)) then
		amount = rounds - amount

		if (amount <= 0) then
			item:Remove()
		else
			item:SetData("rounds", amount, true)
		end
	else
		client:NotifyLocalized("noFit")
	end
end)

-- HOOKS --
function PLUGIN:ArcCW_PlayerCanAttach(client, weapon, attID, slot, detach)
	if (ix.arccw_support.free_atts[attID] or !weapon.isIxItem or (client.StopArcAttach or 0) > CurTime()) then
		return
	end

	local weaponItem = weapon.ixItem

	if (weaponItem) then
		if (!detach) then
			local attItem = client:GetCharacter():GetInventory():HasItem(attID)

			if (!attItem) then
				return false
			end

			local mods = weaponItem:GetData("mods", {})

			mods[slot] = attID
			weaponItem:SetData("mods", mods)
			mods = nil

			timer.Simple(.0, function()
				attItem:Remove()
			end)
		else
			local mods = weaponItem:GetData("mods", {})

			if (table.IsEmpty(mods)) then
				return false
			end

			if (mods[slot]) then
				if (!client:GetCharacter():GetInventory():Add(attID)) then
					client:NotifyLocalized("noFit")
					return false
				end

				mods[slot] = nil

				if (table.IsEmpty(mods)) then
					weaponItem:SetData("mods", nil)
				else
					weaponItem:SetData("mods", mods)
				end

				mods = nil
			end
		end
	end
end

function PLUGIN:PlayerCanPickupWeapon(client, weapon)
	if (weapon.ArcCW and !weapon.Singleton and weapon.isIxItem) then
		-- if (!ArcCW.EnableCustomization or GetConVar("arccw_enable_customization"):GetInt() < 0 or GetConVar("arccw_attinv_free"):GetBool()) then
			-- return
		-- end

		weapon:SetNWBool("ArcCW_DisableAutosave", true)

		timer.Simple(.2, function()
			ix.arccw_support.InitWeapon(client, weapon)
		end)
	end
end