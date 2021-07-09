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
		client.ixMerchantTry = CurTime() + 0.33
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

	if (isSellingToVendor) then -- продать торговцу шмот
		local item = character:GetInventory():GetItems(true)[id]

		if (!item or item.CanSell and item:CanSell() == false) then
			return
		end

		if (item:GetData("equip")) then
			client:RemoveEquippableItem(item)
		end

		if (item:UseStackItem() and !item:Remove()) then
			character:GetInventory():HalfSync(client)
			return client:NotifyLocalized("tellAdmin", "trd!iid")
		end

		local price = PLUGIN:CalculatePrice(item, isSellingToVendor, client)

		character:GiveMoney(price)
		client:NotifyLocalized("businessSell", L(item.name, client), ix.currency.Get(price))

		if (item.data) then
			item.data.equip = nil

			if (item.data.ammo and item.data.ammo < 1) then
				item.data.ammo = nil
			end
		end

		local copyData = table.Copy(item.data or {})
		copyData.quantity = 1

		local item_id = #entity.items + 1
		entity.items[item_id] = {
			uniqueID = item.uniqueID,
			price = price <= 0 and nil or price,
			data = copyData
		}

		entity:SyncItems(item_id, entity.items[item_id], true)
		copyData = nil

		save_count = save_count + 1
		if (save_count >= 15) then
			PLUGIN:SaveData()
			save_count = 0
		end
	else -- купить шмот
		local itemData = entity.items[id]
		if (!itemData) then return end

		local price = PLUGIN:CalculatePrice(itemData, isSellingToVendor, client)

		if (!character:HasMoney(price)) then
			return client:NotifyLocalized("canNotAfford")
		end

		if (!character:GetInventory():Add(itemData.uniqueID, 1, itemData.data)) then
			client:NotifyLocalized("noFit")
			return
		end

		local name = L(ix.item.list[itemData.uniqueID].name, client)

		character:TakeMoney(price)
		client:NotifyLocalized("businessPurchase", name, ix.currency.Get(price))

		entity.items[id] = nil
		entity:SyncItems(id, nil, false)

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
		for i = 1, maxItems do
			local itemID = Schema.GetRandomWeightedItem(scale)

			if (itemID and itemID != "money") then
				local item = ix.item.list[itemID]
				if (!item) then continue end

				local itemData = {}

				if (item.isStackable) then
					itemData.quantity = 1
				end

				if (item.useDurability) then
					itemData.durability = (item.defDurability or 100) * math.Rand(0.01, 0.5)
				end

				table.insert(items, {
					uniqueID = itemID,
					price = math.max(0, PLUGIN:CalculatePrice(item, true) / ix.config.Get("merchantSellPerc", 0.7)),
					data = itemData
				})

				itemData = nil
			end
		end
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

		entity.items = v.items
	end

	timer.Create("ixMerchantInterval", ix.config.Get("merchantInterval", 60) * 60, 0, PLUGIN.MerchantInterval)
end