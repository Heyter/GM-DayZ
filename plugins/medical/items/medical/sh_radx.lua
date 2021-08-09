ITEM.name = "RAD-X"
ITEM.model = "models/gmodz/medical/radioprotector.mdl"
ITEM.description = "Protects against radiation exposure."

ITEM.radiationAmount = -75
ITEM.price = 2500
ITEM.useSound = "gmodz/items/antirad.wav"

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

ITEM.rarity = { weight = 33 }