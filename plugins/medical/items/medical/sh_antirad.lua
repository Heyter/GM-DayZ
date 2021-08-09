ITEM.name = "Antirad"
ITEM.model = "models/gmodz/medical/antidot.mdl"
ITEM.description = "Antirad is a packet of anti-radiation drugs that neutralize radiation accumulated in the body."

ITEM.radiationAmount = -300
ITEM.price = 500

ITEM.useSound = "gmodz/items/antirad.wav"

ITEM.rarity = { weight = 45 }

function ITEM:OnCanUse()
	if (self.player:GetRadiationTotal() <= 0) then
		return false
	end
end