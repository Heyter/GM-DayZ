ITEM.name = "Ration Ukraine"
ITEM.model = "models/gmodz/food/irp_ukr.mdl"
ITEM.description = "A package with individual food ration. Made in Ukraine."

ITEM.hungerAmount = 0.9
ITEM.thirstAmount = 0.3
ITEM.healthAmount = 10
ITEM.staminaAmount = 1
ITEM.staminaRegenTime = 60
ITEM.price = 850
ITEM.useSound = "gmodz/primary_needs/irp_eat.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 15 }
end