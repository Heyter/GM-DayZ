ITEM.name = "Ghillie suit"
ITEM.desc = "A ghillie suit is a type of camouflage clothing designed to resemble the background environment such as foliage, snow or sand."
ITEM.model = "models/gmodz/characters/ghillie.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-64.41, 9.66, 58.43),
	ang = Angle(-5.74, 351.56, -0.03),
	fov = 20.07
}

ITEM.useDurability = nil
ITEM.replacement = "models/gmodz/characters/ghillie.mdl"
ITEM.noCollisionGroup = true

ITEM.price = 80000

ITEM.rarity = { weight = 5 }

ix.anim.SetModelClass(ITEM.replacement, "player")

function ITEM:OnGetDropModel(entity)
    return "models/Items/BoxMRounds.mdl"
end