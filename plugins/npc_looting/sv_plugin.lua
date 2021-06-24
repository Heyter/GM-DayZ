ix.allowedHoldableClasses["gmodz_npc_loot"] = true

local v1 = Vector(0, 0, 5000)
function PLUGIN:OnNPCKilled(npc, attacker, weapon)
	if (!attacker:IsPlayer()) then return end -- если убийца не игрок

	-- репутация
	local config_rep = ix.config.Get("reputationSavior", 10)

	net.Start("ixUpdateRep")
		net.WriteBool(false) -- положительная репутация
		net.WriteUInt(config_rep, 16)
	net.Send(attacker)

	attacker:AddReputation(config_rep)

	-- generate loot
	local replication

	local money = math.random(100)
	if (money <= math.random(100)) then
		replication = true
	end

	if (!replication) then return end

	-- create inventory
	local inventory = ix.inventory.Create(ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), os.time() + npc:EntIndex())
	inventory.noSave = true
	inventory.isLoot = true

	-- цикл по предметам
	-- todo: сделать рандом
	--inventory:Add(uniqueID, quantity, data, nil, nil, true)

	local pos = npc:GetPos()
	local trace = util.TraceLine({
		start = pos,
		endpos = pos - v1
	})

	-- entity loot
	local entity = ents.Create("gmodz_npc_loot")
	entity:SetPos(trace.HitPos - trace.HitNormal * entity:OBBMins().z)
	entity:SetAngles(angle_zero)
	entity:Spawn()

	if (money > 0) then
		entity:SetMoney(money)
	end

	entity:SetID(inventory:GetID())
end