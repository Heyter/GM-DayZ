ITEM.name = "RAD-X"
ITEM.model = "models/gmodz/medical/radioprotector.mdl"
ITEM.description = "Protects against radiation exposure."

ITEM.radiationAmount = -75
ITEM.price = 350

ITEM.useSound = "gmodz/items/syringe/use.mp3"

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("radx")
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = Format("Radiation Protection: 40%% (%d's)", ix.buff.list["radx"].time)

		return text
	end
end

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 70 }
end