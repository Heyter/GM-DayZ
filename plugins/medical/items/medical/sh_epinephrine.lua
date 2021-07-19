ITEM.name = "Epinephrine"
ITEM.model = "models/gmodz/medical/epinephrine.mdl"
ITEM.description = "epinephrine"

ITEM.price = 500
ITEM.useSound = "gmodz/items/syringe/use2.wav"

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("epinephrine")
	end

	ITEM.rarity = { rare = true, weight = 40 }
else
	function ITEM:ExtendDesc(text)
		local buff = ix.buff.list["epinephrine"]

		if (buff) then
			text[#text+1] = Format("Decreases receiving damage at %d%%", buff.damageReduction * 100)
		end

		return text
	end
end