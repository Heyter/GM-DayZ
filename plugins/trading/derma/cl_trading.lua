local PANEL = {}

AccessorFunc(PANEL, "money", "Money", FORCE_NUMBER)

function PANEL:Init()
	self:DockPadding(1, 1, 1, 1)
	self:SetTall(64)
	self:Dock(BOTTOM)

	self.moneyLabel = self:Add("DLabel")
	self.moneyLabel:Dock(TOP)
	self.moneyLabel:SetFont("ixGenericFont")
	self.moneyLabel:SetText("")
	self.moneyLabel:SetTextInset(2, 0)
	self.moneyLabel:SizeToContents()
	self.moneyLabel.Paint = function(panel, width, height)
		derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, ix.config.Get("color"))
	end

	self.amountEntry = self:Add("ixTextEntry")
	self.amountEntry:Dock(FILL)
	self.amountEntry:SetFont("ixGenericFont")
	self.amountEntry:SetNumeric(true)
	self.amountEntry:SetValue("0")

	self.takeButton = self:Add("DButton")
	self.takeButton:SetFont("ixIconsMedium")
	self.takeButton:Dock(LEFT)
	self.takeButton:SetText("s")
	self.takeButton.DoClick = function(this)
		local amount = math.max(0, math.Round(tonumber(self.amountEntry:GetValue()) or 0))
		self.amountEntry:SetValue("0")

		if (self.takeButton.TakeButton) then
			self.takeButton:TakeButton(amount)
		else
			if (amount != 0 and self:GetMoney() > 0) then
				net.Start("ixTradeMoneyGive")
					net.WriteUInt(amount, 32)
				net.SendToServer()
			end
		end
	end

	self.giveButton = self:Add("DButton")
	self.giveButton:SetFont("ixIconsMedium")
	self.giveButton:Dock(LEFT)
	self.giveButton:SetText("t")
	self.giveButton.DoClick = function(this)
		local amount = math.max(0, math.Round(tonumber(self.amountEntry:GetValue()) or 0))
		self.amountEntry:SetValue("0")

		if (self.giveButton.GiveButton) then
			self.giveButton:GiveButton(amount)
		else
			if (amount != 0 and LocalPlayer():GetCharacter():GetMoney() > 0) then
				net.Start("ixTradeMoneyTake")
					net.WriteUInt(amount, 32)
				net.SendToServer()
			end
		end
	end

	self.giveButton:SetTooltip(L"deposit")
	self.takeButton:SetTooltip(L"withdraw")

	self.bNoBackgroundBlur = true
end

function PANEL:SetMoney(money)
	self.money = math.max(math.Round(tonumber(money) or 0), 0)
	self.moneyLabel:SetText(ix.currency.Get(money))
end

function PANEL:OnTransfer(amount)
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintBaseFrame", self, width, height)
end

function PANEL:ViewOnly()
	self.giveButton:Remove()
	self.takeButton:Remove()
	self.amountEntry:Remove()
	self:SetTall(24)
	self.moneyLabel:Dock(FILL)
end

vgui.Register("ixTradeMoney", PANEL, "EditablePanel")

DEFINE_BASECLASS("Panel")
PANEL = {}

AccessorFunc(PANEL, "fadeTime", "FadeTime", FORCE_NUMBER)
AccessorFunc(PANEL, "frameMargin", "FrameMargin", FORCE_NUMBER)

PANEL.cGray = ColorAlpha(color_white, 20)
PANEL.cRed = Color(150, 50, 50, 200)
PANEL.cGreen = Color(99,137,41)

