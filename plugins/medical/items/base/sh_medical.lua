ITEM.name = "Medical Base"
ITEM.description = "Medical Description"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/healthvial.mdl"
ITEM.category = "Medical Supplies"

ITEM.useSound = "items/medshot4.wav"
-- ITEM.useSound = {"items/medshot4.wav", 60, 100} // soundName, soundLevel, pitchPercent
ITEM.quantity = 1 -- кол-во использований

ITEM.healthAmount = 0
ITEM.staminaAmount = 0
ITEM.radiationAmount = 0

if (CLIENT) then
	function ITEM:CanStack(combineItem)
		return combineItem:GetData("quantity", item.quantity or 1) == self:GetData("quantity", self.quantity or 1)
	end

	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", item.quantity or 1)

		if (quantity > 0) then
			draw.SimpleText(quantity, "ixMerchant.Num", 1, 5, Color("orange"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

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

		if (item.useSound) then
			if (isstring(item.useSound)) then
				client:EmitSound(item.useSound, 60)
			elseif (istable(item.useSound)) then
				client:EmitSound(item.useSound[1], item.useSound[2], item.useSound[3])
			end
		end

		if (item.healthAmount != 0) then
			local health = client:Health() + item.healthAmount

			if (item.healthAmount < 1 and health <= 0) then
				client:Kill()
			end

			if (health > 0) then
				client:SetHealth(math.Clamp(health, 0, client:GetMaxHealth()))
			end
		end

		if (item.staminaAmount != 0) then
			client:RestoreStamina(item.staminaAmount)
		end

		if (item.radiationAmount != 0) then
			client:AddRadiation(item.radiationAmount)
		end

		item:Call("OnUse")

		local newQuantity = item:GetData("quantity", item.quantity or 1) - 1

		if (newQuantity < 1) then
			return true
		else
			item:SetData("quantity", newQuantity)
		end

		return false
	end,

	OnCanRun = function(item)
		if (item.player and item.player.nextUseItem or 0) > CurTime() then return false end
		if (item.OnCanUse and item:OnCanUse() == false) then return false end

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
			if (!combineItem or combineItem:GetData("quantity", combineItem.quantity or 1) >= 99 or combineItem.uniqueID != item.uniqueID) then
				return false
			end
		end

		return true
	end,

	OnRun = function(item, data)
		if (!istable(data) or !data[1]) then return false end
		local combineItem = ix.item.instances[data[1]]
		if (!combineItem) then return false end

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