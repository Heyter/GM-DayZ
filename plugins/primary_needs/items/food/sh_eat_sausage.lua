ITEM.name = "Sausage"
ITEM.model = "models/gmodz/food/sausage.mdl"
ITEM.description = "Preserved and packaged roll of ground pork. A high protein meal that is tastier than bread."

ITEM.hungerAmount = 0.2
ITEM.healthAmount = 1
ITEM.price = 70
ITEM.useSound = {"gmodz/items/food1.wav", "gmodz/items/food2.wav", "gmodz/items/food3.wav", "gmodz/items/food4.wav", "gmodz/items/food5.wav"}

ITEM.rarity = { weight = 100 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end