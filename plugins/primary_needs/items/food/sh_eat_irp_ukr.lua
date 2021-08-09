ITEM.name = "Ukrainian IRP"
ITEM.model = "models/gmodz/food/irp_ukr.mdl"
ITEM.description = "A package with individual food ration."

ITEM.hungerAmount = 0.8
ITEM.thirstAmount = 0.5
ITEM.healthAmount = 10
ITEM.staminaAmount = 0.2
ITEM.staminaRegenTime = 20
ITEM.price = 3500
ITEM.useSound = "gmodz/items/irp.wav"

ITEM.rarity = { weight = 40 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end