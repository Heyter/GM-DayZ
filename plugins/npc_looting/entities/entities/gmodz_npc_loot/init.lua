AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/gmodz/misc/backpack.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetUseType(SIMPLE_USE)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(true)
		physObj:Wake()
	end

	self:SetLifetime(CurTime() + ix.config.Get("npcBoxDecayTime", 60))
end

function ENT:Use(activator)
	local inventory = self:GetInventory()

	if (inventory /*and !ix.storage.InUse(inventory)*/) then
		ix.storage.Open(activator, inventory, {
			entity = self,
			name = "Loot",
			--searchTime = 0.5,
			data = {money = self:GetMoney()},
			bMultipleUsers = true,
			OnPlayerOpen = function()
				self:SetLifetime(CurTime() + 120)
			end
		})
	end
end

function ENT:Think()
	if (!self:IsInWorld()) then
		MsgC(Color("yellow"), "NPCBox - Removed, Outside Map!\n") 
		self:Remove()

		return
	end

	if (self:GetLifetime() < CurTime()) then
		self:Remove()
	end

	local inventory = self:GetInventory()

	if (inventory) then
		local bItems = table.IsEmpty(inventory:GetItems(true))
		local bMoney = self:GetMoney() < 1

		if (!bItems or !bMoney) then
			self:NextThink(CurTime() + 0.5)
			return true
		end

		self:Remove()
	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:OnRemove()
	local inventory = self:GetInventory()
	local query

	if (inventory/* and ix.entityDataLoaded*/) then
		if (inventory.GetReceivers) then
			ix.storage.Close(inventory)
		end

		if (inventory.GetItems) then
			for id, item in pairs(inventory:GetItems()) do
				if (item and item.isBag and item.OnRemoved) then
					item:OnRemoved()
				end

				query = mysql:Delete("ix_items")
					query:Where("item_id", id)
				query:Execute()

				ix.item.instances[id] = nil
			end
		end
	end

	local index = self:GetID()

	ix.item.inventories[index] = nil

	query = mysql:Delete("ix_items")
		query:Where("inventory_id", index)
	query:Execute()

	index = nil
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:SetMoney(amount)
	self.money = math.max(0, math.Round(tonumber(amount) or 0))
end

function ENT:GetMoney()
	return self.money or 0
end