PLUGIN.name = "Trading"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Trading of items between players."

local maxTargetDistance = math.pow(400, 2)

ix.trade = ix.trade or {}

ix.util.Include("sv_plugin.lua")

ix.command.Add("offer", {
	description = "Offer a trade.",
	arguments = ix.type.character,
	OnRun = function(self, client, target)
		if (!target) then return end

		if (client.isTrading) then
			return "You cannot start a new trade when one is already active"
		end

		local targetPlayer = target:GetPlayer()
		if (!targetPlayer or targetPlayer == client) then return end

		local targetIndex = targetPlayer:EntIndex()
		local targetName = targetPlayer:Nick()

		if (targetPlayer.isTrading) then
			return Format("%s is already trading", targetName)
		end

		if (client:GetPos():DistToSqr(targetPlayer:GetPos()) > maxTargetDistance) then
			return Format("%s is too far away, unable to trade.", targetName)
		end

		if (IsValid(client.tradingWith)) then
			return Format("You are currently trading with %s!", client.tradingWith:Nick())
		end

		client.tradeInvites = client.tradeInvites or {}

		if ((client.tradeInvites[targetIndex] or 0) > CurTime()) then
			local time = math.Round(client.tradeInvites[targetIndex] - CurTime())
			return Format("Wait %d's before trade inviting %s again!", time, targetName)
		end

		client.tradeInvites[targetIndex] = CurTime() + 7

		targetPlayer.invitedBy = client

		net.Start("ixTradeInvite")
			net.WriteString(client:Nick())
			net.WriteFloat(CurTime() + 30)
		net.Send(targetPlayer)

		return Format("Trade invite sent to %s!", targetName)
	end
})

