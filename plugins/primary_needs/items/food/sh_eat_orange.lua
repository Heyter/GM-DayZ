ITEM.name = "Orange"
ITEM.model = "models/props/cs_italy/orange.mdl"
ITEM.description = "A spherical orange fruit."

ITEM.hungerAmount = 0.15
ITEM.thirstAmount = 0.02
ITEM.healthAmount = 1
ITEM.price = 65
ITEM.useSound = "gmodz/items/food/eating.wav"

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end