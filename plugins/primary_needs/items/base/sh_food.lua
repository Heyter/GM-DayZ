ITEM.name = "Food Base"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "This is base a food."
ITEM.category = "Food"

// -0.3; 0.3
ITEM.hungerAmount = 0.3 -- процент
ITEM.thirstAmount = 0.3 -- процент
ITEM.healthAmount = 0
ITEM.staminaAmount = 0
ITEM.radiationAmount = 0

ITEM.isDrink = false

-- DRINKS
ITEM.volume = 250
ITEM.volumeText = "ml"
ITEM.slurpAmount = 0 -- 0 to 10 max.
ITEM.drinkSound = "gmodz/primary_needs/drinking.wav"

-- FOODS
ITEM.eatSound = "gmodz/primary_needs/eating.wav"
ITEM.quantity = 1 -- кол-во использований

if (CLIENT) then
	function ITEM:CanStack(combineItem)
		return combineItem:GetData("quantity", self.quantity or 1) == self:GetData("quantity", self.quantity or 1)
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self.isDrink and self.slurpAmount > 0) then
			local volume = self:GetData("volume", self.volume)
			local panel = tooltip:AddRowAfter("name", "volume")

			local tooltipFormat

			if (self.volumeText == "l" or volume != math.floor(volume)) then
				tooltipFormat = "%.2f/%.2f%s left"
			else
				tooltipFormat = "%d/%d%s left"
			end

			panel:SetText(Format(tooltipFormat, volume, self.volume, self.volumeText))
			panel:SetBackgroundColor(derma.GetColor("Success", panel))
			panel:SizeToContents()
		end

		local text = {}

		if (self.healthAmount != 0) then
			text[#text + 1] = Format("%s: %s%d", L"Health", self.healthAmount < 0 and "-" or "+", math.abs(self.healthAmount))
		end

		if (self.staminaAmount != 0) then
			text[#text + 1] = Format("%s: %s%d", L"Endurance", self.staminaAmount < 0 and "-" or "+", math.abs(self.staminaAmount))
		end

		if (self.radiationAmount != 0) then
			text[#text + 1] = Format("%s: %s%d", L"Radiation", self.radiationAmount < 0 and "-" or "+", math.abs(self.radiationAmount))
		end

		if (self.hungerAmount != 0) then
			text[#text + 1] = Format("%s: %s%d%%", L"needs_hunger",
				self.hungerAmount < 0 and "-" or "+",
				math.abs(self.hungerAmount * 100)
			)
		end

		if (self.thirstAmount != 0) then
			text[#text + 1] = Format("%s: %s%d%%", L"needs_thirst",
				self.thirstAmount < 0 and "-" or "+",
				math.abs(self.thirstAmount * 100)
			)
		end

		text = table.concat(text, "\n")

		if (isstring(text)) then
			local panel = tooltip:AddRowAfter("description", "extendDesc")
			panel:SetText(text)
			panel:SetTextColor(Color("green"))
			panel:SizeToContents()
		end
	end

	function ITEM:PaintOver(item, w, h)
		if (!item.isDrink) then
			local quantity = item:GetData("quantity", item.quantity or 1)

			if (quantity > 0) then
				draw.SimpleText(quantity, "ixMerchant.Num", 1, 5, Color("orange"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
			end
		end
	end
else
	function ITEM:ConsumeFood(client)
		if (self.healthAmount != 0) then
			local health = client:Health() + self.healthAmount

			if (self.healthAmount < 1 and health <= 0) then
				client:Kill()
			end

			if (health > 0) then
				client:SetHealth(math.Clamp(health, 0, client:GetMaxHealth()))
			end
		end

		if (self.staminaAmount != 0) then
			client:RestoreStamina(self.staminaAmount)
		end

		if (self.hungerAmount != 0) then
			client:AddHunger(self.hungerAmount * ix.config.Get("hungrySeconds", 3500))
		end

		if (self.thirstAmount != 0) then
			client:AddThirst(self.thirstAmount * ix.config.Get("thirstySeconds", 2000))
		end

		if (self.isDrink) then
			if (self.drinkSound) then
				client:EmitSound(self.drinkSound, 50, 100)
			end

			local newVolume = math.Clamp(math.Round(self:GetData("volume", self.volume) - (self.volume / self.slurpAmount), 2), 0, self.volume)

			if (newVolume <= 0) then
				return true
			else
				self:SetData("volume", newVolume)
			end
		else
			if (self.eatSound) then
				client:EmitSound(self.eatSound, 50, 100)
			end

			local newQuantity = self:GetData("quantity", self.quantity or 1) - 1

			if (newQuantity < 1) then
				return true
			else
				self:SetData("quantity", newQuantity)
			end
		end

		return false
	end
end

ITEM.functions.use = {
    name = "Consume", -- Употребить
	icon = "icon16/cup.png",
    OnRun = function(item)
        return item:ConsumeFood(item.player)
	end,

	OnCanRun = function(item)
		if (item.isDrink) then
			return item.slurpAmount > 0
		end

		return item:GetData("quantity", item.quantity or 1) > 0
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if (!data or !data[1] or item:GetData("quantity", item.quantity or 1) >= 99) then
			return false
		end

		if (CLIENT) then
			local combineItem = ix.item.instances[data[1]]
			if (!combineItem or 
				combineItem.isDrink or 
				combineItem:GetData("quantity", combineItem.quantity or 1) >= 99 or
				combineItem.uniqueID != item.uniqueID) then
				return false
			end
		end

		return (!item.isDrink)
	end,

	OnRun = function(item, data)
		if (!istable(data) or !data[1]) then return false end

		local combineItem = ix.item.instances[data[1]]
		if (!combineItem or combineItem.isDrink) then return false end

		if (combineItem.uniqueID == item.uniqueID) then
			-- TODO: Более точный стак, через перебор в цикле
			local oldQuantity = combineItem:GetData("quantity", item.quantity or 1)
			combineItem:Remove()

			local newQuantity = item:GetData("quantity", item.quantity or 1) + oldQuantity
			item:SetData("quantity", math.min(99, newQuantity))
		end

		return false
	end
}