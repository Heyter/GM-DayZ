ITEM.name = "Medkit"
ITEM.model = "models/gmodz/medical/medkit.mdl"
ITEM.description = "All-purpose single-use medkit. Allows to handle injuries of different types and degrees of complexity. The medkit heals ~35%% of your life and removes a chunk of bleeding and accumulated radiation."

ITEM.healthAmount = 20
ITEM.radiationAmount = -250
ITEM.price = 300

-- TODO sound
ITEM.useSound = nil

function ITEM:OnCanUse()
	if (self.player:Health() >= self.player:GetMaxHealth()) then
		return false
	end
end

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 25 }

	function ITEM:OnUse()
		self.player:HealBleeding()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		return text
	end
end