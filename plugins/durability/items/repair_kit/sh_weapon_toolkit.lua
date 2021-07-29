ITEM.name = "Weapon repair kit"
ITEM.model = "models/gmodz/misc/repair_kit_weapon.mdl"
ITEM.description = ""

ITEM.width = 2
ITEM.height = 1

ITEM.raiseDurability = 0.75
ITEM.isWeaponKit = true
ITEM.price = 500

ITEM.useSound = "gmodz/items/repair_weapon.wav"

ITEM.rarity = { weight = 7 }

if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("Restores %d%% of the durability.", self.raiseDurability)
		return text
	end
end