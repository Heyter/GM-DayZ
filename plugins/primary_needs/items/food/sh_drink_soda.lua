ITEM.name = "Blueberry Soda"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.description = "A blue can filled with some carbonated flavoured water."

ITEM.thirstAmount = 0.4
ITEM.price = 40
ITEM.useSound = "gmodz/primary_needs/soda.wav"

ITEM.iconCam = {
	pos = Vector(76.027618408203, 63.794639587402, 46.273990631104),
	ang = Angle(25, 220, 0),
	fov = 4.292031810357,
}

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end