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

	if (!IsValid(entity)) then
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
		local itemData = ix.item.instances[id]
		if (!itemData) then
			return
		end

		if (itemData.CanSell and itemData:CanSell() == false) then
			return
		end

		local found, invOkay = false, true
		local name

		for _, v in pairs(character:GetInventory():GetItems(true)) do
			if (v.id == id) then
				if (v:GetData("equip")) then
					client:RemoveEquippableItem(v)
				end

				invOkay = v:Remove()
				found = true
				name = L(v.name, client)

				break
			end
		end

		if (!found) then return end
		if (!invOkay) then
			client:GetCharacter():GetInventory():Sync(client, true)
			return client:NotifyLocalized("tellAdmin", "trd!iid")
		end

		local price = PLUGIN:CalculatePrice(itemData, isSellingToVendor, client)

		character:GiveMoney(price)
		client:NotifyLocalized("businessSell", name, ix.currency.Get(price))

		if (itemData.data) then
			itemData.data.equip = nil

			if (itemData.data.ammo and itemData.data.ammo < 1) then
				itemData.data.ammo = nil
			end
		end

		local item_id = #entity.items + 1
		entity.items[item_id] = {
			uniqueID = itemData.uniqueID,
			price = price <= 0 and nil or price,
			data = itemData.data or {}
		}

		entity:SyncItems(item_id, entity.items[item_id], true)

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
			--ix.item.Spawn(itemData.uniqueID, client, nil, nil, itemData.data)
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
end