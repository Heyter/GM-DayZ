ITEM.name = "Scientific medkit"
ITEM.model = "models/gmodz/medical/medkit_science.mdl"
ITEM.description = "They heal significantly more health than other medkits, and also automatically remove radiation poisoning completely. However, unlike Military kits, they are not as effective in stopping blood loss."

ITEM.healthAmount = 80
ITEM.radiationAmount = -250
ITEM.price = 15000
ITEM.useSound = "gmodz/items/medkit.wav"

ITEM.rarity = { weight = 25 }

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealBleeding()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		text[#text+1] = "Treats a fracture"
		return text
	end
end