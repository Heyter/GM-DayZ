ITEM.base = "base_stackable"

ITEM.name = "Food Base"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "This is base a food."
ITEM.category = "Consumables"

// -0.3; 0.3
ITEM.hungerAmount = 0.3 -- процент
ITEM.thirstAmount = 0.3 -- процент
ITEM.healthAmount = 0
ITEM.staminaAmount = 0
ITEM.radiationAmount = 0

--ITEM.drinkSound = "gmodz/primary_needs/drinking.wav"

ITEM.useSound = "gmodz/primary_needs/eating.wav"
-- ITEM.useSound = {"items/medshot4.wav", 60, 100} // soundName, soundLevel, pitchPercent

ITEM.price = 0
ITEM.maxQuantity = 16

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
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
end

ITEM.functions.use = {
    name = "Consume", -- Употребить
	icon = "icon16/cup.png",
    OnRun = function(item)
		local client = item.player
		client.nextUseItem = CurTime() + 1

		if (item.healthAmount != 0) then
			local health = client:Health() + item.healthAmount

			if (item.healthAmount < 1 and health <= 0) then
				client:Kill()
			end

			if (health > 0) then
				client:SetHealth(math.min(client:GetMaxHealth(), health))
			end
		end

		if (item.staminaAmount != 0) then
			client:RestoreStamina(item.staminaAmount)
		end

		if (item.hungerAmount != 0) then
			client:AddHunger(item.hungerAmount * ix.config.Get("hungrySeconds", 3500))
		end

		if (item.thirstAmount != 0) then
			client:AddThirst(item.thirstAmount * ix.config.Get("thirstySeconds", 2000))
		end

		item:Call("OnUse")

		if (item.useSound) then
			if (isstring(item.useSound)) then
				client:EmitSound(item.useSound, 60)
			elseif (istable(item.useSound)) then
				client:EmitSound(unpack(item.useSound))
			end
		end

		item:PlayerDropItem(client)

		return item:UseStackItem()
	end,

	OnCanRun = function(item)
		if item.player and (item.player.nextUseItem or 0) > CurTime() then return false end
		if (item.OnCanUse and item:OnCanUse() == false) then return false end

		return true
	end
}