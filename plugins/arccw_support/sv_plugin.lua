local timer, IsValid = timer, IsValid

util.AddNetworkString("ixArcCWAmmoSplit")
util.AddNetworkString("ixRequestDropAmmo")

function ix.arccw_support.Attach(itemWeapon, attID)
	if (!itemWeapon or !attID or !itemWeapon.isWeapon or !itemWeapon.attachments) then
		return false
	end

	if (table.IsEmpty(itemWeapon.attachments)) then
		return false
	end

	local client = itemWeapon.player or itemWeapon:GetOwner()

	if (IsValid(client) and client:GetCharacter()) then
		local slot = itemWeapon.attachments[attID]
		if (!slot) then return false end

		local mods = itemWeapon:GetData("mods", {})

		if (mods[slot]) then
			slot = ix.arccw_support.FindAttachSlot(itemWeapon, attID)

			if (!slot) then return false end
		end

		if (mods[slot]) then
			client:Notify("This type of item is already mounted on the weapon!")
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
			itemWeapon:SetData("mods", mods)
			mods = nil

			client:EmitSound("weapons/crossbow/reload1.wav")
		end

		return true
	end

	return false
end

function ix.arccw_support.Detach(itemWeapon, attID)
	if (!itemWeapon or !attID or !itemWeapon.isWeapon or !itemWeapon.attachments) then
		return false
	end

	if (table.IsEmpty(itemWeapon.attachments)) then
		return false
	end

	local client = itemWeapon.player or itemWeapon:GetOwner()

	if (IsValid(client) and client:GetCharacter()) then
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
			weapon:Detach(slot)
			client:EmitSound("weapons/crossbow/reload1.wav")

			return true
		else
			if (!client:GetCharacter():GetInventory():Add(attID)) then
				client:NotifyLocalized("noFit")
				return false
			end

			mods[slot] = nil

			if (table.IsEmpty(mods)) then
				itemWeapon:SetData("mods", nil)
			else
				itemWeapon:SetData("mods", mods)
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
			i.Installed = nil
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

	if (itemSelf.isStackable and combineRounds == rounds and rounds >= maxRounds) then
		itemSelf:CombineStack(combineItem)
		return
	end

	if (combineRounds >= maxRounds or rounds >= maxRounds) then return end
	local totalRounds = combineRounds + rounds

	if (totalRounds > maxRounds) then
		itemSelf:SetData("rounds", maxRounds)
		combineItem:SetData("rounds", totalRounds - maxRounds)
	else
		combineItem:Remove()
		itemSelf:SetData("rounds", rounds + combineRounds)
	end

	rounds, combineRounds, totalRounds, maxRounds = nil, nil, nil, nil
end

function ix.arccw_support.EmptyClip(itemSelf)
	local ammoID = itemSelf.ammo
	if (!ammoID) then return end

	local client = itemSelf.player
	local weapon = client.carryWeapons and client.carryWeapons[itemSelf.weaponCategory]
	local ammo = 0

	if (!IsValid(weapon)) then
		weapon = client:GetWeapon(itemSelf.class)
	end

	if (IsValid(weapon) and weapon:Clip1() > 0) then
		ammo = weapon:Clip1()

		if (ammo > 0) then
			weapon:SetClip1(0)
			client:SetAmmo(weapon:Ammo1() + ammo, weapon.Primary.Ammo)

			-- itemSelf.data = itemSelf.data or {}
			-- itemSelf.data.ammo = nil

			return
		end
	else
		ammo = itemSelf:GetData("ammo", 0)

		if (ammo > 0) then
			itemSelf:SetData("ammo", nil)
		end
	end

	if (ammo > 0) then
		local data = { rounds = ammo }

		if (!client:GetCharacter():GetInventory():Add(ammoID, 1, data)) then
			ix.item.Spawn(ammoID, client, nil, nil, data)
		end

		client:EmitSound("weapons/clipempty_rifle.wav")
	end
end

