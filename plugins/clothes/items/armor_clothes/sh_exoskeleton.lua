ITEM.name = "Exoskeleton"
ITEM.desc = ""
ITEM.model = "models/gmodz/characters/exoskeleton.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(-59.44, 26.67, 57.97),
	ang = Angle(-4.25, 335.31, 0),
	fov = 18.67
}

ITEM.defDurability = 5000
ITEM.damageReduction = 0.5
ITEM.replacement = "models/gmodz/characters/exoskeleton.mdl"
ITEM.noCollisionGroup = true
ITEM.price = 50000

ITEM.speedModify = 25

ITEM.disableSprint = true

ITEM.rarity = { weight = 10 }

ix.anim.SetModelClass(ITEM.replacement, "player")

function ITEM:OnGetDropModel(entity)
    return "models/Items/BoxMRounds.mdl"
end