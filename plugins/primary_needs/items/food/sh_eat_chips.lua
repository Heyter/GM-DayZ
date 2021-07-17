ITEM.name = "Chips"
ITEM.model = "models/warz/consumables/bag_chips.mdl"
ITEM.description = "A sealed plastic bag filled with semi-crushed potato chips."

ITEM.hungerAmount = 0.12
ITEM.thirstAmount = -0.01
ITEM.price = 60
ITEM.useSound = "gmodz/primary_needs/chips.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end