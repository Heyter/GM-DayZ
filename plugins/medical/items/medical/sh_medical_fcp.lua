ITEM.name = "FCP"
ITEM.model = "models/gmodz/medical/fcp.mdl"
ITEM.description = ""
ITEM.useSound = "gmodz/items/medical/pills_use.wav"

function ITEM:OnCanUse()
	return self.player:IsBrokenLeg() or self.player:GetNetVar("bleeding", false)
end

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealLeg()
		self.player:HealBleeding()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Treats a fracture"
		text[#text+1] = "Stops bleeding"
		return text
	end
end

ITEM.rarity = { weight = 80 }