ITEM.name = "Hercules"
ITEM.model = "models/gmodz/medical/hercules.mdl"
ITEM.description = ""

ITEM.price = 1000
ITEM.staminaAmount = 0.5
ITEM.staminaRegenTime = 60

-- TODO sound
ITEM.useSound = "gmodz/primary_needs/drinking.wav"

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 45 }
end