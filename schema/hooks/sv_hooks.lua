local GM = GM or GAMEMODE

-- Restrict character name
function Schema:AdjustCreationPayload(client, payload, newPayload)
	newPayload.name = client:Name()
end

function Schema:PlayerSpray(client)
	return true
end

function Schema:PostPlayerLoadout(client)
	client:AllowFlashlight(true)
	client:SetJumpPower(ix.config.Get("jumpPower", 200))
	client:SetExtraHealth(nil)
end

function Schema:CanPlayerJoinClass(client, class, classData)
	return false
end

function Schema:CanPlayerAccessDoor(client, door, access)
	return true
end

function Schema:PlayerShouldTakeDamage(client, attacker)
	if (IsValid(attacker) and attacker:IsPlayer()) then
		if (attacker.protection_time and attacker.protection_time > CurTime()) then
			attacker.protection_time = nil -- снимаем защиту, если тот кого-то атаковал.
		elseif (attacker:GetLocalVar("protection")) then
			return false
		end
	end

	if (client:HasGodMode() or client:GetLocalVar("protection") or (client.protection_time or 0) > CurTime()) then
		return false
	end
end

local clear_ents = { ["ix_item"] = true, ["gmodz_grave"] = true, ["gmodz_npc_loot"] = true }
function Schema:ShutDown()
	-- save DB space, mate.
	for _, v in ipairs(ents.GetAll()) do
		if (clear_ents[v:GetClass()]) then
			v:Remove()
		end

		if (v:GetClass() == "prop_ragdoll" and v.ixInventory) then
			v:Remove()
		end
	end
end

