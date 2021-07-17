ITEM.name = "Coca-cola"
ITEM.model = "models/gmodz/food/cocacola.mdl"
ITEM.description = "Glass bottle filled with some carbonated flavoured water."

ITEM.thirstAmount = 0.4
ITEM.staminaAmount = 0.25
ITEM.staminaRegenTime = 5
ITEM.healthAmount = 1
ITEM.price = 75
ITEM.useSound = "gmodz/primary_needs/soda.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end