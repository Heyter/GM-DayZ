ITEM.name = "Sausage"
ITEM.model = "models/gmodz/food/sausage.mdl"
ITEM.description = "Preserved and packaged roll of ground pork. A high protein meal that is tastier than bread."

ITEM.hungerAmount = 0.3
ITEM.thirstAmount = -0.05
ITEM.price = 300
ITEM.useSound = "gmodz/items/food4.wav"

ITEM.rarity = { weight = 48 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end