ITEM.name = "Banana"
ITEM.model = "models/props/cs_italy/bananna.mdl"
ITEM.description = "A curved yellow fruit."

ITEM.hungerAmount = 0.17
ITEM.healthAmount = 1
ITEM.price = 65
ITEM.useSound = "gmodz/items/food/eating.wav"

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end