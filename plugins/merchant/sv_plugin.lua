local PLUGIN = PLUGIN

util.AddNetworkString("ixMerchantOpen")
util.AddNetworkString("ixMerchantTrade")
util.AddNetworkString("ixMerchantSync")
util.AddNetworkString("ixMerchantClose")

net.Receive("ixMerchantClose", function(len, client)
	local entity = client.ixMerchant

	if (!IsValid(entity)) then
		return
	end

	entity:RemoveReceiver(client)
end)

local save_count = 0

net.Receive("ixMerchantTrade", function(len, client)
	if ((client.ixMerchantTry or 0) < CurTime()) then
		client.ixMerchantTry = CurTime() + 1
	else
		return
	end

	local entity = client.ixMerchant

	if (!IsValid(entity) or !client:Alive()) then
		return
	else
		if (client:GetPos():DistToSqr(entity:GetPos()) > 36864) then
			entity:RemoveReceiver(client)
			return
		end
	end

	local id = net.ReadUInt(32)
	if (!isnumber(id)) then return end

	local isSellingToVendor = net.ReadBool()
	local character = client:GetCharacter()
	if (!character) then return end

	local allStack = net.ReadBool()

	if (isSellingToVendor) then -- продать торговцу шмот
		local item = character:GetInventory():GetItems(true)[id]

		if (!item or item.CanSell and item:CanSell() == false) then
			return
		end

		if (item:GetData("equip")) then
			client:RemoveEquippableItem(item)

			if (item:GetData("equip")) then
				return
			end
		end

		local result, newQuantity = item:UseStackItem(allStack, function(new, old)
			local diff = old - (item.maxQuantity or 16)

			if (diff > 0) then
				return old - diff, new
			end

			return new, old
		end)

		if (result and !item:Remove()) then
			character:GetInventory():HalfSync(client)
			return client:NotifyLocalized("tellAdmin", "trd!iid")
		end

		local price = PLUGIN:CalculatePrice(item, isSellingToVendor, client)
		price = price * newQuantity

		if (price > 0) then
			character:GiveMoney(price)
		end
		client:NotifyLocalized("businessSell", L(item.name, client), ix.currency.Get(price))

		if (item.data) then
			item.data.equip = nil

			if (item.data.ammo and item.data.ammo < 1) then
				item.data.ammo = nil
			end
		end

		local copyData = table.Copy(item.data or {})
		local index = #entity.items + 1

		if (!item.isStackable) then
			copyData.quantity = 1
			entity.items[index] = {
				uniqueID = item.uniqueID,
				data = copyData
			}
		else
			copyData.quantity = nil

			for i, v in pairs(entity.items) do
				if (v.uniqueID == item.uniqueID) then
					index = i
					break
				end
			end

			local merchItem = entity.items[index] or {data = {}}
			merchItem.uniqueID = merchItem.uniqueID or item.uniqueID
			merchItem.data.quantity = (merchItem.data.quantity or 0) + newQuantity

			for k, v in pairs(copyData) do
				merchItem.data[k] = merchItem.data[k] or v
			end

			entity.items[index] = merchItem
		end

		entity:SyncItems(index, entity.items[index], true)
		copyData = nil

		save_count = save_count + 1
		if (save_count >= 15) then
			PLUGIN:SaveData()
			save_count = 0
		end
	else -- купить шмот
		local itemData = entity.items[id]
		if (!itemData) then return end

		local stockItem = ix.item.list[itemData.uniqueID]
		if (!stockItem) then return end

		local price = PLUGIN:CalculatePrice(itemData, isSellingToVendor, client)
		local data

		if (stockItem.isStackable) then
			data = table.Copy(itemData.data or {})

			if (allStack) then
				local diff = data.quantity - (stockItem.maxQuantity or 16)

				if (diff > 0) then
					data.quantity = data.quantity - diff
				end

				price = price * data.quantity
			else
				data.quantity = 1
			end
		end

		if (!character:HasMoney(price)) then
			data = nil
			return client:NotifyLocalized("canNotAfford")
		end

		if (!character:GetInventory():Add(itemData.uniqueID, 1, data or itemData.data)) then
			client:NotifyLocalized("noFit")
			return
		end

		if (price > 0) then
			character:TakeMoney(price)
		end
		client:NotifyLocalized("businessPurchase", L(stockItem.name, client), ix.currency.Get(price))

		if (allStack and stockItem.isStackable and data) then
			itemData.data.quantity = itemData.data.quantity - data.quantity
		else
			itemData.data.quantity = itemData.data.quantity - 1
		end

		if (itemData.data.quantity < 1) then
			entity.items[id] = nil
		else
			entity.items[id] = itemData
		end
		entity:SyncItems(id, entity.items[id], false)

		save_count = save_count + 1
		if (save_count >= 15) then
			PLUGIN:SaveData()
			save_count = 0
		end
	end
end)

