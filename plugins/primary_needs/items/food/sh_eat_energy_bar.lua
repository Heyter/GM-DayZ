ITEM.name = "Energy bar"
ITEM.model = "models/gmodz/food/energy_bar.mdl"
ITEM.description = "Energy bars are supplemental bars containing cereals and other high energy foods targeted at people who require quick energy but do not have time for a meal."

ITEM.hungerAmount = 0.3
ITEM.staminaAmount = 0.5
ITEM.staminaRegenTime = 12
ITEM.price = 90
ITEM.useSound = "gmodz/primary_needs/crunchy.wav"

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end