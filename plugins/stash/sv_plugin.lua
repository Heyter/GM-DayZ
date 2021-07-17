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
	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 0.33
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local id = net.ReadUInt(32)
	if (!isnumber(id) or !client:Alive()) then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local stash = character:GetStash()
	if (!stash[id]) then return end

	if (!character:GetInventory():Add(stash[id].uniqueID, 1, stash[id].data)) then
		client:NotifyLocalized("noFit")
		return
	end

	stash[id] = nil

	-- calculate stash filled slots
	local i = 0
	for k, v in pairs(stash) do
		if (k == 0 or v.data.noWeight) then continue end
		i = i + 1
	end
	stash[0] = stash[0] or {}
	stash[0].max = i

	character:SetStash(stash)
	stash = nil
end)

net.Receive("ixStashDepositItem", function(len, client)
	if ((client.ixStashTry or 0) < CurTime()) then
		client.ixStashTry = CurTime() + 0.33
	else
		return
	end

	if (client:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) == SH_SZ.OUTSIDE) then
		client:NotifyLocalized("stash_far")
		return
	end

	local id = net.ReadUInt(32)
	if (!isnumber(id) or !client:Alive()) then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local totalStash, maxStash = character:GetStashCount(), character:GetStashMax()
	if (totalStash >= maxStash) then
		client:NotifyLocalized("stash_full")
		return
	end

	local item = character:GetInventory():GetItems(true)[id]
	if (!item) then
		return
	end

	if (item:GetData("equip")) then
		client:RemoveEquippableItem(item)
	end

	local bAllItems = net.ReadBool()
	local result, quantity = item:UseStackItem(isbool(bAllItems) and bAllItems or nil, function(new, old)
		local diff = totalStash + (old - new)
		local remainder = new - (maxStash - diff)

		if (diff > maxStash) then
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
	local copyData = table.Copy(item.data or {})
	copyData.quantity = 1

	for i = 1, quantity do
		stash[#stash + 1] = {
			uniqueID = item.uniqueID,
			data = copyData
		}
	end

	-- calculate stash filled slots
	local i = 0
	for k, v in pairs(stash) do
		if (k == 0 or v.data.noWeight) then continue end
		i = i + 1
	end
	stash[0] = stash[0] or {}
	stash[0].max = i

	character:SetStash(stash)
	stash, copyData, quantity = nil, nil, nil
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

function PLUGIN:InitPostEntity()
	local query = mysql:Delete("ix_items")
		query:Where("inventory_id", 0)
	query:Execute()
end

PLUGIN.CheckedCharacter = PLUGIN.CheckedCharacter or {}

function PLUGIN:PlayerLoadedCharacter(_, character)
	if (self.CheckedCharacter[character:GetID()]) then return end

	timer.Simple(0.25, function()
		local r = nil
		local stash = character:GetStash()

		for k, v in pairs(stash) do
			if (k != 0 and v.uniqueID and !ix.item.list[v.uniqueID]) then
				table.remove(stash, k)
				r = true
			end
		end

		if (r) then
			-- calculate stash filled slots
			local i = 0
			for k, v in pairs(stash) do
				if (k == 0 or v.data.noWeight) then continue end
				i = i + 1
			end

			if (i == 0) then
				character:SetStash({})
			else
				stash[0] = stash[0] or {}
				stash[0].max = i

				character:SetStash(stash)
			end

			r, i = nil, nil
		end

		self.CheckedCharacter[character:GetID()] = true
	end)
end