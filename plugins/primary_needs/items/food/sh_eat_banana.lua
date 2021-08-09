ITEM.name = "Banana"
ITEM.model = "models/props/cs_italy/bananna.mdl"
ITEM.description = "A curved yellow fruit."

ITEM.hungerAmount = 0.15
ITEM.price = 100
ITEM.useSound = "gmodz/items/food1.wav"

ITEM.rarity = { weight = 48 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end