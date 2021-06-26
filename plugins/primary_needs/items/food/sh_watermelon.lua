ITEM.name = "Watermelon"
ITEM.model = "models/props_junk/watermelon01.mdl"
ITEM.description = "Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon"

ITEM.hungerAmount = 0.3 -- процент
ITEM.thirstAmount = 0.3 -- процент
ITEM.healthAmount = 0
ITEM.staminaAmount = -100

if (SERVER) then
	ITEM.rarity = { common = true }
end