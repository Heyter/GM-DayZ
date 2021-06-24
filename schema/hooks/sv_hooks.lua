local GM = GM or GAMEMODE

-- Restrict character name
function Schema:AdjustCreationPayload(client, payload, newPayload)
	newPayload.name = client:Name()
end

function Schema:PlayerSpray(client)
	return true
end

function Schema:PostPlayerLoadout(client, reload)
	client:AllowFlashlight(true)
	client:SetJumpPower(ix.config.Get("jumpPower", 200))
end

function Schema:CanPlayerJoinClass(client, class, classData)
	return false
end

function Schema:CanPlayerAccessDoor(client, door, access)
	return true
end

function Schema:PlayerShouldTakeDamage(client, attacker)
	if (IsValid(attacker) and attacker:IsPlayer()) then
		if (attacker.protection_time or 0) > CurTime() then
			attacker.protection_time = nil -- снимаем защиту, если тот кого-то атаковал.
		elseif (attacker:GetLocalVar("protection")) then
			return false
		end
	end

	if (client:GetLocalVar("protection") or (client.protection_time or 0) > CurTime()) then
		return false
	end
end

function Schema:ShutDown()
	-- save DB space, mate.
	for _, v in ipairs(ents.GetAll()) do
		if (v:GetClass() == "ix_item" or v:GetClass() == "gmodz_grave" or v:GetClass() == "gmodz_npc_loot") then
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

function GM:PlayerSay(client, text, teamChat)
	if (teamChat and text:find("%S")) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]

		if (squad) then
			local receivers = squad:GetReceivers()

			if (#receivers > 0) then
				ix.chat.Send(client, "radio", text, nil, receivers)
				return ""
			end
		end
	end

	local chatType, message, anonymous = ix.chat.Parse(client, text, true)

	if (chatType == "ic") then
		if (ix.command.Parse(client, message)) then
			return ""
		end
	end

	text = ix.chat.Send(client, chatType, message, anonymous)

	if (isstring(text) and chatType != "ic") then
		ix.log.Add(client, "chat", chatType and chatType:utf8upper() or "??", text)
	end

	hook.Run("PostPlayerSay", client, chatType, message, anonymous)
	return ""
end

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
end

function Schema:EntityTakeDamage(target, dmgInfo)
	if (!IsValid(target) or dmgInfo:GetDamage() == 0) then return end

	if (target:IsPlayer()) then
		local extra_health = target:ExtraHealth()

		if (extra_health > 0) then
			dmgInfo:SubtractDamage(extra_health)
			target:AddExtraHealth(-extra_health)
		end

		if (dmgInfo:GetDamage() <= 0.5) then return true end
	end
end

-- Stack hooks
util.AddNetworkString("ixItemSplit")

net.Receive("ixItemSplit", function(_, client)
	if ((client.ixItemSplitTry or 0) < CurTime()) then
		client.ixItemSplitTry = CurTime() + 0.33
	else
		return
	end

	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	local item = ix.item.instances[net.ReadUInt(32)]
	if (!item or !item.isStackable or IsValid(item.entity)) then return end

	local quantity = item:GetData("quantity", 1)
	if (quantity <= 1) then return end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, quantity)
	if (amount == 0 or amount == quantity) then return end

	if (character:GetInventory():Add(item.uniqueID, 1, {quantity = amount}, nil, nil, nil, true)) then
		amount = quantity - amount

		if (amount < 1) then
			item:Remove()
		else
			item:SetData("quantity", amount)
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