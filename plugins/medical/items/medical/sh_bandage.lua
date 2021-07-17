ITEM.name = "Bandage"
ITEM.model = "models/gmodz/medical/bandage.mdl"
ITEM.description = "Small roll of gauze cloth."

ITEM.healthAmount = 5

-- TODO sound
ITEM.useSound = nil

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

if (SERVER) then
	ITEM.rarity = { common = true, weight = 100 }
end