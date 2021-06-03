function Schema:EntityRemoved(vehicle)
	if (vehicle.loopSound and vehicle.loopSound:IsPlaying()) then
		vehicle.loopSound:Stop()
	end
end

-- function Schema:ShouldDrawCrosshair()
	-- local weapon = LocalPlayer():GetActiveWeapon()

	-- if (IsValid(weapon) and weapon.ArcCW) then
		-- return false
	-- end
-- end

-- Restrict Business.
function Schema:BuildBusinessMenu()
	return false
end

-- Sandbox stuff
function Schema:ContextMenuOpen()
	return LocalPlayer():IsSuperAdmin()
end

function Schema:IsCharacterRecognized()
	return true
end

--function Schema:PopulateCharacterInfo(client, character, container)
	--local countryIcon = ix.geoip:GetMaterial(client) or Material("flags16/ru.png", "noclamp smooth")

	-- if (countryIcon) then
		-- local name = container:GetRow("name")
		-- name:SetTextInset(Schema.countryIcon.w + 8, 0)
		-- name:SizeToContents()

		-- name.Paint = function(panel, width, height)
			-- panel:PaintBackground(width, height)

			-- surface.SetMaterial(countryIcon)
			-- surface.SetDrawColor(color_white)
			-- surface.DrawTexturedRect(4, height * 0.5 - Schema.countryIcon.h * 0.5, Schema.countryIcon.w, Schema.countryIcon.h)
		-- end
	-- end
--end

