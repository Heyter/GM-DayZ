AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)

	self.items = {}
	self.receivers = {}
	--self.itemsTotal = 0

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
		end
	end)
end

local PLUGIN = PLUGIN

function ENT:SpawnFunction(client, trace)
	local angles = (trace.HitPos - client:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local entity = ents.Create("gmodz_merchant")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(angles)
	entity:Spawn()

	PLUGIN:SaveData()

	return entity
end

function ENT:Use(activator)
	local character = activator:GetCharacter()

	if (!character) then
		return
	end

	character:GetInventory():HalfSync(activator)

	self.receivers[#self.receivers + 1] = activator
	activator.ixMerchant = self

	net.Start("ixMerchantOpen")
		net.WriteEntity(self)
		net.WriteTable(self.items)
	net.Send(activator)
end

function ENT:SyncItems(id, data, isSelling)
	net.Start("ixMerchantSync")
		net.WriteUInt(id, 32)
		net.WriteBool(isSelling)
		net.WriteTable(data or {})
	net.Send(self.receivers)
end

function ENT:RemoveReceiver(client)
	for k, v in ipairs(self.receivers) do
		if (v == client) then
			table.remove(self.receivers, k)

			break
		end
	end

	client.ixMerchant = nil
end