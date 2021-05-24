ITEM.name = "Immobilizing splint"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "Common splint for fixing the damaged bones in position as an emergency aid measure."

ITEM.healthAmount = 5

if (SERVER) then
	function ITEM:OnUse()
		self.player:HealLeg()
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Heals legs"
		return text
	end
end