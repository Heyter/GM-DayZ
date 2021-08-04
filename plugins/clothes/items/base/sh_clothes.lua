ITEM.name = "Clothes"
ITEM.description = "A Clothes Base."
ITEM.category = "Clothes"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "hat"
ITEM.pacData = {}

ITEM.useDurability = true
ITEM.defDurability = 100
-- 1 = full protection (0 - 1). 0.5 = 50% (half protection)
ITEM.damageReduction = { [HITGROUP_HEAD] = 0 }
-- слетает предмет с головы когда durability = 0, но применимо лишь для outfitCategory = hat
ITEM.dropHat = false

-- Прочность с которой будет спавниться предмет (min-max)
ITEM.spawnDurability = {0.5, 1}

-- Категория для рем.комплекта, должно совпадать и в ремнаборе и здесь.
ITEM.categoryKit = "clothes"

-- Модификатор скорости игрока (можно отрицательные значения).
-- ITEM.speedModify = 30

-- Модификатор прыжка.
-- ITEM.jumpModify = 50

-- Запретить ли бегать (SHIFT)
-- ITEM.disableSprint = true

--[[
ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(12.919322967529, 6.5696062847564e-006, -1.0949343050015e-005),
					["Position"] = Vector(-2.099609375, 0.019973754882813, 1.0180969238281),
					["UniqueID"] = "4249811628",
					["Size"] = 1.25,
					["Bone"] = "eyes",
					["Model"] = "models/Gibs/HGIBS.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "907159817",
			["EditorExpand"] = true,
		},
	},
}
--]]

if (CLIENT) then
	function ITEM:PaintOver(itemObj, w, h)
		local x, y = w - 14, h - 14

		if (itemObj:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)

			x = x - 8 * 1.6
		end

		if (itemObj.useDurability) then
			local durability = math.max(0, itemObj:GetData("durability", itemObj.defDurability))
			-- 2.55 = (255 / 100)
			local durabilityColor = Color(2.55 * (100 - durability), 2.55 * durability, 0, 255)

			durability = (durability / itemObj.defDurability) * 100
			draw.SimpleTextOutlined(math.Round(durability, 1) .. "%", "GmodZ.Numeric", 1, h - 10, durabilityColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		local upperName = self.outfitCategory:sub(1, 1):upper() .. self.outfitCategory:sub(2)

		local panel = tooltip:AddRowAfter("description", "extendDesc")
		panel:SetText(L("clothes_text_slot", L(upperName)))
		panel:SetTextColor(color_white)
		panel:SetExpensiveShadow(1, color_black)
		panel:SizeToContents()
	end

	function ITEM:CanStack(combineItem)
		return combineItem:GetData("durability", combineItem.defDurability) == self:GetData("durability", self.defDurability)
	end
end

function ITEM:GetSellPrice(base_price, scale)
	return scale * (base_price + base_price) * (self:GetData("durability", self.defDurability) / self.defDurability)
end

function ITEM:CanSell()
	return (self:GetData("durability", self.defDurability) > 0)
end

function ITEM:RemovePart(client, bDropItem)
	local char = client:GetCharacter()

	self:SetData("equip", nil)
	client:RemovePart(self.uniqueID)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:RemoveBoost(self.uniqueID, k)
		end
	end

	self:OnUnequipped(client)

	if (bDropItem) then
		return self:Transfer(nil, nil, nil, client, nil, true)
	end

	return true
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item:RemovePart(item:GetOwner())
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		item:RemovePart(item.player)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					item.player:NotifyLocalized(item.equippedNotify or "outfitAlreadyEquipped")

					return false
				end
			end
		end

		item:SetData("equip", true)
		item.player:AddPart(item.uniqueID, item)

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:AddBoost(item.uniqueID, k, v)
			end
		end

		item:OnEquipped(item.player)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and item:CanEquipOutfit() and
			hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
	local owner = inventory.GetOwner and inventory:GetOwner()

	if (IsValid(owner) and owner:IsPlayer()) then
		if (self:GetData("equip")) then
			self:RemovePart(owner)
		elseif (owner:GetClothesItem()[self.outfitCategory]) then -- bugfix
			owner:SetClothesItem(self.outfitCategory, nil)
		end
	end
end

function ITEM:OnEquipped(client)
	client:SetClothesItem(self.outfitCategory, self)
end

function ITEM:OnUnequipped(client)
	client:SetClothesItem(self.outfitCategory, nil)
end

function ITEM:CanEquipOutfit()
	if (SERVER) then
		return self:GetData("durability", self.defDurability or 100) > 0 and !self.player:GetClothesItem()[self.outfitCategory]
	end

	return self:GetData("durability", self.defDurability or 100) > 0
end

if (SERVER) then
	function ITEM:OnLoadout()
		if (self:GetData("equip")) then
			self:OnEquipped(self.player)
		end
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if (!data or !data[1] or item.player and (item.player.nextUseItem or 0) > CurTime()) then
			return false
		end

		if (CLIENT) then
			local combineItem = ix.item.instances[data[1]]
			if (!combineItem or !item.useDurability) then return false end

			if (combineItem.base == "base_repair_kit") then
				if (!item.useDurability or item:GetData("durability", 100) >= 100) then return false end
			end
		end

		return (!IsValid(item.entity) and item.base == "base_clothes")
	end,
	OnRun = function(item, data)
		if (!IsValid(item.player) or !istable(data) or !data[1]) then return false end
		local combineItem = ix.item.instances[data[1]]
		if (!combineItem) then return false end

		if (combineItem.base == "base_repair_kit" and combineItem.categoryKit == item.categoryKit and item.useDurability and item:GetData("durability", 100) < 100) then
			combineItem:UseRepair(item, item.player)
		end

		return false
	end,
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
			itemKit = nil
		else
			client:NotifyLocalized('RepairKitWrong')
		end

		return false
	end,

	OnCanRun = function(item)
		if (item.player and (item.player.nextUseItem or 0) > CurTime() or item:GetData("durability", 100) >= 100) then
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

if (SERVER) then
	function ITEM:OnInstanced(index)
		if (index == 0 and self.spawnDurability) then
			self:SetData("durability", math.random(0, self.defDurability * math.Rand(self.spawnDurability[1], self.spawnDurability[2])), false)
		end
	end
end