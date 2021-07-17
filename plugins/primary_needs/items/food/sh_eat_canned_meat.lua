ITEM.name = "Canned meat"
ITEM.model = "models/gmodz/food/canned_meat.mdl"
ITEM.description = "Canned food, the label has long been ripped off, but judging by the consistency, there is meat inside."

ITEM.hungerAmount = 0.3
ITEM.thirstAmount = 0.05
ITEM.healthAmount = 7
ITEM.price = 125
ITEM.useSound = "gmodz/primary_needs/eating_long.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 90 }
end