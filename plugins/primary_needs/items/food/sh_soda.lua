ITEM.name = "Soda"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.description = "A blue can filled with some carbonated flavoured water."

ITEM.hungerAmount = 0.3 -- процент
ITEM.thirstAmount = 0.3 -- процент
ITEM.healthAmount = 0
ITEM.staminaAmount = 100

ITEM.useSound = "gmodz/primary_needs/drinking.wav"

ITEM.iconCam = {
	pos = Vector(76.027618408203, 63.794639587402, 46.273990631104),
	ang = Angle(25, 220, 0),
	fov = 4.292031810357,
}

if (SERVER) then
	ITEM.rarity = { common = true }
	ITEM.rate = 13
end