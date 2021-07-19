ITEM.name = "Condensed milk"
ITEM.model = "models/gmodz/food/condensed_milk.mdl"
ITEM.description = "Condensed milk is cow's milk from which water has been removed (roughly 60%% of it)."

ITEM.hungerAmount = 0.4
ITEM.thirstAmount = -0.06
ITEM.staminaAmount = 0.45
ITEM.staminaRegenTime = 15
ITEM.price = 120
ITEM.useSound = "gmodz/primary_needs/eating_long.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 90 }
end