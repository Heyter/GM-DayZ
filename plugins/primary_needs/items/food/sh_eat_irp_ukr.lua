ITEM.name = "Ukrainian IRP"
ITEM.model = "models/gmodz/food/irp_ukr.mdl"
ITEM.description = "A package with individual food ration."

ITEM.hungerAmount = 0.6
ITEM.thirstAmount = 0.3
ITEM.healthAmount = 10
ITEM.staminaAmount = 1
ITEM.staminaRegenTime = 60
ITEM.price = 850
ITEM.useSound = "gmodz/items/food5.wav"

ITEM.rarity = { weight = 10 }

if (SERVER) then
	ITEM.dropUsedItem = nil
end