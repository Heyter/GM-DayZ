ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.Category = "DayZ"
ENT.PrintName = "Grave"
ENT.Author = "STEAM_0:1:29606990"
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StoredName")
	self:NetworkVar("String", 1, "StoredID")

	self:NetworkVar("Int", 0, "Lifetime")
	self:NetworkVar("Int", 1, "ID")
	self:NetworkVar("Int", 2, "Reputation")
end

function ENT:GetInventory()
	return ix.item.inventories[self:GetID()]
end