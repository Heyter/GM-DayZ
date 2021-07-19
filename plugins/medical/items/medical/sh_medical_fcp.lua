ITEM.name = "FCP"
ITEM.model = "models/gmodz/medical/fcp.mdl"
ITEM.description = ""

-- TODO sound
ITEM.useSound = nil

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

if (SERVER) then
	ITEM.rarity = { common = true, weight = 80 }
end