local playerMeta = FindMetaTable"Player"

-- Синхронизировать все патроны из инвентаря
function playerMeta:UpdateInventoryAllAmmo()
	self:StripAmmo()

	local ammo = {}

	for _, v in pairs(self:GetItems()) do
		if (v.ammo and v.ammoAmount) then
			ammo[v.ammo] = (ammo[v.ammo] or 0) + v:GetData("rounds", v.ammoAmount)
		end
	end

	for k, v in pairs(ammo) do
		self:SetAmmo(v, k)
	end
end

-- Синхронизировать патроны из инвентаря по ammoID
function playerMeta:UpdateInventoryAmmo(ammoID)
	--print("UpdateInventoryAmmo", ammoID)

	if (isnumber(ammoID)) then
		ammoID = game.GetAmmoName(ammoID)
	end

	local count = 0

	for _, v in pairs(self:GetItems()) do
		if (v.ammo and v.ammoAmount and v.ammo == ammoID) then
			count = count + v:GetData("rounds", v.ammoAmount)
		end
	end

	self:SetAmmo(count, ammoID)
end

-- Забрать патроны из инвентаря
function playerMeta:TakeInventoryAmmo(ammoID, amount)
	--print("TakeInventoryAmmo", ammoID)

	if (isnumber(ammoID)) then
		ammoID = game.GetAmmoName(ammoID)
	end

	local clip1 = amount

	for _, v in pairs(self:GetItems()) do
		if (v.ammo and v.ammoAmount and v.ammo == ammoID) then
			if (clip1 == 0) then break end
			local rounds = v:GetData("rounds", v.ammoAmount)

			if (rounds - clip1 <= 0) then
				clip1 = math.max(0, clip1 - rounds)
				v:Remove()

				-- TODO: проверять удалился ли предмет.
			else
				v:SetData("rounds", rounds - clip1)
				clip1 = 0
			end
		end
	end
end

-- ================= --

function PLUGIN:PlayerDeath(client)
	client:StripAmmo()
end

function PLUGIN:PostPlayerLoadout(client)
	client:UpdateInventoryAllAmmo()
end

function PLUGIN:PlayerInteractItem(client, action, item)
	if (item.ammoAmount and item.ammo and (action == "drop" or action == "take")) then
		client:UpdateInventoryAmmo(item.ammo)
	end
end

function PLUGIN:InventoryItemAdded(oldInv, inventory, item, split)
	if (!inventory.owner or (oldInv and oldInv.owner == inventory.owner)) then
		return
	end

	if (item.ammoAmount and item.ammo) then
		local client = ix.char.loaded[inventory.owner]:GetPlayer()

		if (!split) then
			client:UpdateInventoryAmmo(item.ammo)
		end
	end
end

function PLUGIN:InventoryItemRemoved(inventory, item)
	if (!inventory.owner) then
		return
	end

	if (item.ammoAmount and item.ammo) then
		local client = ix.char.loaded[inventory.owner]:GetPlayer()

		client:UpdateInventoryAmmo(item.ammo)
	end
end