ITEM.name = "Medkit"
ITEM.model = "models/gmodz/medical/medkit.mdl"
ITEM.description = "All-purpose single-use medkit. Allows to handle injuries of different types and degrees of complexity. The medkit heals ~35%% of your life and removes a chunk of bleeding and accumulated radiation."

ITEM.healthAmount = 20
ITEM.price = 2000
ITEM.useSound = "gmodz/items/medkit.wav"

ITEM.rarity = { weight = 43 }

function ITEM:OnCanUse()
	if (self.player:Health() >= self.player:GetMaxHealth()) then
		return false
	end
end
