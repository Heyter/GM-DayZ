ITEM.name = "RadAway"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "RadAway is an intravenous chemical solution that bonds with radioactive particles and removes them from the user's system. While Rad-X is designed to increase the body's natural resistance to radiation, RadAway is designed to be used after exposure."

ITEM.radiationAmount = -200

function ITEM:OnCanUse()
	if (self.player:GetRadiationTotal() < 1) then
		return false
	end
end

if (SERVER) then
	ITEM.rarity = { common = true }
end