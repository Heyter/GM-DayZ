ITEM.name = "Army medkit"
ITEM.model = "models/gmodz/medical/medkit_army.mdl"
ITEM.description = "Includes medicine for faster blood coagulation, as well as painkillers, antibiotics, immunity stimulators, and more."

ITEM.healthAmount = 100
ITEM.price = 650

-- TODO sound
ITEM.useSound = nil

function ITEM:OnCanUse()
	if (self.player:Health() >= self.player:GetMaxHealth()) then
		return false
	end
end

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 10 }

	function ITEM:OnUse()
		self.player:HealBleeding()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		text[#text+1] = "Heals fracture"
		return text
	end
end