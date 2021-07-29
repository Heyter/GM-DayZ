ITEM.name = "Bandage"
ITEM.model = "models/gmodz/medical/bandage.mdl"
ITEM.description = "Small roll of gauze cloth."

ITEM.healthAmount = 5
ITEM.useSound = "gmodz/items/bandage.wav"

ITEM.rarity = { weight = 100 }

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealBleeding()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		return text
	end
end