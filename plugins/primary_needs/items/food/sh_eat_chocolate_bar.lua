ITEM.name = "Chocolate"
ITEM.model = "models/gmodz/food/chocolate_bar.mdl"
ITEM.description = "Delicious chocolate bar"

ITEM.hungerAmount = 0.1
ITEM.thirstAmount = -0.02
ITEM.staminaAmount = 0.3
ITEM.staminaRegenTime = 10
ITEM.price = 50
ITEM.useSound = "gmodz/primary_needs/eating.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end