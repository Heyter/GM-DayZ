util.AddNetworkString("ixStashDepositItem")
util.AddNetworkString("ixStashWithdrawItem")
util.AddNetworkString("ixStashWithdrawMoney")
util.AddNetworkString("ixStashDepositMoney")
util.AddNetworkString("ixStashSync")

net.Receive("ixStashWithdrawMoney", function(_, client)
	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 0.33
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, character:GetStashMoney())
	if (amount == 0) then return end

	character:GiveMoney(amount)

	local stash = character:GetStash()
	stash[0] = stash[0] or {}
	stash[0].money = (stash[0].money or 0) - amount

	character:SetStash(stash)
	stash = nil
end)

net.Receive("ixStashDepositMoney", function(_, client)
	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 0.33
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, character:GetMoney())
	if (amount == 0) then return end

	character:TakeMoney(amount)

	local stash = character:GetStash()
	stash[0] = stash[0] or {}
	stash[0].money = (stash[0].money or 0) + amount

	character:SetStash(stash)
	stash = nil
end)

net.Receive("ixStashWithdrawItem", function(len, client)
	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 1
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local id = net.ReadUInt(32)
	local stash = character:GetStash()
	local stashItem = stash[id]

	if (!stashItem) then return end

	local stockItem = ix.item.list[stashItem.uniqueID]
	if (!stockItem) then return end

	local allStack = net.ReadBool()
	local data

	if (stockItem.isStackable) then
		data = table.Copy(stashItem.data or {})

		if (allStack) then
			local diff = data.quantity - (stockItem.maxQuantity or 16)

			if (diff > 0) then
				data.quantity = data.quantity - diff
			end
		else
			data.quantity = 1
		end
	end

	if (!character:GetInventory():Add(stash[id].uniqueID, 1, data or stashItem.data)) then
		client:NotifyLocalized("noFit")
		return
	end

	if (allStack and stockItem.isStackable and data) then
		stashItem.data.quantity = stashItem.data.quantity - data.quantity
	else
		stashItem.data.quantity = stashItem.data.quantity - 1
	end

	if (stashItem.data.quantity < 1) then
		stash[id] = nil
	end

	stash[0] = stash[0] or {}
	stash[0].weight = ix.stash.CalculateWeight(stash)

	character:SetStash(stash)
	data, stash = nil, nil
end)

net.Receive("ixStashDepositItem", function(len, client)
	local character = client:GetCharacter()
	if (!character or !client:Alive()) then return end

	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 1
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local id = net.ReadUInt(32)
	if (!isnumber(id)) then return end

	local totalWeight, maxWeight = character:GetStashWeight(), character:GetStashWeightMax()
	if (totalWeight >= maxWeight) then
		client:NotifyLocalized("stash_full")
		return
	end

	local item = character:GetInventory():GetItems(true)[id]

	if (!item) then
		return
	end

	if (item:GetData("equip")) then
		client:RemoveEquippableItem(item)

		if (item:GetData("equip")) then
			return
		end
	end

	local allStack = net.ReadBool()
	local result, newQuantity = item:UseStackItem(allStack, function(new, old)
		local diff = totalWeight + (old - new)
		local remainder = new - (maxWeight - diff)

		if (diff > maxWeight) then
			return remainder, (old - new) - remainder
		end

		return new, old
	end)

	if (result and !item:Remove()) then
		return client:NotifyLocalized("tellAdmin", "0A00!")
	end

	if (item.data) then
		item.data.equip = nil

		if (item.data.ammo and item.data.ammo < 1) then
			item.data.ammo = nil
		end
	end

	local stash = character:GetStash()
	local stashItem
	local copyData = table.Copy(item.data or {})

	if (!item.isStackable) then -- оружием там и прочее
		copyData.quantity = 1

		for i = 1, newQuantity do
			stash[#stash + 1] = {
				uniqueID = item.uniqueID,
				data = copyData
			}
		end
	else
		copyData.quantity = nil

		local index = #stash + 1
		for i, v in pairs(stash) do
			if (v.uniqueID == item.uniqueID) then
				index = i
				break
			end
		end

		stashItem = stash[index] or {data = {}}
		stashItem.uniqueID = item.uniqueID
		stashItem.data.quantity = (stashItem.data.quantity or 0) + newQuantity

		for k, v in pairs(copyData) do
			stashItem.data[k] = stashItem.data[k] or v
		end

		stash[index] = stashItem
	end

	stash[0] = stash[0] or {}
	stash[0].weight = ix.stash.CalculateWeight(stash)

	character:SetStash(stash)
	stash, copyData = nil, nil
end)

function PLUGIN:LoadData()
	for _, v in ipairs(self:GetData() or {}) do
		local stash = ents.Create("gmodz_stash")
		stash:SetPos(v[1])
		stash:SetAngles(v[2])
		stash:Spawn()
		stash:Activate()
	end
end

function PLUGIN:SaveData()
	local data = {}

	for _, v in ipairs(ents.FindByClass("gmodz_stash")) do
		if (!v:GetNetVar("Persistent", false)) then
			data[#data + 1] =  {v:GetPos(), v:GetAngles()}
		end
	end

	self:SetData(data)
end

PLUGIN.CheckedCharacter = PLUGIN.CheckedCharacter or {}

function PLUGIN:PlayerLoadedCharacter(_, character)
	if (self.CheckedCharacter[character:GetID()]) then return end

	timer.Simple(0.25, function()
		local calculate
		local stash = character:GetStash()

		for k, v in pairs(stash) do
			if (k != 0 and v.uniqueID and !ix.item.list[v.uniqueID]) then
				table.remove(stash, k)
				calculate = calculate or true
			end
		end

		if (calculate) then
			local weight = ix.stash.CalculateWeight(stash)

			if (weight == 0) then
				character:SetStash({})
			else
				stash[0] = stash[0] or {}
				stash[0].weight = weight

				character:SetStash(stash)
			end

			weight, stash = nil, nil
		end

		calculate = nil
		self.CheckedCharacter[character:GetID()] = true
	end)
end