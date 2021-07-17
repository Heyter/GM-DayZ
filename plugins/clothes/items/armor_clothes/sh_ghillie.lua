ITEM.name = "Ghillie suit"
ITEM.desc = "A ghillie suit, also known as a yowie suit, or camo tent, is a type of camouflage clothing designed to resemble heavy foliage."
ITEM.model = "models/props/cs_militia/footlocker01_closed.mdl"

ITEM.defDurability = 5000
ITEM.damageReduction = 0.05 -- резист всего тела на 5%
ITEM.replacement = "models/gmodz/characters/ghillie.mdl"
ITEM.noCollisionGroup = true

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 3 }

	function ITEM:OnInstanced(index)
		if (index == 0) then
			self:SetData("durability", self.defDurability * math.Rand(0.5, 0.75), false)
		end
	end
end

ix.anim.SetModelClass(ITEM.replacement, "player")