-- Sandbox stuff
function Schema:PlayerSpawnProp(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnRagdoll(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnObject(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnNPC(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnEffect(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnSENT(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnSWEP(client)
	return client:IsSuperAdmin()
end

function Schema:PlayerSpawnVehicle(client)
	return client:IsSuperAdmin()
end

--[[ GAMEMODE ]]

function GM:PlayerDeath(client, inflictor, attacker)
	local character = client:GetCharacter()

	if (character) then
		if (IsValid(client.ixRagdoll)) then
			client.ixRagdoll.ixIgnoreDelete = true
			client:SetLocalVar("blur", nil)

			if (hook.Run("ShouldRemoveRagdollOnDeath", client) != false) then
				client.ixRagdoll:Remove()
			end
		end

		client.deathTime = CurTime() + ix.config.Get("spawnTime", 5)
		character:SetData("health", nil, true)

		local deathSound = hook.Run("GetPlayerDeathSound", client)

		if (deathSound != false) then
			deathSound = deathSound or deathSounds[math.random(1, #deathSounds)]

			if (client:IsFemale() and !deathSound:find("female")) then
				deathSound = deathSound:gsub("male", "female")
			end

			client:EmitSound(deathSound)
		end

		local weapon = attacker:IsPlayer() and attacker:GetActiveWeapon()

		ix.log.Add(client, "playerDeath",
			attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass(), IsValid(weapon) and weapon:GetClass())
	end
end

function GM:PlayerDeathThink(client)
	if (client:GetCharacter()) then
		if (client.deathTime and client.deathTime <= CurTime() and hook.Run("CanPlayerDeathThink", client) == true) then
			client:Spawn()
		end
	end

	return false
end

function GM:PlayerHurt(client, attacker, health, damage)
	if ((client.ixNextPain or 0) < CurTime() and health > 0) then
		local painSound = hook.Run("GetPlayerPainSound", client) or false --Schema:GetPainSound(client:IsFemale() and "female" or "male", client:LastHitGroup())

		if (painSound != false) then
			client:EmitSound(painSound)
		end

		client.ixNextPain = CurTime() + 0.33
	end

	ix.log.Add(client, "playerHurt", damage, attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass())
end

local chat_types = {
	["ic"] = true,
	["radio"] = true
}
function GM:PlayerSay(client, text)
--[[ 	if (teamChat and ix.chat.Send(client, "radio", text)) then
		return ""
	end ]]

	local chatType, message, anonymous = ix.chat.Parse(client, text, true)

	if (chatType == "ic") then
		if (ix.command.Parse(client, message)) then
			return ""
		end
	end

	text = ix.chat.Send(client, chatType, message, anonymous)

	if (isstring(text) and !chat_types[chatType]) then
		ix.log.Add(client, "chat", chatType and chatType:utf8upper() or "??", text)
	end

	hook.Run("PostPlayerSay", client, chatType, message, anonymous)
	return ""
end

function GM:DoPlayerDeath(client, attacker, damageinfo)
	client:AddDeaths(1)

	if (hook.Run("ShouldSpawnClientRagdoll", client) != false) then
		client:CreateRagdoll()
	end

	//client:SetAction("@respawning", ix.config.Get("spawnTime", 5))
	client:SetDSP(31)
end

--[[ GAMEMODE END ]]

function Schema:InitPostEntity()
    local physData = physenv.GetPerformanceSettings()
    physData.MaxVelocity = 2000
    physData.MaxAngularVelocity = 3636
    physenv.SetPerformanceSettings(physData)

    game.ConsoleCommand("sv_allowcslua 0\n")
    game.ConsoleCommand("physgun_DampingFactor 0.9\n")
    game.ConsoleCommand("sv_sticktoground 0\n")
    game.ConsoleCommand("sv_airaccelerate 1000\n")
    game.ConsoleCommand("sv_alltalk 0\n")

	local query = mysql:Delete("ix_items")
		query:Where("inventory_id", 0)
	query:Execute()
end

function Schema:EntityTakeDamage(entity, dmgInfo)
	if (!IsValid(entity) or dmgInfo:GetDamage() == 0) then return end

	if (entity:IsPlayer()) then
		if (hook.Run("PlayerShouldTakeDamage", entity, dmgInfo:GetAttacker()) == false) then return true end

		local extra_health = entity:ExtraHealth()

		if (extra_health > 0) then
			dmgInfo:SubtractDamage(extra_health)
			entity:AddExtraHealth(-extra_health)
		end

		hook.Run("PlayerTakeDamage", entity, dmgInfo)

		if (dmgInfo:GetDamage() <= 0.5) then return true end

		hook.Run("PostPlayerTakeDamage", entity, dmgInfo)
	end
end

function Schema:OnCharacterCreated(client, character)
	character:SetData("permament_model", character:GetModel(), true)
end

function Schema:PlayerDisconnected(client)
	timer.Remove(client:EntIndex() .. "_checkBounds_cycle")
end

--[[ function Schema:PlayerInteractItem(client, action)
	if (action == "drop") then
		client:ForceSequence("gesture_item_drop", nil) -- 0.41
	end
end ]]

-- Stack hooks
util.AddNetworkString("ixItemSplit")

net.Receive("ixItemSplit", function(_, client)
	if ((client.ixItemSplitTry or 0) < CurTime()) then
		client.ixItemSplitTry = CurTime() + 0.33
	else
		return
	end

	if (!client:GetCharacter() or !client:Alive()) then return end

	local item = ix.item.instances[net.ReadUInt(32)]
	if (!item or item.invID == 0 or !item.isStackable) then return end

	local inventory = ix.item.inventories[item.invID]
	if (!inventory) then return end

	local quantity = item:GetData("quantity", 1)
	if (quantity <= 1) then return end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, quantity)
	if (amount == 0 or amount == quantity) then return end

	if (inventory:Add(item.uniqueID, 1, {quantity = amount}, nil, nil, nil, true)) then
		amount = quantity - amount

		if (amount < 1) then
			item:Remove()
		else
			item:SetData("quantity", amount, true)
		end
	else
		client:NotifyLocalized("noFit")
	end
end)

-- function Schema.UpdateStackItem(character, item)
	-- local result

	-- if (character) then
		-- local items = character:GetInventory():GetItems(true)

		-- for _, v in pairs(items) do
			-- if (v.id != item.id and v.uniqueID == item.uniqueID and v:GetData("quantity", 1) < item.maxQuantity) then
				-- v:CombineStack(item)
				-- result = true
				-- break
			-- end
		-- end
	-- end

	-- return result
-- end

--function Schema:OnItemTransferred(item, oldInv, newInv)
--[[ 	if (item.maxQuantity) then
		--if (oldInv.owner and !newInv.owner) then -- Removing item from inventory.
		--elseif (!oldInv.owner and newInv.owner) then -- Adding item to inventory.
		if (!oldInv.owner and newInv.owner) then -- Adding item to inventory.
			Schema.UpdateStackItem(ix.char.loaded[newInv.owner], item)
		end
	end ]]
--end

--function Schema:InventoryItemAdded(oldInv, newInv, item)
--[[ 	if (item.maxQuantity) then
		if (!oldInv and newInv.owner) then -- When an item is directly created in their inventory.
			Schema.UpdateStackItem(ix.char.loaded[newInv.owner], item)
		end
	end ]]
--end

--function Schema:CanTransferItem(item, oldInv, newInv) -- When a player attempts to take an item out of a container.
	-- if (newInv.owner and item.maxQuantity and (oldInv and oldInv.owner != newInv.owner)) then
		-- if (Schema.UpdateStackItem(ix.char.loaded[newInv.owner], item)) then
			-- return false
		-- end
	-- end
--end

--[[ Storage take all items ]]
util.AddNetworkString("ixStorageTakeAll")

net.Receive("ixStorageTakeAll", function(_, client)
	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	if ((client.ixStorageTakeAll or 0) < CurTime()) then
		client.ixStorageTakeAll = CurTime() + 1
	else
		return
	end

	local storageID = net.ReadUInt(32)
	local inventory = client.ixOpenStorage

	if (!inventory or !inventory.storageInfo or storageID != inventory:GetID()) then
		return
	end

	local entity = inventory.storageInfo.entity

	if (!IsValid(entity) or
		(!entity:IsPlayer() and (!isfunction(entity.GetMoney) or !isfunction(entity.SetMoney))) or
		(entity:IsPlayer() and !entity:GetCharacter())) then
		return
	end

	entity = entity:IsPlayer() and entity:GetCharacter() or entity
	local amount = entity:GetMoney()

	if (amount > 0) then
		character:SetMoney(character:GetMoney() + amount)

		local total = entity:GetMoney() - amount
		entity:SetMoney(total)

		net.Start("ixStorageMoneyUpdate")
			net.WriteUInt(storageID, 32)
			net.WriteUInt(total, 32)
		net.Send(inventory:GetReceivers())

		ix.log.Add(client, "storageMoneyTake", entity, amount, total)
	end

	if (net.ReadBool()) then
		local charInventory = character:GetInventory()

		if (charInventory and charInventory:GetFilledSlotCount() < charInventory.w * charInventory.h) then
			local charInvID = charInventory:GetID()

			if (charInvID > 0) then
				for _, v in pairs(inventory:GetItems(true)) do
					if (!IsValid(client) or !client:Alive() or !client.ixOpenStorage or !client:GetCharacter()) then break end
					v:Transfer(charInvID, nil, nil, client)
				end
			end
		end
	end
end)