ITEM.name = "Sewing kit"
ITEM.model = "models/lostsignalproject/items/repair/toolkit_s.mdl"
ITEM.description = ""

ITEM.width = 2
ITEM.height = 1

ITEM.raiseDurability = 0.75
ITEM.isClothesKit = true
ITEM.isWeaponKit = nil
ITEM.price = 500

ITEM.rarity = { weight = 7 }
if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("Restores %d%% of the durability.", self.raiseDurability)
		return text
	end
end