function Schema:PopulateImportantCharacterInfo(client, character, container)
	container.health = client:Health()
	container:SetArrowColor(ix.config.Get("color"))

	-- name
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText(client:GetName())
	name:SetBackgroundColor(ix.util.GetInjuredColor(client))
	name:SizeToContents()

	local countryIcon = ix.geoip:GetMaterial(client)

	if (countryIcon) then
		local offset = Schema.countryIcon.w

		if (ix.option.Get("minimalTooltips", false)) then
			offset = offset * 2 + 16
		else
			offset = offset + 8
		end

		name:SetTextInset(offset, 0)
		name:SizeToContents()
		name.Paint = function(panel, width, height)
			panel:PaintBackground(width, height)

			surface.SetMaterial(countryIcon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(4, height * 0.5 - Schema.countryIcon.h * 0.5, Schema.countryIcon.w, Schema.countryIcon.h)
		end
	end

	-- reputation
	local repData = Schema.ranks[client:GetReputationLevel()] or Schema.ranks[0]

	if (repData[1] != Schema.ranks[0][1]) then
		local rep = container:AddRow("reputation")
		rep:SetImportant()
		rep:SetText(L(repData[1]))
		rep:SetBackgroundColor(repData[2])
		rep:SizeToContents()
	end
end

function ix.hud.PopulateItemTooltip(tooltip, item)
	local text = item.GetName and item:GetName() or L(item.name)

	if (IsValid(item.entity)) then
		local quantity = item:GetData("quantity", 1)
		tooltip.quantity = quantity
		tooltip.item_name = text

		if (quantity >= 2) then
			text = Format("%s (x%d)", text, quantity)
		end
	end

	local panel = tooltip:AddRow("name")
	panel:SetImportant()
	panel:SetText(text)
	panel:SetMaxWidth(math.max(panel:GetMaxWidth(), ScrW() * 0.5))
	panel:SetTextColor(color_white)
	panel:SizeToContents()

	if (!IsValid(item.entity)) then
		panel = tooltip:AddRow("description")
		panel:SetBackgroundColor(color_black)
		panel:SetText(item:GetDescription() or "")
		panel:SizeToContents()
	end

	if (item.PopulateTooltip) then
		item:PopulateTooltip(tooltip)
	end

	hook.Run("PopulateItemTooltip", tooltip, item)
end

do
	local aimLength = 0.15
	local aimTime = 0
	local aimEntity
	local lastEntity
	local lastTrace = {}

	timer.Create("ixCheckTargetEntity", 0.1, 0, function()
		local client = LocalPlayer()
		local time = SysTime()

		if (!IsValid(client)) then
			return
		end

		local character = client:GetCharacter()

		if (!character) then
			return
		end

		lastTrace.start = client:GetShootPos()
		lastTrace.endpos = lastTrace.start + client:GetAimVector(client) * 160
		lastTrace.filter = client
		lastTrace.mask = MASK_SHOT_HULL

		lastEntity = util.TraceHull(lastTrace).Entity

		if (lastEntity != aimEntity) then
			aimTime = time + aimLength
			aimEntity = lastEntity
		end

		local panel = ix.gui.entityInfo
		local bShouldShow = time >= aimTime and (!IsValid(ix.gui.menu) or ix.gui.menu.bClosing) and
			(!IsValid(ix.gui.characterMenu) or ix.gui.characterMenu.bClosing)
		local bShouldPopulate = lastEntity.OnShouldPopulateEntityInfo and lastEntity:OnShouldPopulateEntityInfo() or true

		if (bShouldShow and IsValid(lastEntity) and hook.Run("ShouldPopulateEntityInfo", lastEntity) != false and
			(lastEntity.PopulateEntityInfo or bShouldPopulate)) then

			if (!IsValid(panel) or (IsValid(panel) and panel:GetEntity() != lastEntity)) then
				if (IsValid(ix.gui.entityInfo)) then
					ix.gui.entityInfo:Remove()
				end

				local infoPanel = vgui.Create(ix.option.Get("minimalTooltips", false) and "ixTooltipMinimal" or "ixTooltip")
				local entityPlayer = lastEntity:GetNetVar("player")

				if (entityPlayer) then
					infoPanel:SetEntity(entityPlayer)
					infoPanel.entity = lastEntity
				else
					infoPanel:SetEntity(lastEntity)
				end

				infoPanel:SetDrawArrow(true)
				ix.gui.entityInfo = infoPanel
			end
		elseif (IsValid(panel)) then
			panel:Remove()
		end
	end)
end

local panel
function Schema:ShouldPopulateEntityInfo(lastEntity)
	panel = ix.gui.entityInfo

	if (IsValid(panel) and panel:GetEntity() == lastEntity) then
		local name = panel:GetRow("name")

		if (IsValid(name)) then
			if (panel.health and panel.health != lastEntity:Health()) then
				panel.health = lastEntity:Health()
				name:SetBackgroundColor(ix.util.GetInjuredColor(lastEntity))
			end
		end
	end
end

-- Stack hooks
function Schema:CreateItemInteractionMenu(iconPanel, _, item)
	if (input.IsControlDown() and item.isStackable) then
		local quantity = item:GetData("quantity", 1)
		local inventory = ix.inventory.Get(item.invID)

		if (item.ammoAmount and quantity <= 1) then
			quantity = item:GetData("rounds", item.ammoAmount)
		end

		iconPanel.entry = vgui.Create("ixRowNumberEntry")
		iconPanel.entry:Attach(iconPanel)
		iconPanel.entry:SetValue(math.ceil(quantity / 2), true)
		iconPanel.entry.OnValueChanged = function(t)
			local value = math.Round(t:GetValue(), 0)

			if (value == 0 or quantity <= 1 or value == quantity) then return end
			if (!inventory or !item) then return end

			if (!inventory:CanItemFitStack(item, true)) then
				local panel = ix.gui["inv" .. inventory:GetID()]
				local invW, invH = inventory:GetSize()
				local x2, y2

				for x = 1, invW do
					for y = 1, invH do
						if (!IsValid(panel)) then break end
						if (panel:IsAllEmpty(x, y, item.width, item.height)) then
							x2 = x
							y2 = y
						end
					end
				end

				if !(x2 and y2) then
					LocalPlayer():NotifyLocalized("noFit")
					return
				end
			end

			net.Start(item.ammoAmount and "ixArcCWAmmoSplit" or "ixItemSplit")
				net.WriteUInt(item.id, 32)
				net.WriteUInt(value, 32)
			net.SendToServer()
		end

		return true
	end
end