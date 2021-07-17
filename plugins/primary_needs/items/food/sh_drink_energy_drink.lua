ITEM.name = "Energy drink"
ITEM.model = "models/gmodz/food/energy_drink.mdl"
ITEM.description = "A bottle filled with some carbonated flavoured water."

ITEM.thirstAmount = 0.3
ITEM.hungerAmount = 0.05
ITEM.staminaAmount = 0.7
ITEM.staminaRegenTime = 25
ITEM.price = 120
ITEM.useSound = "gmodz/primary_needs/soda.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end