ITEM.name = "Rad-X"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "It is an anti-radiation chem to be taken before exposure (unlike RadAway, which removes the effects of radiation after a person gets irradiated)."

ITEM.radiationAmount = 0

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("radx")
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = Format("Radiation Resistance (%d's)", ix.buff.list["radx"].time)
		return text
	end
end