ITEM.name = "Morphine injector"
ITEM.model = "models/gmodz/medical/morphine.mdl"
ITEM.description = "Single-use syringe full of morphine - powerful drug, used primarily to treat both acute and chronic severe pain."

ITEM.healthAmount = 5
ITEM.useSound = "gmodz/items/medical/inject_use.wav"

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("morphine")
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = Format("Relieves muscle pain (%d's)", ix.buff.list["morphine"].time)
		return text
	end
end

ITEM.rarity = { weight = 70 }