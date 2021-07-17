ITEM.name = "Banana"
ITEM.model = "models/props/cs_italy/bananna.mdl"
ITEM.description = "A curved yellow fruit."

ITEM.hungerAmount = 0.17
ITEM.healthAmount = 1
ITEM.price = 65
ITEM.useSound = "gmodz/primary_needs/eating.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
	ITEM.dropUsedItem = nil
end