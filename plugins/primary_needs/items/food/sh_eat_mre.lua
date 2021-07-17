ITEM.name = "MRE"
ITEM.model = "models/gmodz/food/mre.mdl"
ITEM.description = "A small box, it has 'Meal Ready to Eat' written on it. It contains a freeze dried meal."

ITEM.hungerAmount = 1
ITEM.thirstAmount = -0.17
ITEM.healthAmount = 5
ITEM.price = 600
ITEM.useSound = "gmodz/primary_needs/irp_eat.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 25 }
end