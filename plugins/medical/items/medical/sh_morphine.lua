ITEM.name = "Morphine injector"
ITEM.model = "models/gmodz/medical/morphine.mdl"
ITEM.description = "Single-use syringe full of morphine - powerful drug, used primarily to treat both acute and chronic severe pain."

ITEM.useSound = "gmodz/items/syringe.wav"

ITEM.price = 6000

function ITEM:OnCanUse()
	return self.player:IsBrokenLeg()
end

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Treats a fracture"
		return text
	end
end

ITEM.rarity = { weight = 30 }