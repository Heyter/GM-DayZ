ITEM.name = "First Aid"
ITEM.model = "models/gmodz/medical/first_aid.mdl"
ITEM.description = ""

ITEM.healthAmount = 30
ITEM.radiationAmount = -200
ITEM.price = 500

-- TODO sound
ITEM.useSound = nil

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 10 }

	function ITEM:OnUse()
		self.player:HealLeg()
		self.player:HealBleeding()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Treats a fracture"
		text[#text+1] = "Stops bleeding"
		return text
	end
end