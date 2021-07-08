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

	self.storageMoney = self.storageInventory:Add("ixStashMoney")
	self.storageMoney:SetVisible(false)
	self.storageMoney:SetTooltip("RMB - take all the money")
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
	self.localMoney:SetTooltip("RMB - give all the money")
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