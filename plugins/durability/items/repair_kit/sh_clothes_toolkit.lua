ITEM.name = "Clothes set of tools"
ITEM.model = "models/props_lab/partsbin01.mdl"
ITEM.description = "Clothes set of tools."

ITEM.raiseDurability = 75
ITEM.isClothesKit = true
ITEM.isWeaponKit = nil

if (SERVER) then
	ITEM.rarity = { rare = true }
	ITEM.rate = 2
end

if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("This repairs %d%% of a clothes.", self.raiseDurability)
		return text
	end
end