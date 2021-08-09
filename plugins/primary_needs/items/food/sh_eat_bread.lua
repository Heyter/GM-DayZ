ITEM.name = "Bread"
ITEM.model = "models/gmodz/food/bread.mdl"
ITEM.description = "A whole loaf of bread. It goes well with canned meat and butter pieces."

ITEM.hungerAmount = 0.25
ITEM.thirstAmount = -0.05
ITEM.price = 250
ITEM.useSound = "gmodz/items/food2.wav"

ITEM.rarity = { weight = 48 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end