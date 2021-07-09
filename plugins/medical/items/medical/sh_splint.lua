ITEM.name = "Splint"
ITEM.model = Model("models/props_c17/furnituredrawer001a_shard01.mdl")
ITEM.description = "A splint is a rigid or flexible device that maintains in position a displaced or movable part, also used to keep in place and protect an injured part to support healing and to prevent further damage."

ITEM.healthAmount = 5

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Heals fracture"
		return text
	end
end

if (SERVER) then
	ITEM.rarity = { common = true, weight = 80 }
	ITEM.rate = 7
end