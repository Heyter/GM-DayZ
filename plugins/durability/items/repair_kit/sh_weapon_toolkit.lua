ITEM.name = "Weapon repair kit"
ITEM.model = "models/lostsignalproject/items/repair/toolkit_wp.mdl"
ITEM.description = ""

ITEM.raiseDurability = 75
ITEM.isClothesKit = nil
ITEM.isWeaponKit = true
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