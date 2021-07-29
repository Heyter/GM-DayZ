ITEM.name = "Scout suit"
ITEM.desc = ""
ITEM.model = "models/Items/BoxMRounds.mdl"

ITEM.defDurability = 5000
ITEM.damageReduction = 0.45 -- резист всего тела на 45%
ITEM.replacement = "models/gmodz/characters/scout.mdl"
ITEM.noCollisionGroup = true

ITEM.rarity = { weight = 3 }

ix.anim.SetModelClass(ITEM.replacement, "player")