if (CLIENT) then
	function PLUGIN:LoadFonts()
		surface.CreateFont( "TradeArial20", {
			font = "Arial",
			size = 20,
			weight = 700,
		})
		surface.CreateFont( "TradeArial25", {
			font = "Arial",
			size = 25,
			weight = 700,
		})
	end

	local InvitePanel
	local Col = {
		Main = Color(100,100,100,100),
		Text = color_white,
		Accept = Color(150,255,150),
		Decline = Color(255,150,150)
	}

	net.Receive("ixTradeInvite", function()
		local whoInvite = net.ReadString()
		local timeInvite = net.ReadFloat()

		if (!timeInvite or !whoInvite or IsValid(InvitePanel)) then
			return
		end

		surface.PlaySound("friends/message.wav")

		InvitePanel = vgui.Create('DPanel')
		InvitePanel:SetSize(300, 100)
		InvitePanel.whoInvite = whoInvite
		InvitePanel:SetPos((ScrW() / 2) - 150, ScrH() - 225)
		InvitePanel.Paint = function(this, w, h)
			local glow = math.abs(math.sin(CurTime() * 2) * 255)

			surface.SetDrawColor(Color(glow, 10, 10, 255))

			surface.DrawRect(0, 0, 2, h)
			surface.DrawRect(w - 2, 0, 2, h)
			surface.DrawRect(2, 0, w - 4, 2)
			surface.DrawRect(2, h - 2, w - 4, 2)

			surface.SetDrawColor(Col.Main)
			surface.DrawRect(2, 2, w - 4, h - 4)

			w = (w / 2)

			ix.util.DrawText("You have been invited to trade with", w, 15, Col.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, "TradeArial20")
			ix.util.DrawText(this.whoInvite, w, 40, team.GetColor(LocalPlayer():Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, "TradeArial25")

			local str = Format("%s to accept", (input.LookupBinding("gm_showhelp") or "None"))
			ix.util.DrawText(str, w - 5, 70, Col.Accept, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

			str = Format("%s to decline", (input.LookupBinding("gm_showteam") or "None"))
			ix.util.DrawText(str, w + 5, 70, Col.Decline, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		hook.Add("PlayerBindPress", InvitePanel, function(self, _, bind, pressed)
			if (!IsValid(self)) then return end

			if (bind:find("gm_showhelp") and pressed) then -- accept
				net.Start("ixTradeInvite")
					net.WriteBool(true)
				net.SendToServer()

				self:Remove()
				return true
			elseif (bind:find("gm_showteam") and pressed) then -- decline
				net.Start("ixTradeInvite")
					net.WriteBool(false)
				net.SendToServer()

				self:Remove()
				return true
			end
		end)

		local panel = InvitePanel
		timer.Simple(math.min(math.abs(timeInvite - CurTime()), 30), function()
			if (IsValid(panel)) then
				panel:Remove()
			end
		end)
	end)

	net.Receive("ixTradeMenuAbort", function()
		if (IsValid(ix.gui.tradeMenu)) then
			ix.gui.tradeMenu:Remove()
			ix.gui.tradeMenu = nil
		end

		if (net.ReadBool()) then
			LocalPlayer():Notify("The trade was cancelled")
		else
			LocalPlayer():Notify("Trade with " .. LocalPlayer().tradingWith:Nick() .. " complete!")
		end

		LocalPlayer().tradingWith = nil
		LocalPlayer().tradingItems = nil
	end)
	
	net.Receive("ixTradeSyncItems", function()
		local panel = ix.gui.tradeMenu
		if (!IsValid(panel)) then return end

		panel.confirmPanel.confirmTrade = false
		panel.confirmButton:Reset()

		local items = net.ReadTable()
		local bLocal = net.ReadBool()

		if (bLocal) then
			LocalPlayer().tradingItems = items

			-- Hightlight slots --
			for id, v in pairs(ix.gui.inv1.panels) do
				if (!IsValid(v)) then goto SKIP end

				if (items[id]) then
					v.ExtraPaint = function(self, width, height)
						surface.SetDrawColor(50, 150, 50, 45)
						surface.DrawRect(2, 2, width - 4, height - 4)
					end
				else
					v.ExtraPaint = function() end
				end

				::SKIP::
			end
		else
			LocalPlayer().tradingItems = items

			-- Remove old items --
			for _, v in pairs(panel.storageInventory.panels) do
				v:Remove()
			end

			local inventory = ix.inventory.Get(LocalPlayer():GetLocalVar("TradeInvID"))
			inventory.slots = {}

			local x, y, w, h

			for id, v in pairs(items) do
				w, h = v[1], v[2]
				x, y = inventory:FindEmptySlot(w, h, true)

				if !(x and y) then goto SKIP end

				for x2 = 0, w - 1 do
					for y2 = 0, h - 1 do
						local index = x + x2
						inventory.slots[index] = inventory.slots[index] or {}
						inventory.slots[index][y + y2] = ix.item.instances[id]
					end
				end

				::SKIP::
			end

			panel.storageInventory:SetInventory(inventory)
			panel.storageInventory:SetTall(panel.storageInventory:GetTall() + panel.storageMoney:GetTall() + panel.confirmPanel:GetTall() + 2) -- bruh
		end
	end)

	net.Receive("ixTradeMenu", function()
		local otherPlayer = net.ReadEntity()

        LocalPlayer().tradingWith = otherPlayer
		LocalPlayer().tradingItems = {}
		otherPlayer.tradingItems = {}

		-- Menu --
		local panel = vgui.Create("ixTradeView")
		local character = LocalPlayer():GetCharacter()

		-- Local Player --
		panel:SetLocalInventory(character:GetInventory())
		panel:SetLocalMoney(character:GetMoney())

		local tradeInventory = ix.inventory.Get(LocalPlayer():GetLocalVar("TradeInvID"))
		tradeInventory.slots = {}

		panel:SetStorageTitle("Trading with " .. otherPlayer:Nick())
		panel:SetStorageInventory(tradeInventory)
		panel:SetStorageMoney(0)
	end)
	
	net.Receive("ixTradeConfirm", function()
		if (IsValid(ix.gui.tradeMenu)) then
			ix.gui.tradeMenu.confirmPanel.confirmTrade = true
		end
	end)
	
	net.Receive("ixTradeMoneySync", function()
		local panel = ix.gui.tradeMenu

		if (!IsValid(panel)) then
			return
		end

		local amount = net.ReadUInt(32)

		local take = net.ReadBool()
		local bLocal = net.ReadBool()

		if (bLocal) then
			local clientMoney = LocalPlayer():GetCharacter():GetMoney()

			if (take) then
				panel:SetLocalMoney(clientMoney + amount)
			else -- give
				panel:SetLocalMoney(clientMoney - amount)
			end

			local name = string.gsub(ix.util.ExpandCamelCase(ix.currency.plural), "%s", "")

			if (amount > 0) then
				panel.localMoney.moneyLabel:SetText(Format("%s: %d (-%d)", name, panel.localMoney.money, amount))
			else
				panel.localMoney.moneyLabel:SetText(Format("%s: %d", name, panel.localMoney.money))
			end
		else
			panel:SetStorageMoney(amount)
		end
	end)

	function PLUGIN:CreateItemInteractionMenu(itemPanel, menu, item)
		if (IsValid(ix.gui.tradeMenu)) then
			local inventory = ix.inventory.Get(itemPanel.inventoryID)
			if (inventory.vars.isTrading) then return true end

			menu = DermaMenu()

			if (LocalPlayer().tradingItems[item.id]) then
				menu:AddOption("Take Item", function()
					net.Start("ixTradeTakeItem")
						net.WriteUInt(item:GetID(), 32)
					net.SendToServer()
				end):SetImage("icon16/basket_delete.png")
			else
				menu:AddOption("Give Item", function()
					net.Start("ixTradeSendItem")
						net.WriteUInt(item:GetID(), 32)
					net.SendToServer()
				end):SetImage("icon16/basket_put.png")
			end

			menu:Open()
			return true
		end
	end

	function PLUGIN:CanTransferItem(item, curInv, newInventory)
		if (curInv and newInventory) then
			if (newInventory.vars.isTrading and !curInv.vars.isTrading) then
				if (LocalPlayer().tradingWith and !IsValid(LocalPlayer().tradingWith)) then -- abort trade
					if (IsValid(ix.gui.tradeMenu)) then
						ix.gui.tradeMenu:Remove()
						ix.gui.tradeMenu = nil
					end

					return false
				end

				net.Start("ixTradeSendItem")
					net.WriteUInt(item:GetID(), 32)
				net.SendToServer()
				return false
			elseif (newInventory.vars.isTrading or curInv.vars.isTrading) then
				return false
			end
		end
	end
end