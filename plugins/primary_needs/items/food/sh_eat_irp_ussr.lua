ITEM.name = "Russian IRP"
ITEM.model = "models/gmodz/food/irp_b.mdl"
ITEM.description = "A package with individual food ration."

ITEM.hungerAmount = 0.7
ITEM.thirstAmount = 0.4
ITEM.healthAmount = 15
ITEM.staminaAmount = 1
ITEM.staminaRegenTime = 50
ITEM.price = 1000
ITEM.useSound = "gmodz/primary_needs/irp_eat.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 8 }
end