ITEM.name = "Snickers"
ITEM.model = "models/gmodz/food/snickers.mdl"
ITEM.description = "Delicious candy bar"

ITEM.hungerAmount = 0.12
ITEM.staminaAmount = 0.35
ITEM.staminaRegenTime = 10
ITEM.price = 65
ITEM.useSound = "gmodz/primary_needs/crunchy.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end