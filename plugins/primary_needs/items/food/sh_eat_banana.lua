ITEM.name = "Banana"
ITEM.model = "models/props/cs_italy/bananna.mdl"
ITEM.description = "A curved yellow fruit."

ITEM.hungerAmount = 0.17
ITEM.healthAmount = 1
ITEM.price = 65
ITEM.useSound = "gmodz/items/food1.wav"
-- ITEM.useSound = {"gmodz/items/food1.wav", "gmodz/items/food2.wav", "gmodz/items/food3.wav", "gmodz/items/food4.wav", "gmodz/items/food5.wav"}

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end