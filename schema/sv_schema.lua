local GM = GM or GAMEMODE

local entityMeta = FindMetaTable("Entity")

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

local ixItemENT = scripted_ents.GetStored("ix_item").t

function ixItemENT:SetItem(itemID)
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

		if (!itemTable.noCollisionGroup) then
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		end

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

function ixItemENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.health = 50

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(true)
		physObj:Wake()
	end
end

function ixItemENT:Use(activator, caller)
	local itemTable = self:GetItemTable()

	if (IsValid(caller) and caller:IsPlayer() and caller:GetCharacter() and itemTable) then
		itemTable.player = caller
		itemTable.entity = self

		if (itemTable.functions.take.OnCanRun(itemTable)) then
			caller:PerformInteraction(ix.config.Get("itemPickupTime", 0.5), self, function(client)
				if (!ix.item.PerformInventoryAction(client, "take", self)) then
					return false -- do not mark dirty if interaction fails
				else
					client:ForceSequence("pickup", function()
						client:EmitSound("items/itempickup.wav")
					end, 1)
				end
			end)
		end

		itemTable.player = nil
		itemTable.entity = nil
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