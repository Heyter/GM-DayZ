ITEM.name = "Watermelon"
ITEM.model = "models/props_junk/watermelon01.mdl"
ITEM.description = "Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon Watermelon"

ITEM.hungerAmount = 0.2 -- процент
ITEM.thirstAmount = 0.6 -- процент

if (SERVER) then
	ITEM.rarity = { common = true }
	ITEM.rate = 12
end