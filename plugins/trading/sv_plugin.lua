util.AddNetworkString("ixTradeInvite")
util.AddNetworkString("ixTradeMenu")
util.AddNetworkString("ixTradeMenuAbort")
util.AddNetworkString("ixTradeSendItem")
util.AddNetworkString("ixTradeTakeItem")
util.AddNetworkString("ixTradeSyncItems")
util.AddNetworkString("ixTradeCancel")
util.AddNetworkString("ixTradeConfirm")
util.AddNetworkString("ixTradeMoneyGive")
util.AddNetworkString("ixTradeMoneyTake")
util.AddNetworkString("ixTradeMoneySync")

-- micro-op
local pairs, net, timer, math = pairs, net, timer, math

-- INVENTORY META | START --
local META = ix.meta.inventory

function META:HalfSync(receiver)
	local slots = {}

	for x, items in pairs(self.slots) do
		for y, item in pairs(items) do
			if (istable(item) and item.gridX == x and item.gridY == y) then
				slots[#slots + 1] = {x, y, item.uniqueID, item.id, item.data}
			end
		end
	end

	net.Start("ixInventorySync")
		net.WriteTable(slots)
		net.WriteUInt(self:GetID(), 32)
		net.WriteUInt(self.w, 6)
		net.WriteUInt(self.h, 6)
		net.WriteType(self.owner)
		net.WriteTable(self.vars or {})
	net.Send(receiver)
end

ix.meta.inventory = META
-- INVENTORY META | END --

function ix.trade.ClearVars(client)
	client.tradingWith = nil
	client.isTrading = nil
	client.tradingItems = nil
	client.tradingMoney = nil
	client.tradeConfirmed = nil
end

function ix.trade.MenuAbort(client)
	net.Start("ixTradeMenuAbort")
		net.WriteBool(true)
	net.Send(client)

	ix.trade.ClearVars(client)
end

function ix.trade.Complete(client, clientCharacter, otherCharacter, bMoneyOther)
	client.tradingItems = client.tradingItems or {}

	if (!table.IsEmpty(client.tradingItems)) then
		local inventory

		if (bMoneyOther) then
			inventory = clientCharacter:GetInventory()
		else
			inventory = otherCharacter:GetInventory()
		end

		if (inventory) then
			for _, slot in pairs(inventory.slots) do
				for _, item in pairs(slot) do
					if (client.tradingItems[item.id]) then
						if (item:GetData("equip")) then
							if (item.Unequip) then
								item:Unequip(client)
							elseif (item.RemoveOutfit) then
								item:RemoveOutfit(client)
							elseif (item.RemovePart) then
								item:RemovePart(client)
							end
						end

						item:Transfer(inventory:GetID())
					end
				end
			end
		end
	end

	local money = client.tradingMoney or 0

	if (money != 0) then
		if (bMoneyOther) then
			clientCharacter:GiveMoney(money)
			otherCharacter:TakeMoney(money)
		else
			clientCharacter:TakeMoney(money)
			otherCharacter:GiveMoney(money)
		end
	end

	ix.trade.ClearVars(client)
	client:EmitSound("items/ammo_pickup.wav", 75, 100, 0.5)
end

net.Receive("ixTradeConfirm", function(len, client)
	local other = client.tradingWith

	if (!IsValid(other)) then
		ix.trade.MenuAbort(client)
		return
	end

	client.tradeConfirmed = true

	if (client.tradeConfirmed and other.tradeConfirmed) then
		client.tradeConfirmed = nil
		other.tradeConfirmed = nil

		local otherCharacter = other:GetCharacter()
		local clientCharacter = client:GetCharacter()

		if (!otherCharacter or !clientCharacter) then
			ix.trade.MenuAbort(client)
			ix.trade.MenuAbort(other)

			return
		end

		timer.Simple(0, function()
			ProtectedCall(function()
				ix.trade.Complete(client, clientCharacter, otherCharacter, false)
			end)
		end)

		timer.Simple(0, function()
			ProtectedCall(function()
				ix.trade.Complete(other, clientCharacter, otherCharacter, true)
			end)
		end)

		net.Start("ixTradeMenuAbort")
			net.WriteBool(false)
		net.Send({client, other})
	else
		net.Start("ixTradeConfirm")
		net.Send(other)
	end
end)

net.Receive("ixTradeInvite", function(len, client)
	local other = client.invitedBy

	if (!IsValid(other) or !client:Alive() or other.isTrading) then return end

	local clientInv = ix.inventory.Get(client:GetLocalVar("TradeInvID"))
	local otherInv = ix.inventory.Get(other:GetLocalVar("TradeInvID"))

	if (net.ReadBool() and otherInv and clientInv) then
		other.isTrading = true
		client.isTrading = true

        client.tradingWith = other
        other.tradingWith = client

		-- Inventory --
		otherInv.slots = {}
		clientInv.slots = {}

		client:GetCharacter():GetInventory():HalfSync(other)
		other:GetCharacter():GetInventory():HalfSync(client)

		net.Start("ixTradeMenu")
			net.WriteEntity(other)
		net.Send(client)

		net.Start("ixTradeMenu")
			net.WriteEntity(client)
		net.Send(other)

        client.invitedBy = nil
        other.invitedBy = nil
	else
		other.tradeInvites[client:EntIndex()] = CurTime() + 60
		client.invitedBy = nil
	end
end)

net.Receive("ixTradeSendItem", function(len, client)
	local id = net.ReadUInt(32)

	if (!isnumber(id) or !client.isTrading) then
		if (!client.isTrading) then
			print(Format("[ixTradeSendItem] Exploit isTrading: %s (%s)", client:Name(), client:SteamID()))
		elseif (!isnumber(id)) then
			print(Format("[ixTradeSendItem] Exploit !isnumber(id): %s (%s)", client:Name(), client:SteamID()))
		end

		return
	end

	local other = client.tradingWith
	if (!IsValid(other)) then
		ix.trade.MenuAbort(client)
		return
	end

	client.tradingItems = client.tradingItems or {}
	if (client.tradingItems[id]) then return end

	local item = ix.item.instances[id]
	if (!item) then return end

	client.tradingItems[id] = {item.width, item.height}
	client.tradeConfirmed = nil

	net.Start("ixTradeSyncItems")
		net.WriteTable(client.tradingItems)
		net.WriteBool(false)
	net.Send(other)

	net.Start("ixTradeSyncItems")
		net.WriteTable(client.tradingItems)
		net.WriteBool(true)
	net.Send(client)
end)

net.Receive("ixTradeTakeItem", function(len, client)
	local id = net.ReadUInt(32)

	if (!isnumber(id) or !client.isTrading) then
		if (!client.isTrading) then
			print(Format("[ixTradeTakeItem] Exploit isTrading: %s (%s)", client:Name(), client:SteamID()))
		elseif (!isnumber(id)) then
			print(Format("[ixTradeTakeItem] Exploit !isnumber(id): %s (%s)", client:Name(), client:SteamID()))
		end

		return
	end

	local other = client.tradingWith

	if (!IsValid(other)) then
		ix.trade.MenuAbort(client)
		return
	end

	client.tradingItems = client.tradingItems or {}
	if (!client.tradingItems[id]) then return end

	client.tradingItems[id] = nil
	client.tradeConfirmed = nil

	net.Start("ixTradeSyncItems")
		net.WriteTable(client.tradingItems)
		net.WriteBool(false)
	net.Send(other)

	net.Start("ixTradeSyncItems")
		net.WriteTable(client.tradingItems)
		net.WriteBool(true)
	net.Send(client)
end)

net.Receive("ixTradeCancel", function(len, client)
	local other = client.tradingWith

	if (IsValid(other)) then
		ix.trade.MenuAbort(other)
	end

	ix.trade.ClearVars(client)
end)

net.Receive("ixTradeMoneyGive", function(len, client)
	if (!client.isTrading or CurTime() < (client.ixTradeMoneyTimer or 0)) then
		return
	end

	if (!IsValid(client.tradingWith)) then
		ix.trade.MenuAbort(client)
		return
	end

	local character = client:GetCharacter()

	if (!character) then
		return
	end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, character:GetMoney())

	if (amount == 0) then
		return
	end

	client.tradingMoney = math.min(character:GetMoney(), (client.tradingMoney or 0) + amount)

	net.Start("ixTradeMoneySync")
		net.WriteUInt(client.tradingMoney, 32)
		net.WriteBool(false)
		net.WriteBool(false)
	net.Send(client.tradingWith)

	net.Start("ixTradeMoneySync")
		net.WriteUInt(client.tradingMoney, 32)
		net.WriteBool(false)
		net.WriteBool(true)
	net.Send(client)

	client.ixTradeMoneyTimer = CurTime() + 0.5
end)

