ITEM.name = "Antirad"
ITEM.model = "models/gmodz/medical/antirad.mdl"
ITEM.description = "Antirad is a packet of anti-radiation drugs that neutralize radiation accumulated in the body."

ITEM.radiationAmount = -300
ITEM.price = 200

ITEM.useSound = "gmodz/items/antirad/use.wav"

function ITEM:OnCanUse()
	if (self.player:GetRadiationTotal() <= 0) then
		return false
	end
end

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 70 }
end