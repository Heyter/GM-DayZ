ITEM.name = "Repair Kit Base"
ITEM.category = "RepairKit"
ITEM.description = "repairkit"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.useSound = "interface/inv_repair_kit.ogg"
ITEM.width = 1
ITEM.height = 1

ITEM.raiseDurability = 25
ITEM.quantity = 1

-- Only allowed for weapons.
ITEM.isWeaponKit = true

if (SERVER) then
	-- item: The current used item.
	function ITEM:UseRepair(item, client)
		local quantity = self:GetData("quantity", self.quantity or 1) - 1
		local new_durability = math.Clamp(item:GetData("durability", 100) + self.raiseDurability, 0, 100)

		item:SetData("durability", new_durability)

		if (self.useSound and IsValid(client)) then
			client:EmitSound(self.useSound, 110)
		end

		if (quantity < 1) then
			self:Remove()
		else
			self:SetData("quantity", quantity)
		end
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", item.quantity or 1)

		if (quantity > 0) then
			draw.SimpleText(quantity, "ixMerchant.Num", 1, 5, Color('orange'), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	function ITEM:GetDescription()
		return Format(self.description, self.raiseDurability)
	end
end