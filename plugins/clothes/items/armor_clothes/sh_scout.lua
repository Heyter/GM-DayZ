ITEM.name = "Scout suit"
ITEM.desc = "The scout suit was built with the latest technology suitable for aggressive military action, mildly increasing ballistic protection while not greatly restricting mobility"
ITEM.model = "models/gmodz/characters/scout.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-60.07, 25.76, 59.97),
	ang = Angle(-3.79, 336.91, -0.08),
	fov = 19.01
}

ITEM.defDurability = 2000
ITEM.damageReduction = 0.3
ITEM.replacement = "models/gmodz/characters/scout.mdl"
ITEM.noCollisionGroup = true
ITEM.price = 120000

ITEM.rarity = { weight = 10 }

ITEM.speedModify = -25

ITEM.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

ix.anim.SetModelClass(ITEM.replacement, "player")

function ITEM:OnGetDropModel(entity)
    return "models/Items/BoxMRounds.mdl"
end