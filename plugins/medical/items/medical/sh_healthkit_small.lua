ITEM.name = "Health Pack"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "A small cloth bag, filled with a variety of different medical supplies. They need time to fully coagulate."

ITEM.healthAmount = 35

function ITEM:OnCanUse()
	if (self.player:Health() >= self.player:GetMaxHealth()) then
		return false
	end
end

if (SERVER) then
	ITEM.rarity = { common = true }
end