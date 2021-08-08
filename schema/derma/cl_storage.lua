local PANEL = vgui.GetControlTable("ixStorageView")

function PANEL:Init()
	if (IsValid(ix.gui.openedStorage)) then
		ix.gui.openedStorage:Remove()
	end

	ix.gui.openedStorage = self

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:SetFadeTime(0.25)
	self:SetFrameMargin(4)

	self.storageInventory = self:Add("ixInventory")
	self.storageInventory.bNoBackgroundBlur = true
	self.storageInventory:ShowCloseButton(true)
	self.storageInventory:SetTitle("Storage")
	self.storageInventory.Close = function(this)
		net.Start("ixStorageClose")
		net.SendToServer()
		self:Remove()
	end

	self.storageMoney = self.storageInventory:Add("ixStorageMoneyItems")
	self.storageMoney:SetVisible(false)
	self.storageMoney.OnTransfer = function(t, amount, button)
		if (button) then
			amount = t.money
		end

		net.Start("ixStorageMoneyTake")
			net.WriteUInt(self.storageID, 32)
			net.WriteUInt(amount, 32)
		net.SendToServer()
	end

	ix.gui.inv1 = self:Add("ixInventory")
	ix.gui.inv1.bNoBackgroundBlur = true
	ix.gui.inv1:ShowCloseButton(true)
	ix.gui.inv1.Close = function(this)
		net.Start("ixStorageClose")
		net.SendToServer()
		self:Remove()
	end

	self.localMoney = ix.gui.inv1:Add("ixStashMoney")
	self.localMoney:SetVisible(false)
	self.localMoney:SetTooltip(L"text_rmb_giveallmoney")
	self.localMoney.OnTransfer = function(t, amount, button)
		if (button) then
			amount = t.money
		end

		net.Start("ixStorageMoneyGive")
			net.WriteUInt(self.storageID, 32)
			net.WriteUInt(amount, 32)
		net.SendToServer()
	end

	self:SetAlpha(0)
	self:AlphaTo(255, self:GetFadeTime())

	self.storageInventory:MakePopup()
	ix.gui.inv1:MakePopup()
end

derma.DefineControl("ixStorageView", "", PANEL, "Panel")

PANEL = {}

AccessorFunc(PANEL, "money", "Money", FORCE_NUMBER)

function PANEL:Init()
	self:DockPadding(1, 1, 1, 1)
	self:SetTall(24)
	self:Dock(BOTTOM)

	self.moneyBtn = self:Add("DButton")
	self.moneyBtn:Dock(FILL)
	self.moneyBtn:DockMargin(0, 0, 1, 0)
	self.moneyBtn:SetFont("ixGenericFont")
	self.moneyBtn:SetText("")
	self.moneyBtn:SetTooltip(L"text_rmb_takeallmoney")
	self.moneyBtn:SetIcon("icon16/money_dollar.png")
	self.moneyBtn:SetTextInset(2, 0)
	self.moneyBtn:SizeToContents()
	self.moneyBtn.Paint = function(t, w, h)
		derma.SkinFunc("PaintButtonFilled", t, w, h)
	end

	self.moneyBtn.OnMousePressed = function(_, code)
		if (code == MOUSE_LEFT) then
			surface.PlaySound("ui/buttonclick.wav")

			Derma_NumericRequest("", L"stash_enter_money", self.money, function(text)
				local amount = math.max(0, math.Round(tonumber(text) or 0))

				if (amount != 0) then
					self:OnTransfer(amount)
				end
			end)
		elseif (code == MOUSE_RIGHT) then
			surface.PlaySound("ui/buttonclick.wav")

			self:OnTransfer(0, MOUSE_RIGHT)
		end
	end

	self.takeBtn = self:Add("DButton")
	self.takeBtn:Dock(RIGHT)
	self.takeBtn:SetFont("ixGenericFont")
	self.takeBtn:SetText(L"take_all")
	self.takeBtn:SetTextInset(8, 0)
	self.takeBtn:SizeToContents()
	self.takeBtn.Paint = self.moneyBtn.Paint
	self.takeBtn.DoClick = function()
		local storage = ix.gui.openedStorage

		if (IsValid(storage) and IsValid(ix.gui.inv1)) then
			local inventory = ix.item.inventories[storage.storageInventory.invID]
			local noItems

			if (!inventory or table.IsEmpty(inventory:GetItems(true))) then
				noItems = true
			end

			local charInventory = LocalPlayer():GetCharacter():GetInventory()
			if (charInventory:GetFilledSlotCount() >= charInventory.w * charInventory.h) then
				noItems = true
			end

			if (noItems and storage.storageMoney:GetMoney() == 0) then
				return
			end

			net.Start("ixStorageTakeAll")
				net.WriteUInt(storage.storageID, 32)
				net.WriteBool(!noItems)
			net.SendToServer()
		end
	end

	self.bNoBackgroundBlur = true
end

function PANEL:SetMoney(money)
	self.money = math.max(math.Round(tonumber(money) or 0), 0)
	self.moneyBtn:SetText(ix.currency.Get(money))
end

function PANEL:OnTransfer(amount, code) end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintBaseFrame", self, width, height)
end

vgui.Register("ixStorageMoneyItems", PANEL, "EditablePanel")