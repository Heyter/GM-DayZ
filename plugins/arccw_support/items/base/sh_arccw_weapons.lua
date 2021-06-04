ITEM.base = "base_weapons"

ITEM.name = "ArcCW Weapon"
ITEM.category = "ArcCW Weapons"
ITEM.weaponCategory = "primary"

ITEM.attachments = {}

ITEM.isArcCW = true

ITEM.useDurability = true
ITEM.DegradeRate = 0.5 -- durability
ITEM.JamChance = 0.04 -- jamming

ITEM.ammo = nil -- type of the ammo

function ITEM:GetJamChance()
	return self.JamChance * 50
end

function ITEM:GetSellPrice(base_price, scale)
	local attach_modifier = scale * table.Count(self:GetData("mods", {}))
	local liquid_price = scale * (base_price + (base_price * attach_modifier)) * (self:GetData("durability", 100) / 100)

	return liquid_price
end

function ITEM:CanSell()
	return (self:GetData("durability", 100) >= 0)
end

if (CLIENT) then
	function ITEM:CanStack(combineItem)
		return combineItem:GetData("durability", combineItem.ammoAmount) == self:GetData("durability", self.ammoAmount)
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

		draw.SimpleTextOutlined(itemObj:GetData("ammo", 0), "ixMerchant.Num", 1, 5, Color("orange"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

		local durability = math.max(0, itemObj:GetData("durability", 100))
		-- 2.55 = (255 / 100)
		local durabilityColor = Color(2.55 * (100 - durability), 2.55 * durability, 0, 255)

		draw.SimpleTextOutlined(math.Round(durability, 1) .. "%", "ixMerchant.Num", 1, h - 10, durabilityColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
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
			return !itemSelf.isGrenade and itemSelf.player:GetWeaponAmmo(itemSelf) >= 1
		end

		return !itemSelf.isGrenade
	end,

	OnRun = function(itemSelf)
		ix.arccw_support.EmptyClip(itemSelf) -- :)

		return false
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if (!data or !data[1] or item.player and (item.player.nextUseItem or 0) > CurTime()) then
			return false
		end

		if (CLIENT) then
			local combineItem = ix.item.instances[data[1]]
			if (!combineItem) then return false end

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
		elseif (combineItem.base == "base_repair_kit" and item.useDurability and item:GetData("durability", 100) < 100) then
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
				v:SetData("ammo", weapon:Clip1())
			else
				v:SetData("ammo", nil)
			end

			v:SetData("equip", nil)

			if (v.pacData) then
				v:RemovePAC(client)
			end
		end
	end
end)