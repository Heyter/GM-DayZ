ITEM.name = "Advanced set of tools"
ITEM.model = "models/props_lab/partsbin01.mdl"
ITEM.description = "A high end set of advanced tools for working on firearms. Uncommon in the Zone, only used by the best technicians."

ITEM.raiseDurability = 30

if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("This repairs %d%% of a weapon.", self.raiseDurability)
		return text
	end
end