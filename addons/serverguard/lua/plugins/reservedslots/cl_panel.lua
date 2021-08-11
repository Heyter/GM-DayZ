--[[
	© 2018 Thriving Ventures AB do not share, re-distribute or modify
	
	without permission of its author (gustaf@thrivingventures.com).
]]

local category = {}
category.name = "Reserved slots"
category.material = "serverguard/menuicons/icon_reserved_slots.png"
category.permissions = "Manage Reserved Slots"

function category:Create(base)
	local config = serverguard.config.stored["reservedslots"]

    base.panel = base:Add("tiger.panel")
    base.panel:SetTitle("Slot reservation")
    base.panel:Dock(FILL)
    local configList = base.panel:Add("tiger.list")
    configList:SetTall(64)
    configList:Dock(TOP)
    local shouldShowReal = vgui.Create("tiger.checkbox")
    configList:AddPanel(shouldShowReal)
    shouldShowReal:Dock(TOP)
    shouldShowReal:SetText("Hide reserved slots")
    shouldShowReal:BindToConfig("reservedslots", "hide")
    local slotsReserved = base.panel:Add("tiger.numslider")
    configList:AddPanel(slotsReserved)
    slotsReserved:Dock(TOP)
    slotsReserved:SetText("Amount of reserved slots")
    slotsReserved:SetMinMax(1, game.MaxPlayers() - 1)
    slotsReserved:SetClampValue(true)
    slotsReserved:SetValue(1)
    slotsReserved:BindToConfig("reservedslots", "slots", true)

	base.panel.list = base.panel:Add("tiger.list")
	base.panel.list:Dock(FILL)
	base.panel.list:AddColumn("NAME", 400)

	function base.panel:PerformLayout()
		category.list = base.panel.list
	end

	local column = base.panel.list:AddColumn("ENABLED")
	column:SetDisabled(true)

	local ranks = serverguard.ranks:GetTable()
	for unique, data in pairs(ranks) do
		local panel = base.panel.list:AddItem(data.name)
		local toggleButton = vgui.Create("DImageButton")
		toggleButton:SetSize(16, 16)
		toggleButton:SetImage("icon16/accept.png")
		toggleButton.unique = unique

		function toggleButton:DoClick()
			if (serverguard.player:HasPermission(LocalPlayer(), "Manage Reserved Slots")) then
				local data = config:GetValue("ranks") or {}

				if (data[self.unique]) then
					data[self.unique] = nil
				else
					data[self.unique] = true
				end

				config:SetValue("ranks", data)
			end
		end

		function toggleButton:Think()
			local data = config:GetValue("ranks") or {}

			if (data[self.unique]) then
				if (self:GetImage() == "icon16/cancel.png") then
					self:SetImage("icon16/accept.png")
				end
			else
				if (self:GetImage() == "icon16/accept.png") then
					self:SetImage("icon16/cancel.png")
				end
			end
		end

		function toggleButton:PerformLayout()
			DImageButton.PerformLayout(self)
			local w, h = self:GetSize()
			local column = panel:GetThing(2).column
			local x = column:GetPos()
			self:SetPos(x + column:GetWide() / 2 - w / 2, column:GetTall() / 2 - h / 2)
		end

        local rankLabel = panel:GetLabel(1)
        rankLabel:SetColor(data.color)
        rankLabel.oldColor = data.color

		panel:AddItem(toggleButton)
	end
end

serverguard.menu.AddSubCategory("Server settings", category)