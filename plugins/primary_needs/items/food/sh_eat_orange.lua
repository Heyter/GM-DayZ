ITEM.name = "Orange"
ITEM.model = "models/props/cs_italy/orange.mdl"
ITEM.description = "A spherical orange fruit."

ITEM.hungerAmount = 0.15
ITEM.thirstAmount = 0.02
ITEM.healthAmount = 1
ITEM.price = 65
ITEM.useSound = "gmodz/primary_needs/eating.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
	ITEM.dropUsedItem = nil
end