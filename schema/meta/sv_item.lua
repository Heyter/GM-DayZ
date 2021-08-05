local ITEM = ix.meta.item

function ITEM:CombineStack(combineItem)
	if (!self.isStackable or !combineItem) then return end
	if (self.uniqueID != combineItem.uniqueID) then return end

	local maxQuantity = self.maxQuantity
	local quantity = self:GetData("quantity", 1)
	local combineQuantity = combineItem:GetData("quantity", 1)

	if (combineQuantity >= maxQuantity or quantity >= maxQuantity) then return end
	local totalQuantity = combineQuantity + quantity

	if (totalQuantity > maxQuantity) then
		self:SetData("quantity", maxQuantity, true)
		combineItem:SetData("quantity", totalQuantity - maxQuantity, true)
	else
		combineItem:Remove()
		self:SetData("quantity", totalQuantity, true)
	end

	maxQuantity, quantity, combineQuantity, totalQuantity = nil, nil, nil, nil
end

function ITEM:Transfer(invID, x, y, client, noReplication, isLogical)
	invID = invID or 0

	if (self.invID == invID) then
		return false, "same inv"
	end

	local inventory = ix.item.inventories[invID]
	local curInv = ix.item.inventories[self.invID or 0]

	if (curInv and !IsValid(client)) then
		client = curInv.GetOwner and curInv:GetOwner() or nil
	end

	-- check if this item doesn't belong to another one of this player's characters
	local itemPlayerID = self:GetPlayerID()
	local itemCharacterID = self:GetCharacterID()

	if (!self.bAllowMultiCharacterInteraction and IsValid(client) and client:GetCharacter()) then
		local playerID = client:SteamID64()
		local characterID = client:GetCharacter():GetID()

		if (itemPlayerID and itemCharacterID) then
			if (itemPlayerID == playerID and itemCharacterID != characterID) then
				return false, "itemOwned"
			end
		else
			self.characterID = characterID
			self.playerID = playerID

			local query = mysql:Update("ix_items")
				query:Update("character_id", characterID)
				query:Update("player_id", playerID)
				query:Where("item_id", self:GetID())
			query:Execute()
		end
	end

	if (hook.Run("CanTransferItem", self, curInv, inventory) == false) then
		return false, "notAllowed"
	end

	local authorized = false

	if (inventory and inventory.OnAuthorizeTransfer and inventory:OnAuthorizeTransfer(client, curInv, self)) then
		authorized = true
	end

	if (!authorized and self.CanTransfer and self:CanTransfer(curInv, inventory) == false) then
		return false, "notAllowed"
	end

	if (curInv) then
		if (invID and invID > 0 and inventory) then
			local targetInv = inventory
			local isTakeItem = (self.invID or 0) == 0 and self.isStackable -- при поднятие вещи с земли

			if (!self.isStackable) then
				local bagInv

				if (!x and !y) then
					x, y, bagInv = inventory:FindEmptySlot(self.width, self.height)
				end

				if (bagInv) then
					targetInv = bagInv
				end

				if (!x or !y) then
					return false, "noFit"
				end
			end

			local prevID = self.invID
			local status, result = targetInv:Add(self.id, nil, nil, x, y, noReplication)

			if (status) then
				if (self.invID > 0 and prevID != 0) then
					if (result == "stack") then
						curInv:Remove(self.id)
						--targetInv:Remove(self.id, nil, true, true) -- клиент не знает, что вещь была стакнута.
						-- сделал удаление вещи на клиенте :Move и :OnTransfer методы в инвентаре.
					else
						-- we are transferring this item from one inventory to another
						curInv:Remove(self.id, false, true, true)

						if (self.OnTransferred) then
							self:OnTransferred(curInv, inventory)
						end

						hook.Run("OnItemTransferred", self, curInv, inventory)
					end

					return true
				elseif ((isTakeItem or self.invID > 0) and prevID == 0) then
					-- we are transferring this item from the world to an inventory
					ix.item.inventories[0][self.id] = nil

					if (self.OnTransferred) then
						self:OnTransferred(curInv, inventory)
					end

					hook.Run("OnItemTransferred", self, curInv, inventory)

					return true
				end
			else
				return false, result
			end
		elseif (IsValid(client)) then
			-- we are transferring this item from an inventory to the world
			self.invID = 0
			curInv:Remove(self.id, false, true)

			local query = mysql:Update("ix_items")
				query:Update("inventory_id", 0)
				query:Where("item_id", self.id)
			query:Execute()

			inventory = ix.item.inventories[0]
			inventory[self:GetID()] = self

			if (self.OnTransferred) then
				self:OnTransferred(curInv, inventory)
			end

			hook.Run("OnItemTransferred", self, curInv, inventory)

			if (!isLogical) then
				return self:Spawn(client)
			end

			return true
		else
			return false, "noOwner"
		end
	else
		return false, "invalidInventory"
	end
end

util.AddNetworkString("ixPlayerDropItem")

function ITEM:PlayerDropItem(client)
	client = client or self.player
	if (!IsValid(client)) then return end

	net.Start("ixPlayerDropItem", true)
		net.WriteString(self:GetModel() or "models/props_junk/watermelon01.mdl")
	net.Send(client)

	-- local trace = client:GetEyeTraceNoCursor()
	-- local model = self:GetModel() or "models/props_junk/watermelon01.mdl"

	-- ix.util.SpawnProp(model, client:EyePos() + client:GetForward() * 2, trace.Normal * 200, 60)
	-- trace, model = nil, nil
end