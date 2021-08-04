ITEM.base = "base_outfit"

ITEM.useDurability = true
ITEM.defDurability = 100
-- 1 = full protection (0 - 1). 0.5 = 50% (half protection)
ITEM.damageReduction = { [HITGROUP_HEAD] = 0 }

ITEM.outfitCategory = "suit"

-- Прочность с которой будет спавниться предмет (min-max)
ITEM.spawnDurability = {0.6, 1}

-- Категория для рем.комплекта, должно совпадать и в ремнаборе и здесь.
ITEM.categoryKit = "armors"
ITEM.isArmor = true

-- Модификатор скорости игрока (можно отрицательные значения).
-- ITEM.speedModify = 30

-- Модификатор прыжка.
-- ITEM.jumpModify = 50

-- Запретить ли бегать (SHIFT)
-- ITEM.disableSprint = true

-- Изменение звука шагов (всего 2 шага. 0 и 1)
--[[ ITEM.runSounds = {
	[0] = "sound.wav",
	[1] = "sound.wav"
} ]]

--[[
-- This will change a player's skin after changing the model. Keep in mind it starts at 0.
ITEM.newSkin = 1
-- This will change a certain part of the model.
ITEM.replacements = {"group01", "group02"}
-- This will change the player's model completely.
ITEM.replacements = "models/manhack.mdl"
-- This will have multiple replacements.
ITEM.replacements = {
	{"male", "female"},
	{"group01", "group02"}
}

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
]]--

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

