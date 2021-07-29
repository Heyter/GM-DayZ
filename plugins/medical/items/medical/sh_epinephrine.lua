ITEM.name = "Epinephrine"
ITEM.model = "models/gmodz/medical/epinephrine.mdl"
ITEM.description = "epinephrine"

ITEM.price = 500

ITEM.healthAmount = 5
ITEM.useSound = "gmodz/items/syringe.wav"

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

ITEM.rarity = { weight = 40 }