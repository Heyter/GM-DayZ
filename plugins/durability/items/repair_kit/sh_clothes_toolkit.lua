ITEM.name = "Sewing kit"
ITEM.model = "models/lostsignalproject/items/repair/toolkit_s.mdl"
ITEM.description = ""

ITEM.raiseDurability = 0.75
ITEM.isClothesKit = true
ITEM.isWeaponKit = nil
ITEM.price = 500

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 7 }
end

if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("Restores %d%% of the durability.", self.raiseDurability)
		return text
	end
end