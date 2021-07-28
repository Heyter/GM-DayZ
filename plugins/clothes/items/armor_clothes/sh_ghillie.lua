ITEM.name = "Ghillie suit"
ITEM.desc = "A ghillie suit, also known as a yowie suit, or camo tent, is a type of camouflage clothing designed to resemble heavy foliage."
ITEM.model = "models/props/cs_militia/footlocker01_closed.mdl"

ITEM.useDurability = nil
ITEM.defDurability = 5000
ITEM.damageReduction = 0.05 -- резист всего тела на 5%
ITEM.replacement = "models/gmodz/characters/ghillie.mdl"
ITEM.noCollisionGroup = true

ITEM.rarity = { weight = 3 }

ix.anim.SetModelClass(ITEM.replacement, "player")