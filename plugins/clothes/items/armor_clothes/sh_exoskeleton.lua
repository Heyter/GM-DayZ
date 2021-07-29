ITEM.name = "Exoskeleton"
ITEM.desc = ""
ITEM.model = "models/Items/BoxMRounds.mdl"

ITEM.defDurability = 5000
ITEM.damageReduction = 0.65 -- резист всего тела на 45%
ITEM.replacement = "models/gmodz/characters/exoskeleton.mdl"
ITEM.noCollisionGroup = true

ITEM.rarity = { weight = 2 }

ix.anim.SetModelClass(ITEM.replacement, "player")