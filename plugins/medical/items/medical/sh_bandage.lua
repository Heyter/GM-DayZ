ITEM.name = "Bandage"
ITEM.model = Model("models/props_wasteland/prison_toiletchunk01l.mdl")
ITEM.description = "Small roll of gauze cloth."

ITEM.healthAmount = 5

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealBleeding()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding"
		return text
	end
end