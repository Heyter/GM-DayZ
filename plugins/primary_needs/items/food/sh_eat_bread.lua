ITEM.name = "Bread"
ITEM.model = "models/gmodz/food/bread.mdl"
ITEM.description = "A whole loaf of bread. It goes well with canned meat and butter pieces."

ITEM.hungerAmount = 0.15
ITEM.thirstAmount = -0.03
ITEM.healthAmount = 1
ITEM.price = 50
ITEM.useSound = "gmodz/items/food2.wav"
-- ITEM.useSound = {"gmodz/items/food1.wav", "gmodz/items/food2.wav", "gmodz/items/food3.wav", "gmodz/items/food4.wav", "gmodz/items/food5.wav"}

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end