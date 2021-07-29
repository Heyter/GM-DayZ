ITEM.base = "base_stackable"

ITEM.name = "Repair Kit Base"
ITEM.category = "RepairKit"
ITEM.description = "Repair Kit Base description"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.raiseDurability = 0 -- процент

-- Категория для рем.комплекта, должно совпадать и в ремнаборе и здесь.
-- ITEM.categoryKit = "weapons"

ITEM.useSound = "gmodz/durability/repair_weapon.wav"
ITEM.price = 0
ITEM.maxQuantity = 16

if (SERVER) then
	-- item: The current used item.
	function ITEM:UseRepair(combineItem, client, useSound)
		if (self.raiseDurability == 0) then return end

		client.nextUseItem = CurTime() + 1
		useSound = useSound or self.useSound

		local d = combineItem.defDurability or 100
		combineItem:SetData("durability", math.Clamp(combineItem:GetData("durability", d) + (self.raiseDurability * d), 0, d))

		if (useSound) then
			if (isstring(useSound)) then
				client:EmitSound(useSound, 60)
			elseif (istable(useSound)) then
				client:EmitSound(#useSound[math.random(#useSound)])
			elseif (self.useSound and isfunction(self.useSound)) then
				self:useSound(combineItem, client)
			end
		end

		if (self:UseStackItem()) then
			self:Remove()
		end
	end
end

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local text = {}

		if (self.raiseDurability != 0) then
			text[#text + 1] = Format("%s: %s%d%%", L"raiseDurability", self.raiseDurability < 0 and "-" or "+", math.abs(self.raiseDurability * 100))
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