net.Receive("ixTradeMoneyTake", function(len, client)
	if (!client.isTrading or CurTime() < (client.ixTradeMoneyTimer or 0)) then
		return
	end

	if (!IsValid(client.tradingWith)) then
		ix.trade.MenuAbort(client)
		return
	end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, client.tradingMoney or 0)

	if (amount == 0) then
		return
	end

	client.tradingMoney = math.max(0, (client.tradingMoney or 0) - amount)

	net.Start("ixTradeMoneySync")
		net.WriteUInt(client.tradingMoney, 32)
		net.WriteBool(false)
		net.WriteBool(false)
	net.Send(client.tradingWith)

	net.Start("ixTradeMoneySync")
		net.WriteUInt(client.tradingMoney, 32)
		net.WriteBool(false)
		net.WriteBool(true)
	net.Send(client)

	client.ixTradeMoneyTimer = CurTime() + 0.5
end)

do
	local function PlayerDeath(client)
		if (client.isTrading) then
			local other = client.tradingWith

			if (IsValid(other)) then
				ix.trade.MenuAbort(other)
			end

			ix.trade.MenuAbort(client)
		end
	end

	hook.Add("PlayerDeath", "ix.trade.PlayerDeath", PlayerDeath)
	hook.Add("PlayerSilentDeath", "ix.trade.PlayerDeath", PlayerDeath)