net.Receive("ixRequestDropAmmo", function(_, client)
	if ((client.ixAmmoSplitTry or 0) < CurTime()) then
		client.ixAmmoSplitTry = CurTime() + 0.33
	else
		return
	end

	if (!client:GetCharacter() or !client:Alive()) then return end

	local ammoName = net.ReadString()
	if (!isstring(ammoName)) then return end

	local item = ix.item.list[ammoName]
	if (!item or (item.base or "") != "base_arccw_ammo") then return end

	local ammo = client:GetAmmoCount(ammoName)
	if (!ammo or ammo <= 0) then return end

	local maxRounds = item.maxRounds

	if (!net.ReadBool()) then
		local totalAmmo = ammo > maxRounds and maxRounds - ammo or ammo

		if (totalAmmo < 1) then
			totalAmmo = maxRounds
		end

		if (client:GetCharacter():GetInventory():Add(ammoName, 1, { rounds = totalAmmo })) then
			ammo = ammo - maxRounds
			client:SetAmmo(math.max(ammo, 0), ammoName)
		end

		totalAmmo = nil
	else
		local totalAmmo = math.floor(ammo / maxRounds) -- число полных обойм
		local result = totalAmmo * maxRounds -- сколько поместилось
		local data = {}

		if (result < 1) then
			result = ammo - result -- остаток
			data["rounds"] = result
		elseif (result > 0 and totalAmmo >= 2) then
			data["quantity"] = totalAmmo
			data["rounds"] = maxRounds
		end

		if (client:GetCharacter():GetInventory():Add(ammoName, 1, data)) then
			ammo = ammo - result
			client:SetAmmo(math.max(ammo, 0), ammoName)
		end

		totalAmmo, result, data = nil, nil, nil
	end

	ammo = nil
end)

net.Receive("ixArcCWAmmoSplit", function(_, client)
	if ((client.ixAmmoSplitTry or 0) < CurTime()) then
		client.ixAmmoSplitTry = CurTime() + 0.33
	else
		return
	end

	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	local item = ix.item.instances[net.ReadUInt(32)]
	if (!item or (item.base or "") != "base_arccw_ammo") then return end

	local rounds = item:GetData("rounds", item.ammoAmount)
	if (rounds <= 1) then return end

	local quantity = item:GetData("quantity", 1)
	local amount = net.ReadUInt(32)

	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, quantity >= 2 and quantity or rounds)
	if (amount == 0) then return end

	if (item.isStackable and quantity >= 2) then
		if (amount == quantity) then return end

		if (character:GetInventory():Add(item.uniqueID, 1, {quantity = amount}, nil, nil, nil, true)) then
			amount = quantity - amount

			if (amount < 1) then
				item:Remove()
			else
				item:SetData("quantity", amount)
			end
		else
			client:NotifyLocalized("noFit")
		end
	else
		if (amount == rounds) then return end

		if (character:GetInventory():Add(item.uniqueID, 1, {rounds = amount}, nil, nil, nil, true)) then
			amount = rounds - amount

			if (amount < 1) then
				item:Remove()
			else
				item:SetData("rounds", amount)
			end
		else
			client:NotifyLocalized("noFit")
		end
	end
end)

-- HOOKS --
function PLUGIN:ArcCW_PlayerCanAttach(client, weapon, attID, slot, detach)
	if (ix.arccw_support.free_atts[attID]) then
		return
	end

	if ((client.StopArcAttach or 0) < CurTime()) then
		client.StopArcAttach = nil
	else
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

			if (mods[slot] and client:GetCharacter():GetInventory():Add(attID)) then
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
	if (weapon.ArcCW and !weapon.Singleton) then
		-- if (!ArcCW.EnableCustomization or GetConVar("arccw_enable_customization"):GetInt() < 0 or GetConVar("arccw_attinv_free"):GetBool()) then
			-- return
		-- end

		timer.Simple(.2, function()
			ix.arccw_support.InitWeapon(client, weapon)
		end)
	end
end