function ITEM:AddOutfit(client)
	local character = client:GetCharacter()

	self:SetData("equip", true)

	local groups = character:GetData("groups", {})

	-- remove original bodygroups
	if (!table.IsEmpty(groups)) then
		character:SetData("oldGroups" .. self.outfitCategory, groups)
		character:SetData("groups", {})

		client:ResetBodygroups()
	end

	if (isfunction(self.OnGetReplacement)) then
		character:SetData("oldModel" .. self.outfitCategory,
			character:GetData("oldModel" .. self.outfitCategory, self.player:GetModel()))
		character:SetModel(self:OnGetReplacement())
	elseif (self.replacement or self.replacements) then
		character:SetData("oldModel" .. self.outfitCategory,
			character:GetData("oldModel" .. self.outfitCategory, self.player:GetModel()))

		if (istable(self.replacements)) then
			if (#self.replacements == 2 and isstring(self.replacements[1])) then
				character:SetModel(self.player:GetModel():gsub(self.replacements[1], self.replacements[2]))
			else
				for _, v in ipairs(self.replacements) do
					character:SetModel(self.player:GetModel():gsub(v[1], v[2]))
				end
			end
		else
			character:SetModel(self.replacement or self.replacements)
		end
	end

	if (self.newSkin) then
		character:SetData("oldSkin" .. self.outfitCategory, self.player:GetSkin())
		self.player:SetSkin(self.newSkin)
	end

	-- get outfit saved bodygroups
	groups = self:GetData("groups", {})

	-- restore bodygroups saved to the item
	if (!table.IsEmpty(groups) and self:ShouldRestoreBodygroups()) then
		for k, v in pairs(groups) do
			client:SetBodygroup(k, v)
		end
	-- apply default item bodygroups if none are saved
	elseif (istable(self.bodyGroups)) then
		for k, v in pairs(self.bodyGroups) do
			local index = client:FindBodygroupByName(k)

			if (index > -1) then
				client:SetBodygroup(index, v)
			end
		end
	end

	local materials  = self:GetData("submaterial", {})

	if (!table.IsEmpty(materials) and self:ShouldRestoreSubMaterials()) then
		for k, v in pairs(materials) do
			if (!isnumber(k) or !isstring(v)) then
				continue
			end

			client:SetSubMaterial(k - 1, v)
		end
	end

	if (istable(self.attribBoosts)) then
		for k, v in pairs(self.attribBoosts) do
			character:AddBoost(self.uniqueID, k, v)
		end
	end

	-- arg client
	self:OnEquipped(client)
end

local function ResetSubMaterials(client)
	for k, _ in ipairs(client:GetMaterials()) do
		if (client:GetSubMaterial(k - 1) != "") then
			client:SetSubMaterial(k - 1)
		end
	end
end

function ITEM:RemoveOutfit(client)
	local character = client:GetCharacter()

	self:SetData("equip", false)

	local materials = {}

	for k, _ in ipairs(client:GetMaterials()) do
		if (client:GetSubMaterial(k - 1) != "") then
			materials[k] = client:GetSubMaterial(k - 1)
		end
	end

	-- save outfit submaterials
	if (!table.IsEmpty(materials)) then
		self:SetData("submaterial", materials)
	end

	-- remove outfit submaterials
	ResetSubMaterials(client)

	local groups = {}

	for i = 0, (client:GetNumBodyGroups() - 1) do
		local bodygroup = client:GetBodygroup(i)

		if (bodygroup > 0) then
			groups[i] = bodygroup
		end
	end

	-- save outfit bodygroups
	if (!table.IsEmpty(groups)) then
		self:SetData("groups", groups)
	end

	-- remove outfit bodygroups
	client:ResetBodygroups()

	-- restore the original player model
	if (character:GetData("oldModel" .. self.outfitCategory)) then
		character:SetModel(character:GetData("oldModel" .. self.outfitCategory))
		character:SetData("oldModel" .. self.outfitCategory, nil)
	end

	-- restore the original player model skin
	if (self.newSkin) then
		if (character:GetData("oldSkin" .. self.outfitCategory)) then
			client:SetSkin(character:GetData("oldSkin" .. self.outfitCategory))
			character:SetData("oldSkin" .. self.outfitCategory, nil)
		else
			client:SetSkin(0)
		end
	end

	-- get character original bodygroups
	groups = character:GetData("oldGroups" .. self.outfitCategory, {})

	-- restore original bodygroups
	if (!table.IsEmpty(groups)) then
		for k, v in pairs(groups) do
			client:SetBodygroup(k, v)
		end

		character:SetData("groups", character:GetData("oldGroups" .. self.outfitCategory, {}))
		character:SetData("oldGroups" .. self.outfitCategory, nil)
	end

	if (istable(self.attribBoosts)) then
		for k, _ in pairs(self.attribBoosts) do
			character:RemoveBoost(self.uniqueID, k)
		end
	end

	for k, _ in pairs(self:GetData("outfitAttachments", {})) do
		self:RemoveAttachment(k, client)
	end

	self:OnUnequipped(client)
end

function ITEM:OnRemoved()
	if (self.invID != 0) then
		self.player = self:GetOwner()

		if (self:GetData("equip")) then
			self:RemoveOutfit(self.player)
		elseif (self.player:GetClothesItem()[self.outfitCategory]) then -- bugfix
			self.player:SetClothesItem(self.outfitCategory, nil)
		end

		self.player = nil
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
				if (!item.useDurability or item:GetData("durability", item.defDurability or 100) >= (item.defDurability or 100)) then return false end
			end
		end

		return (!IsValid(item.entity) and item.base == "base_clothes")
	end,
	OnRun = function(item, data)
		if (!IsValid(item.player) or !istable(data) or !data[1]) then return false end
		local combineItem = ix.item.instances[data[1]]
		if (!combineItem) then return false end

		if (combineItem.base == "base_repair_kit" and combineItem.categoryKit == item.categoryKit and item.useDurability) then
			local maxD = item.defDurability or 100

			if (item.useDurability and item:GetData("durability", maxD) < maxD) then
				combineItem:UseRepair(item, item.player)
			end
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
		local d = item.defDurability or 100

		if (item.player and (item.player.nextUseItem or 0) > CurTime() or item:GetData("durability", d) >= d) then
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