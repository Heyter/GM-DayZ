ITEM.name = "Army medkit"
ITEM.model = "models/gmodz/medical/medkit_army.mdl"
ITEM.description = "Includes medicine for faster blood coagulation, as well as painkillers, antibiotics, immunity stimulators, and more."

ITEM.healthAmount = 40
ITEM.price = 5500
ITEM.useSound = "gmodz/items/medkit.wav"

ITEM.rarity = { weight = 30 }

function ITEM:OnCanUse()
	if (self.player:Health() >= self.player:GetMaxHealth()) then
		return false
	end
end

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