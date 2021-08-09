ITEM.name = "Orange"
ITEM.model = "models/props/cs_italy/orange.mdl"
ITEM.description = "A spherical orange fruit."

ITEM.hungerAmount = 0.15
ITEM.thirstAmount = 0.05
ITEM.price = 100
ITEM.useSound = "gmodz/items/food3.wav"

ITEM.rarity = { weight = 48 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end