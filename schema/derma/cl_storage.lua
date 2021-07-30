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
	self.moneyBtn.Paint = function(panel, width, height)
		panel.set_color = ix.config.Get("color")

		if (panel:GetDisabled()) then
			panel.set_color = panel.set_color:Darken(50)
		elseif (panel.Depressed) then
			panel.set_color = panel.set_color:Darken(35)
		elseif (panel.Hovered) then
			panel.set_color = panel.set_color:Darken(25)
		end

		surface.SetDrawColor(panel.set_color)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, width, height)

		surface.SetDrawColor(180, 180, 180, 2)
		surface.DrawOutlinedRect(1, 1, width - 2, height - 2)
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
		if (IsValid(ix.gui.openedStorage) and ix.gui.openedStorage.storageID) then
			net.Start("ixStorageTakeAll")
				net.WriteUInt(ix.gui.openedStorage.storageID, 32)
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