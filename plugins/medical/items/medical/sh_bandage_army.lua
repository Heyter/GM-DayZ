ITEM.name = "Military Bandage"
ITEM.model = "models/gmodz/medical/ipp_av3.mdl"
ITEM.description = ""

ITEM.healthAmount = 5
ITEM.useSound = "gmodz/items/medical/bandage_use.wav"

ITEM.rarity = { weight = 85 }

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealBleeding()
	end

	function ITEM:OnInstanced(index)
		if (index == 0) then
			self:SetData("quantity", 2, false)
		end
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		return text
	end
end