end

function PLUGIN:OnCharacterDisconnect(client)
	local tradeInvID = client:GetLocalVar("TradeInvID")

	if (tradeInvID and ix.inventory.Get(tradeInvID)) then
		ix.item.inventories[tradeInvID] = nil
		tradeInvID = nil
	end

	if (client.isTrading) then
		local other = client.tradingWith

		if (IsValid(other)) then
			ix.trade.MenuAbort(other)
		end

		ix.trade.ClearVars(client)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	if (character) then
		local tradeInvID = client:GetLocalVar("TradeInvID")

		if (!tradeInvID) then
			local invID = os.time() + client:EntIndex() + character:GetID()
			local inventory = ix.inventory.Create(ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), invID)
			inventory.owner = invID
			inventory.noSave = true
			inventory.vars.isTrading = true
			inventory:HalfSync(client)

			client:SetLocalVar("TradeInvID", inventory:GetID())
		end
	end
end

function PLUGIN:CanTransferItem(item, curInv, newInventory)
	if (curInv and newInventory) then
		if (newInventory.vars and newInventory.vars.isTrading) or (curInv.vars and curInv.vars.isTrading) then
			return false
		end
	end
end

function PLUGIN:PlayerInteractItem(client, action, item)
	if (client.isTrading and action == "drop" and client.tradingItems and client.tradingItems[item.id]) then
		local other = client.tradingWith

		if (!IsValid(other)) then
			ix.trade.MenuAbort(client)
			return
		end

		client.tradingItems[item.id] = nil
		client.tradeConfirmed = nil

		net.Start("ixTradeSyncItems")
			net.WriteTable(client.tradingItems)
			net.WriteBool(false)
		net.Send(other)

		net.Start("ixTradeSyncItems")
			net.WriteTable(client.tradingItems)
			net.WriteBool(true)
		net.Send(client)
	end
end

function PLUGIN:CanPlayerInteractItem(client, action)
	if (action == "combine" and client.isTrading) then
		return false
	end
end