function PANEL:Init()
	if (IsValid(ix.gui.tradeMenu)) then
		ix.gui.tradeMenu:Remove()
	end

	ix.gui.tradeMenu = self

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:SetFadeTime(0.25)
	self:SetFrameMargin(4)

	self.storageInventory = self:Add("ixInventory")
	self.storageInventory.bNoBackgroundBlur = true
	self.storageInventory:ShowCloseButton(true)
	self.storageInventory:SetTitle("")
	self.storageInventory.Close = function(this)
		net.Start("ixTradeCancel")
		net.SendToServer()

		self:Remove()
	end

	self.confirmPanel = self.storageInventory:Add("Panel")
	self.confirmPanel.confirmTrade = false
	self.confirmPanel:Dock(BOTTOM)
	self.confirmPanel.Paint = function(this, width, height)
		if (this.confirmTrade) then
			surface.SetDrawColor(self.cGreen)
			surface.DrawRect(0, 4, width, height)

			ix.util.DrawText("Ready to trade.", width / 2, 4, color_white, TEXT_ALIGN_CENTER)
		else
			surface.SetDrawColor(self.cGray)
			surface.DrawRect(0, 4, width, height)

			ix.util.DrawText("Not ready to trade.", width / 2, 4, color_white, TEXT_ALIGN_CENTER)
		end
	end

	self.storageMoney = self.storageInventory:Add("ixTradeMoney")
	self.storageMoney:ViewOnly()
	self.storageMoney:SetVisible(false)

	ix.gui.inv1 = self:Add("ixInventory")
	ix.gui.inv1.bNoBackgroundBlur = true
	ix.gui.inv1:ShowCloseButton(true)
	ix.gui.inv1.Close = function(this)
		net.Start("ixTradeCancel")
		net.SendToServer()

		self:Remove()
	end

	-- Anim confirmButton vars --
	self.value = 0
	self.deltaValue = self.value
	self.max = 15

	self.confirmButton = ix.gui.inv1:Add("DButton")
	self.confirmButton:SetFont("ixGenericFont")
	self.confirmButton:SetTall(32)
	self.confirmButton:Dock(BOTTOM)
	self.confirmButton:SetText("")
	self.confirmButton.Reset = function(this)
		this:SetEnabled(true)
		this:SetTooltip("Hold this button when ready to trade.")
		this:SetCursor("hand")
	end
	self.confirmButton:Reset()
	self.confirmButton.Paint = function(this, w, h)
		if (!this:GetDisabled()) then 
			surface.SetDrawColor(self.cRed)
			surface.DrawRect(2, 2, w - 4, h - 4)

			local value = self.deltaValue / self.max

			if (value > 0) then
				local color = Color(50, 150, 50, 255)
				local add = 0

				if (self.deltaValue != self.value) then
					add = 35
				end

				do
					surface.SetDrawColor(color.r + add, color.g + add, color.b + add, 230)
					surface.DrawRect(2, 2, w * value - 4, h - 4)
				end
			end

			ix.util.DrawText("Accept", w / 2, 5, color_white, TEXT_ALIGN_CENTER)
		else
			surface.SetDrawColor(self.cGreen)
			surface.DrawRect(2, 2, w - 4, h - 4)

			ix.util.DrawText("Accepted", w / 2, 5, color_white, TEXT_ALIGN_CENTER)
		end
	end

	self.confirmButton.OnMousePressed = function(this)
		if (!this:GetDisabled()) then
			self.pressing = 1
			self:DoChange()
			this:SetAlpha(150)
		end
	end

	self.confirmButton.OnMouseReleased = function(this)
		if (self.pressing) then
			self.pressing = nil

			if (self.deltaValue == self.max) then
				this:SetEnabled(false)
				this:SetCursor("no")
				this:SetTooltip(nil)

				net.Start("ixTradeConfirm")
				net.SendToServer()
			end

			self.value = 0
			self.deltaValue = self.value

			this:SetAlpha(255)
		end
	end
	self.confirmButton.OnCursorExited = self.confirmButton.OnMouseReleased

	self.localMoney = ix.gui.inv1:Add("ixTradeMoney")
	self.localMoney:SetVisible(false)

	self:SetAlpha(0)
	self:AlphaTo(255, self:GetFadeTime())

	self.storageInventory:MakePopup()
	ix.gui.inv1:MakePopup()
end

function PANEL:Think()
	if (self.pressing) then
		if ((self.nextPress or 0) < CurTime()) then
			self:DoChange()
		end
	end

	self.deltaValue = math.Approach(self.deltaValue, self.value, FrameTime() * 15)
end

function PANEL:DoChange()
	if (self.value == self.max and self.pressing == 1) then
		return
	end

	self.nextPress = CurTime() + 0.02
	self.value = math.Clamp(self.value + self.pressing, 0, self.max)
end

function PANEL:OnChildAdded(panel)
	panel:SetPaintedManually(true)
end

function PANEL:SetLocalInventory(inventory)
	if (IsValid(ix.gui.inv1) and !IsValid(ix.gui.menu)) then
		ix.gui.inv1:SetInventory(inventory)
		ix.gui.inv1:SetPos(self:GetWide() / 2 + self:GetFrameMargin() / 2, self:GetTall() / 2 - ix.gui.inv1:GetTall() / 2)
	end
end

function PANEL:SetLocalMoney(money)
	if (!self.localMoney:IsVisible()) then
		self.localMoney:SetVisible(true)
		ix.gui.inv1:SetTall(ix.gui.inv1:GetTall() + self.localMoney:GetTall() + self.confirmButton:GetTall() + 2)
	end

	self.localMoney:SetMoney(money)
end

function PANEL:SetStorageTitle(title)
	self.storageInventory:SetTitle(title)
end

function PANEL:SetStorageInventory(inventory)
	self.storageInventory:SetInventory(inventory)
	self.storageInventory:SetPos(
		self:GetWide() / 2 - self.storageInventory:GetWide() - 2,
		self:GetTall() / 2 - self.storageInventory:GetTall() / 2
	)

	ix.gui["inv" .. inventory:GetID()] = self.storageInventory
end

function PANEL:SetStorageMoney(money)
	if (!self.storageMoney:IsVisible()) then
		self.storageMoney:SetVisible(true)
		self.storageInventory:SetTall(self.storageInventory:GetTall() + self.storageMoney:GetTall() + self.confirmPanel:GetTall() + 2)
	end

	self.storageMoney:SetMoney(money)
end

function PANEL:Paint(width, height)
	ix.util.DrawBlurAt(0, 0, width, height)

	for _, v in ipairs(self:GetChildren()) do
		v:PaintManual()
	end
end

function PANEL:Remove()
	self:SetAlpha(255)
	self:AlphaTo(0, self:GetFadeTime(), 0, function()
		BaseClass.Remove(self)
	end)
end

function PANEL:OnRemove()
	if (!IsValid(ix.gui.menu)) then
		self.storageInventory:Remove()
		ix.gui.inv1:Remove()
	end
end

vgui.Register("ixTradeView", PANEL, "Panel")