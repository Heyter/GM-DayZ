PLUGIN.name = "Entity Info"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (CLIENT) then
	local PLUGIN = PLUGIN
	local notShouldEnts = {
		["ix_item"] = true,
		["ix_money"] = true
	}

	local lastEntity
	function PLUGIN:ShouldPopulateEntityInfo(entity)
		if (notShouldEnts[entity:GetClass()]) then
			return false
		end
	end

	local rangeSize, angleCos = 200, math.cos(math.rad(90))
	local client

	function PLUGIN:HUDPaint()
		client = LocalPlayer()

		self.Trace = {
			start = client:GetShootPos(),
			endpos = true,
			filter = client,
		}

		local noticeHeight = draw.GetFontHeight("ixNoticeFont")
		local entities = ents.FindInCone(self.Trace.start, client:GetAimVector(), rangeSize, angleCos)

		for _, entity in ipairs(entities) do
			if (IsValid(entity) and entity.GetItemTable and notShouldEnts[entity:GetClass()]) then
				self.Trace.endpos = entity:WorldSpaceCenter()
				local iSeeEntity = util.TraceLine(self.Trace).Entity == entity

				local itemTable = entity:GetItemTable()
				local itemName = (itemTable.GetName and itemTable:GetName() or itemTable.name) or ""

				if (itemTable.isStackable) then
					local quantity = entity:GetData("quantity", 1)

					if (quantity >= 2) then
						itemName = Format("%s (x%d)", itemName, quantity)
					end
				elseif (itemTable.ammoAmount) then
					itemName = Format("%s (%d)", itemName, entity:GetData("rounds", itemTable.ammoAmount))
				end

				local x, y
				local lastEntity = client:GetTrace(160, 2).Entity

				if (lastEntity and lastEntity == entity) then
					x, y = ScrW() / 2, ScrH() / 2
					iSeeEntity = true
				else
					local position = entity:LocalToWorld(entity:OBBCenter())
					x, y = position:ToScreen().x, position:ToScreen().y
				end

				if !(x and y) or !iSeeEntity then continue end

				draw.SimpleTextOutlined(itemName, "ixNoticeFont",
					x, y-(noticeHeight/2), color_white, 1, 1, 1, color_black
				)

				if (itemTable.useDurability) then
					local index = 1
					local mods = entity:GetData("mods", {})

					if (!table.IsEmpty(mods)) then
						local text = {}

						for _, itemID in pairs(mods) do
							local item = ix.item.list[itemID]

							text[#text + 1] = (item and item.name) or itemID
						end

						text = table.concat(text, " + ")

						if (isstring(text)) then
							local modsText = ix.util.WrapText(text, 300, "ixNoticeFont")

							for i, _ in pairs(modsText) do
								draw.SimpleTextOutlined(modsText[i], "ixNoticeFont", x, y+(noticeHeight*i)-(noticeHeight/2), Color("orange"), 1, 1, 1, color_black)
								index = index + 1
							end
						end
					end

					local maxD = itemTable.defDurability or 100
					local durability = math.max(0, entity:GetData("durability", maxD))
					durability = (durability / maxD) * 100
					local durabilityColor = Color(2.55 * (100 - durability), 2.55 * durability, 0, 255)

					draw.SimpleTextOutlined(math.Round(durability, 1) .. "%", "ixNoticeFont", x, y+(noticeHeight*index)-(noticeHeight/2), durabilityColor, 1, 1, 1, color_black)
				end
			elseif (IsValid(entity) and (entity:GetClass() == "ix_money" or entity:GetClass() == "gmodz_npc_loot")) then
				local x, y
				local lastEntity = client:GetTrace(160, 2).Entity

				if (lastEntity and lastEntity == entity) then
					x, y = ScrW() / 2, ScrH() / 2
				else
					local position = entity:LocalToWorld(entity:OBBCenter())
					x, y = position:ToScreen().x, position:ToScreen().y
				end

				if !(x and y) then continue end
				local name = ""

				if (entity:GetClass() == "ix_money") then
					name = ix.currency.Get(entity:GetAmount()) or ""
				elseif (entity:GetClass() == "gmodz_npc_loot") then
					name = "Loot"
				end

				if (#name > 0) then
					draw.SimpleTextOutlined(name, "ixNoticeFont",
						x, y-(noticeHeight/2), color_white, 1, 1, 1, color_black
					)
				end
			end
		end
	end
end