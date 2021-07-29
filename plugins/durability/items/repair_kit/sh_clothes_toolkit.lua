ITEM.name = "Clothes repair kit"
ITEM.model = "models/gmodz/misc/repair_kit_armor.mdl"
ITEM.description = ""

ITEM.width = 2
ITEM.height = 1

ITEM.raiseDurability = 0.75
ITEM.isWeaponKit = nil
ITEM.price = 500
ITEM.categoryKit = "armors"

ITEM.useSound = "gmodz/items/repair_outfit.wav"

ITEM.rarity = { weight = 7 }
if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("Restores %d%% of the durability.", self.raiseDurability)
		return text
	end
end