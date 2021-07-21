ITEM.name = "Splint"
ITEM.model = "models/carlsmei/escapefromtarkov/medical/alusplint.mdl"
ITEM.description = "A splint is a rigid or flexible device that maintains in position a displaced or movable part, also used to keep in place and protect an injured part to support healing and to prevent further damage."

-- TODO sound
ITEM.useSound = nil

function ITEM:OnCanUse()
	return self.player:IsBrokenLeg()
end

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Treats a fracture"
		return text
	end
end

ITEM.rarity = { weight = 100 }