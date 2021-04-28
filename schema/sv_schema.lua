local GM = GM or GAMEMODE

local entityMeta = FindMetaTable("Entity")
local playerMeta = FindMetaTable("Player")

--- Clears all of the networked variables.
-- @realm server
-- @internal
-- @tab[opt=nil] receiver The players to clear the networked variable for
function entityMeta:ClearNetVars(receiver)
	if (table.IsEmpty(ix.net.list) and table.IsEmpty(ix.net.locals)) then
		return
	end

	ix.net.list[self] = nil
	ix.net.locals[self] = nil

	net.Start("ixNetVarDelete")
	net.WriteUInt(self:EntIndex(), 16)

	if (receiver == nil) then
		net.Broadcast()
	else
		net.Send(receiver)
	end
end

-- ix_item
local invalidBoundsMin = Vector(-8, -8, -8)
local invalidBoundsMax = Vector(8, 8, 8)

local ENT = scripted_ents.GetStored("ix_item").t

function ENT:SetItem(itemID)
	local itemTable = ix.item.instances[itemID]

	if (itemTable) then
		local material = itemTable:GetMaterial(self)
		local model = itemTable.OnGetDropModel and itemTable:OnGetDropModel(self) or itemTable:GetModel()

		self:SetSkin(itemTable:GetSkin())
		self:SetModel(model)

		if (material) then
			self:SetMaterial(material)
		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetItemID(itemTable.uniqueID)
		self.ixItemID = itemID

		if (!table.IsEmpty(itemTable.data)) then
			self:SetNetVar("data", itemTable.data)
		end

		local physObj = self:GetPhysicsObject()

		if (!IsValid(physObj)) then
			self:PhysicsInitBox(invalidBoundsMin, invalidBoundsMax)
			self:SetCollisionBounds(invalidBoundsMin, invalidBoundsMax)
		end

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		if (itemTable.OnEntityCreated) then
			itemTable:OnEntityCreated(self)
		end
	end
end

function playerMeta:RemoveEquippableItem(item)
	if (item.Unequip) then
		item:Unequip(self)
	elseif (item.RemoveOutfit) then
		item:RemoveOutfit(self)
	elseif (item.RemovePart) then
		item:RemovePart(self)
	end
end

-- A function to return an entity's collision group.
function playerMeta:ReturnCollisionGroup(collisionGroup)
	if (!collisionGroup) then return end

	if (IsValid(self)) then
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			if (!physicsObject:IsPenetrating()) then
				self:SetCollisionGroup(collisionGroup)
			else
				timer.Create("CollisionGroup" .. self:EntIndex(), 1, 1, function()
					self:ReturnCollisionGroup(collisionGroup)
				end)
			end
		end
	end
end

function GM:DoPlayerDeath(client, attacker, damageinfo)
	client:AddDeaths(1)

	if (hook.Run("ShouldSpawnClientRagdoll", client) != false) then
		client:CreateRagdoll()
	end

	client:SetAction("@respawning", ix.config.Get("spawnTime", 5))
	client:SetDSP(31)
end