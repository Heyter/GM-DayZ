ITEM.name = "Morphine injector"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "Single-use syringe full of morphine - powerful drug, used primarily to treat both acute and chronic severe pain."

ITEM.healthAmount = 5

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

if (SERVER) then
	ITEM.rarity = { common = true, weight = 30 }
	ITEM.rate = 5
end