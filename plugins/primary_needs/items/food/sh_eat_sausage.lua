ITEM.name = "Sausage"
ITEM.model = "models/gmodz/food/sausage.mdl"
ITEM.description = "Preserved and packaged roll of ground pork. A high protein meal that is tastier than bread."

ITEM.hungerAmount = 0.2
ITEM.healthAmount = 1
ITEM.price = 70
ITEM.useSound = "gmodz/primary_needs/eating.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
	ITEM.dropUsedItem = nil
end