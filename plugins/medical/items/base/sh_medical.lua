ITEM.base = "base_stackable"

ITEM.name = "Medical Base"
ITEM.description = "Medical Description"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/healthvial.mdl"
ITEM.category = "Medical"

ITEM.useSound = "items/medshot4.wav"
-- ITEM.useSound = {"items/medshot4.wav", 60, 100} // soundName, soundLevel, pitchPercent

ITEM.healthAmount = 0
ITEM.staminaAmount = 0
ITEM.radiationAmount = 0

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

		if (self.ExtendDesc) then
			text = self:ExtendDesc(text)
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
    name = "option_use",
	icon = "icon16/add.png",
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

		if (item.radiationAmount != 0) then
			client:AddRadiation(item.radiationAmount)
		end

		item:Call("OnUse")

		if (item.useSound) then
			if (isstring(item.useSound)) then
				client:EmitSound(item.useSound, 60)
			elseif (istable(item.useSound)) then
				client:EmitSound(unpack(item.useSound))
			end
		end

		return item:UseStackItem()
	end,

	OnCanRun = function(item)
		if item.player and (item.player.nextUseItem or 0) > CurTime() then return false end
		if (item.OnCanUse and item:OnCanUse() == false) then return false end

		return true
	end
}