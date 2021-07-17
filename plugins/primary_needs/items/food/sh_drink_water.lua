ITEM.name = "Bottled Water"
ITEM.model = "models/gmodz/food/water.mdl"
ITEM.description = "A bottle filled with clear water."

ITEM.thirstAmount = 0.65
ITEM.radiationAmount = -100
ITEM.price = 70
ITEM.useSound = "gmodz/primary_needs/drinking.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end