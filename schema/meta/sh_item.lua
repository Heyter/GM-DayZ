local ITEM = ix.meta.item

--- Sets a key within the item's data.
-- @realm shared
-- @string key The key to store the value within
-- @param[opt=nil] value The value to store within the key
-- @tab[opt=nil] receivers The players to replicate the data on
-- @bool[opt=false] noSave Whether to disable saving the data on the database or not
-- @bool[opt=false] noCheckEntity Whether to disable setting the data on the entity, if applicable
function ITEM:SetData(key, value, receivers, noSave, noCheckEntity)
	self.data = self.data or {}
	self.data[key] = value

	if (SERVER) then
		if (!noCheckEntity) then
			local ent = self:GetEntity()

			if (IsValid(ent)) then
				local data = ent:GetNetVar("data", {})
				data[key] = value

				ent:SetNetVar("data", data)
			end
		end

		if (receivers != false and (receivers or self:GetOwner())) then
			net.Start("ixInventoryData")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString(key)
				net.WriteType(value)
			net.Send(receivers or self:GetOwner())
		end

		if (!noSave and ix.db) then
			local query = mysql:Update("ix_items")
				query:Update("data", util.TableToJSON(self.data))
				query:Where("item_id", self:GetID())
			query:Execute()
		end
	end
end

function ITEM:UseStackItem(bMaxQuantity, callback)
	local quantity = self:GetData("quantity", 1)
	local newQuantity = quantity - (bMaxQuantity and quantity or 1)

	if (bMaxQuantity) then
		if (callback) then
			newQuantity, quantity = callback(newQuantity, quantity)
		end
	else
		quantity = 1
	end

	if (newQuantity < 1) then
		return true, quantity
	end

	self:SetData("quantity", newQuantity)

	return false, quantity
end

if (CLIENT) then
	net.Receive("ixPlayerDropItem", function()
		local entity = ents.CreateClientProp(net.ReadString())
		entity:Spawn()
		entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		entity:SetAngles(angle_zero)
		entity:SetPos(LocalPlayer():EyePos() + LocalPlayer():GetForward() * 2)

		local phys = entity:GetPhysicsObject()
		if (IsValid(phys)) then
			phys:ApplyForceCenter(LocalPlayer():GetEyeTraceNoCursor().Normal * 200)
		end

		SafeRemoveEntityDelayed(entity, math.random(10, 60))
	end)
end