ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.Category = "GmodZ"
ENT.PrintName = "NPC Box"
ENT.Author = "STEAM_0:1:29606990"
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Lifetime")
	self:NetworkVar("Int", 1, "ID")
end

function ENT:GetInventory()
	return ix.item.inventories[self:GetID()]
end