--- Установить рандомный массив предметов
function PLUGIN:SetRandomItems(maxItems, scale)
	local items = {}

	if (maxItems > 0) then
		local index, itemData

		for i = 1, maxItems do
			local itemID = Schema.GetRandomWeightedItem(scale)

			if (itemID) then
				local item = ix.item.list[itemID]
				if (!item) then continue end

				itemData = {}

				if (item.isStackable) then
					itemData.quantity = 1

					for k, v in ipairs(items) do
						if (v.uniqueID == item.uniqueID) then
							index = k
							break
						end
					end
				end

				if (item.useDurability) then
					itemData.durability = (item.defDurability or 100) * math.Rand(0.1, 1)
				end

				if (index and item.isStackable) then
					local merchItem = items[index] or {data = {}}
					merchItem.uniqueID = merchItem.uniqueID or item.uniqueID
					merchItem.data.quantity = (merchItem.data.quantity or 0) + 1

					items[index] = merchItem
				else
					table.insert(items, {
						uniqueID = itemID,
						data = itemData
					})
				end

				index = nil
			end
		end

		index, itemData = nil, nil
	end

	return items
end

--- Таймер, который обновляет торговца каждые X минут
function PLUGIN.MerchantInterval()
	for _, entity in ipairs(ents.FindByClass("gmodz_merchant")) do
		local count = table.Count(entity.items)

		if (!count or count <= 0) then
			entity.items = PLUGIN:SetRandomItems(math.random(3, 15))

			for k, v in ipairs(entity.receivers) do
				if (IsValid(v) and v:Alive() and v:GetPos():DistToSqr(entity:GetPos()) <= 36864) then
					net.Start("ixMerchantOpen")
						net.WriteEntity(entity)
						net.WriteTable(entity.items)
					net.Send(v)
				else
					table.remove(entity.receivers, k)
				end
			end
		end

		count = nil
	end

	PLUGIN:SaveData()
end

-- HOOKS

function PLUGIN:SaveData()
	local data = {}

	for _, entity in ipairs(ents.FindByClass("gmodz_merchant")) do
		local bodygroups = {}

		for _, v in ipairs(entity:GetBodyGroups() or {}) do
			bodygroups[v.id] = entity:GetBodygroup(v.id)
		end

		data[#data + 1] = {
			pos = entity:GetPos(),
			angles = entity:GetAngles(),
			model = entity:GetModel(),
			skin = entity:GetSkin(),
			bodygroups = bodygroups,
			items = entity.items
		}
	end

	self:SetData(data)
end

function PLUGIN:LoadData()
	for _, v in ipairs(self:GetData() or {}) do
		local entity = ents.Create("gmodz_merchant")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()

		entity:SetModel(v.model)
		entity:SetSkin(v.skin or 0)
		entity:SetSolid(SOLID_BBOX)
		entity:PhysicsInit(SOLID_BBOX)

		local physObj = entity:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		for id, bodygroup in pairs(v.bodygroups or {}) do
			entity:SetBodygroup(id, bodygroup)
		end

		for k2, v2 in pairs(v.items) do
			if (!ix.item.list[v2.uniqueID]) then
				table.remove(v2.items, k2)
				-- todo проверить
			end
		end

		entity.items = v.items
	end

	timer.Create("ixMerchantInterval", ix.config.Get("merchantInterval", 60) * 60, 0, PLUGIN.MerchantInterval)
end