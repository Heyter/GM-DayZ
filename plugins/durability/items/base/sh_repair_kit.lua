ITEM.base = "base_stackable"

ITEM.name = "Repair Kit Base"
ITEM.category = "RepairKit"
ITEM.description = "Repair Kit Base description"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.raiseDurability = 25

-- Only allowed for weapons.
ITEM.isWeaponKit = true

ITEM.useSound = "gmodz/durability/repair_weapon.wav"
-- ITEM.useSound = {"items/medshot4.wav", 60, 100} // soundName, soundLevel, pitchPercent
ITEM.price = 0
ITEM.maxQuantity = 16

if (SERVER) then
	-- item: The current used item.
	function ITEM:UseRepair(combineItem, client, useSound)
		client.nextUseItem = CurTime() + 1
		useSound = useSound or self.useSound

		combineItem:SetData("durability", math.Clamp(combineItem:GetData("durability", 100) + self.raiseDurability, 0, 100))

		if (useSound) then
			if (isstring(useSound)) then
				client:EmitSound(useSound, 60)
			elseif (istable(useSound)) then
				client:EmitSound(useSound[1], useSound[2], useSound[3])
			end
		end

		if (self:UseStackItem()) then
			self:Remove()
		end
	end

	function ITEM:GetDescription()
		return Format(self.description, self.raiseDurability)
	end
end

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local text = {}

		if (self.raiseDurability != 0) then
			text[#text + 1] = Format("%s: %s%d", L"raiseDurability", self.raiseDurability < 0 and "-" or "+", math.abs(self.raiseDurability))
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