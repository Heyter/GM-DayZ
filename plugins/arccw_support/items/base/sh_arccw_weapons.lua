ITEM.base = "base_weapons"

ITEM.name = "ArcCW Weapon"
ITEM.category = "ArcCW Weapons"
ITEM.weaponCategory = "primary"

ITEM.attachments = {}

ITEM.isArcCW = true

ITEM.useDurability = true
ITEM.DegradeRate = 0.5 -- The degrade rate of the durability of the weapon with each shot
ITEM.JamCapacity = 100 -- Rounds that can be fired non-stop before the gun jams, playing the "fix" animation

ITEM.ammo = nil -- type of the ammo

-- Категория для рем.комплекта, должно совпадать и в ремнаборе и здесь.
ITEM.categoryKit = "weapons"

function ITEM:GetSellPrice(base_price)
--[[ 	local attach_modifier = table.Count(self:GetData("mods", {}))
	local liquid_price = (base_price + (base_price * attach_modifier)) * (self:GetData("durability", 100) / 100)

	return liquid_price ]]
	return base_price * (self:GetData("durability", 100) / 100)
end

function ITEM:CanSell()
	return (self:GetData("durability", 100) > 0)
end

if (CLIENT) then
	function ITEM:CanStack(combineItem)
		return combineItem:GetData("durability", 100) == self:GetData("durability", 100)
			and combineItem:GetData("ammo", 0) == self:GetData("ammo", 0)
	end

	function ITEM:PaintOver(itemObj, w, h)
		local x, y = w - 14, h - 14

		if (itemObj:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(x, y, 8, 8)

			x = x - 8 * 1.6
		end

		if (!table.IsEmpty(itemObj:GetData("mods", {}))) then
			surface.SetDrawColor(255, 255, 110, 100)
			surface.DrawRect(x, y, 8, 8)
		end

		draw.SimpleTextOutlined(itemObj:GetData("ammo", 0), "GmodZ.Numeric", 1, 5, Color("orange"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

		if (itemObj.useDurability) then
			local durability = math.max(0, itemObj:GetData("durability", 100))
			-- 2.55 = (255 / 100)
			local durabilityColor = Color(2.55 * (100 - durability), 2.55 * durability, 0, 255)

			draw.SimpleTextOutlined(math.Round(durability, 1) .. "%", "GmodZ.Numeric", 1, h - 10, durabilityColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("equip")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end

		if (self.attachments and !table.IsEmpty(self.attachments)) then
			local mods = self:GetData("mods", {})

			if (!table.IsEmpty(mods)) then
				local text = {}
				local item

				for _, itemID in pairs(mods) do
					item = ix.item.list[itemID]

					text[#text + 1] = (item and item.name) or itemID
				end

				text = table.concat(text, " + ")

				if (isstring(text)) then
					local row = tooltip:AddRowAfter("description", "ArcCWMods")
					row:SetText(text)
					row:SetBackgroundColor(derma.GetColor("Warning", tooltip))
					row:SizeToContents()
				end
			end
		end
	end

	function ITEM:CanTooltip(targetItem)
		if (targetItem.ammoAmount and targetItem.ammo == self.ammo) then
			return true
		elseif (targetItem.isAttachment and self.attachments and self.attachments[targetItem.uniqueID]) then
			return true
		end

		return false
	end
else
	function ITEM:OnInstanced(index)
		if (index == 0) then
			self:SetData("durability", 100 * math.Rand(0.1, 0.9), false)
		end
	end

	function ITEM:Equip(client, bNoSelect, bNoSound)
		local items = client:GetCharacter():GetInventory():GetItems(true)

		client.carryWeapons = client.carryWeapons or {}

		local equippedItem
		for _, v in pairs(items) do
			if (v.id != self.id and v.isWeapon and client.carryWeapons[self.weaponCategory] and v:GetData("equip")) then
				equippedItem = v
				break
			end
		end

		if (equippedItem) then
			equippedItem:Unequip(client)

			if (equippedItem:GetData("equip")) then
				client:NotifyLocalized("weaponSlotFilled", self.weaponCategory)
				return false
			end
		end

		if (client:HasWeapon(self.class)) then
			client:StripWeapon(self.class)
		end

		local weapon = client:Give(self.class, !self.isGrenade)

		if (IsValid(weapon)) then
			local ammoType = weapon:GetPrimaryAmmoType()

			client.carryWeapons[self.weaponCategory] = weapon

			if (!bNoSelect) then
				client:SelectWeapon(weapon:GetClass())
			end

			if (!bNoSound) then
				client:EmitSound(self.useSound, 80)
			end

			-- Remove default given ammo.
			if (client:GetAmmoCount(ammoType) == weapon:Clip1() and self:GetData("ammo", 0) == 0) then
				client:RemoveAmmo(weapon:Clip1(), ammoType)
			end

			-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
			-- TODO: figure out if this interferes with any other weapons
			if (weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
				client:SetAmmo(1, ammoType)
			end

			self:SetData("equip", true)

			if (self.isGrenade) then
				weapon:SetClip1(1)
				client:SetAmmo(0, ammoType)
			else
				weapon:SetClip1(self:GetData("ammo", 0))
			end

			weapon.ixItem = self

			if (self.OnEquipWeapon) then
				self:OnEquipWeapon(client, weapon)
			end
		else
			print(Format("[Helix] Cannot equip weapon - %s does not exist!", self.class))
		end
	end
end

ITEM.functions.Detach = {
	name = "Detach",
	icon = "icon16/wrench.png",
	isMulti = true,
	multiOptions = function(item)
		local targets = {}
		local targetItem

		for _, attItemID in pairs(item:GetData("mods", {})) do
			targetItem = ix.item.list[attItemID]

			targets[#targets + 1] = {
				name = (targetItem and targetItem.name) or attItemID,
				data = { attItemID }
			}
		end

		return targets
	end,

	OnCanRun = function(item)
		return (
			!IsValid(item.entity) and
			IsValid(item.player) and
			item.invID == item.player:GetCharacter():GetInventory():GetID() and
			!table.IsEmpty(item:GetData("mods", {}))
		)
	end,

	OnRun = function(item, data)
		if (!istable(data) or !data[1]) then return false end
		if (!ix.item.list[data[1]]) then return false end -- stop hacking you dumb fuck

		ix.arccw_support.Detach(item, data[1])
		return false
	end
}

ITEM.functions.empty_clip = {
	name = "Empty clip",
	tip = "emptyClipTip",
	icon = "icon16/bullet_yellow.png",

	OnCanRun = function(itemSelf)
		if (CLIENT) then
			return !itemSelf.isGrenade and itemSelf.player:GetItemWeaponAmmo(itemSelf) >= 1
		end

		return !itemSelf.isGrenade and itemSelf.isWeapon
	end,

	OnRun = function(itemSelf)
		ix.arccw_support.EmptyClip(itemSelf)

		return false
	end
}

ITEM.functions.Repair = {
	name = "Repair",
	tip = "equipTip",
	icon = "icon16/bullet_wrench.png",
	OnRun = function(item)
		local client = item.player
		local itemKit

		for _, v in pairs(client:GetCharacter():GetInventory():GetItems(true)) do
			if (v.base == "base_repair_kit" and v.categoryKit and v.categoryKit == (item.categoryKit or "")) then
				itemKit = v
				break
			end
		end

		if (itemKit) then
			itemKit:UseRepair(item, client)
			client:SetLocalVar("WeaponDurability", nil)

			itemKit = nil
		else
			client:NotifyLocalized('RepairKitWrong')
		end

		return false
	end,

	OnCanRun = function(item)
		if (item:GetData("durability", 100) >= 100) then
			return false
		end

		if (CLIENT) then
			if (!item.player:GetCharacter():GetInventory():HasItemOfBase("base_repair_kit")) then
				return false
			end
		end

		return true
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if (!data or !data[1]) then
			return false
		end

		if (CLIENT) then
			local combineItem = ix.item.instances[data[1]]
			if (!combineItem or !item.useDurability) then return false end

			if (combineItem.base == "base_repair_kit") then
				if (!item.useDurability or item:GetData("durability", 100) >= 100) then return false end
			end
		end

		return (!IsValid(item.entity) and item.isWeapon and item.isArcCW)
	end,
	OnRun = function(item, data)
		local client = item.player

		if (!IsValid(client) or !istable(data) or !data[1]) then return false end
		local combineItem = ix.item.instances[data[1]]
		if (!combineItem) then return false end

		if (combineItem.isAttachment) then
			if (ix.arccw_support.Attach(item, combineItem.uniqueID)) then
				combineItem:Remove()
			end
		elseif (combineItem.base == "base_repair_kit" and combineItem.categoryKit == item.categoryKit and item.useDurability and item:GetData("durability", 100) < 100) then
			combineItem:UseRepair(item, client)
			client:SetLocalVar("WeaponDurability", nil)
		end

		return false
	end,
}

hook.Add("PlayerDeath", "ixStripClip", function(client)
	client.carryWeapons = {}
	local weapon

	for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if (v.isWeapon and v:GetData("equip")) then
			weapon = client:GetWeapon(v.class)

			if (IsValid(weapon) and weapon:Clip1() > 0) then
				v:SetData("ammo", weapon:Clip1(), false)
			else
				v:SetData("ammo", nil, false)
			end

			v:SetData("equip", nil, false)

			if (v.pacData) then
				v:RemovePAC(client)
			end
		end
	end
end)