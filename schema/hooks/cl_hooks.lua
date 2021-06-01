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
	local health_color = ix.util.GetInjuredColor(client)

	container:SetArrowColor(ix.config.Get("color"))

	-- name
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText(client:GetName())
	name:SetBackgroundColor(health_color)
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
		panel:SetText(item and item:GetDescription() or "")
		panel:SizeToContents()
	end

	if (item.PopulateTooltip) then
		item:PopulateTooltip(tooltip)
	end

	hook.Run("PopulateItemTooltip", tooltip, item)
end