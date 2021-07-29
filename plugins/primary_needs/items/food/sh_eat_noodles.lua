ITEM.name = "Noodles"
ITEM.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
ITEM.description = "."

ITEM.hungerAmount = 0.4
ITEM.thirstAmount = 0.2
ITEM.price = 65
ITEM.useSound = {"gmodz/items/food1.wav", "gmodz/items/food2.wav", "gmodz/items/food3.wav", "gmodz/items/food4.wav", "gmodz/items/food5.wav"}

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end