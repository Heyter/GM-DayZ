ITEM.name = "Hotcan military"
ITEM.model = "models/gmodz/food/hotcan_military.mdl"
ITEM.description = "Classic small Lincolnshire sausages with Heinz baked beans in a rich tomato sauce"

ITEM.hungerAmount = 0.23
ITEM.thirstAmount = 0.05
ITEM.healthAmount = 5
ITEM.price = 110
ITEM.useSound = "gmodz/primary_needs/eating_long.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 95 }
end