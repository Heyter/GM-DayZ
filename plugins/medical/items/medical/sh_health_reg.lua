ITEM.name = "Health Reg"
ITEM.model = "models/gmodz/medical/health_reg.mdl"
ITEM.description = ""

ITEM.price = 450

-- TODO sound
ITEM.useSound = nil

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 15 }

	function ITEM:OnUse()
		self.player:AddBuff("health_reg")
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Restores 50 health over time"
		return text
	end
end