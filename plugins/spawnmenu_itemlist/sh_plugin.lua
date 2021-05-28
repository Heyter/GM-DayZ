PLUGIN.name = "Item List"
PLUGIN.author = "Schwarz Kruppzo"
PLUGIN.description = "Adds a Q-menu tab for all items."

cleanup.Register("ixItems")

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	local PLUGIN = PLUGIN

	local icons = {
		["Ammunition"] = "attach",
		["Armored Clothing"] = "shield",
		["Cards"] = "vcard",
		["Clothing"] = "user_suit",
		["Communication"] = "transmit",
		["Consumables"] = "cake",
		["Crafting"] = "add",
		["Deployables"] = "arrow_down",
		["Filters"] = "weather_clouds",
		["Gasmasks"] = "user_gray",
		["Ingredients"] = "package_add",
		["Junk"] = "bin_closed",
		["Literature"] = "book",
		["Medical"] = "heart_add",
		["Miscellaneous"] = "box",
		["Outfit"] = "user_add",
		["Permits"] = "report",
		["Raw Materials"] = "cog",
		["Remains"] = "bullet_red",
		["Reusables"] = "arrow_rotate_clockwise",
		["Storage"] = "briefcase",
		["Union Branded Items"] = "asterisk_yellow",
		["Tools"] = "wrench_orange",
		["Weapons"] = "gun"
	}

	local function DrawBox( bordersize, x, y, w, h, bordercol )
		surface.SetDrawColor( bordercol )
		surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
		surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
		surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
		surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
	end

	spawnmenu.AddContentType("ixItem", function(container, data)
		if (!data.name) then return end

		local backGround = vgui.Create("Panel", container)
		backGround:SetSize(100, 100)
		backGround.Paint = function(s, w, h)
			if (IsValid(backGround.icon)) then
				DrawBox(0, 0, 0, w, h, backGround.icon:IsHovered() and Color("green") or color_black)
			end
		end

		local icon = backGround:Add('SpawnIcon')
		backGround.icon = icon

		icon:SetSize(92, 92 * 1.4)
		icon:SetZPos(1)
		icon:Dock(FILL)
		icon:DockMargin(5, 5, 5, 10)
		icon:InvalidateLayout(true)
		icon:SetModel(data.model)

		icon:SetHelixTooltip(function(tooltip)
			ix.hud.PopulateItemTooltip(tooltip, data)
		end)

		icon.OnMousePressed = function(this, code)
			if (code == MOUSE_LEFT) then
				net.Start("MenuItemSpawn")
					net.WriteString(data.uniqueID)
				net.SendToServer()

				surface.PlaySound("ui/buttonclickrelease.wav")
			elseif (code == MOUSE_RIGHT) then
				local menu = DermaMenu()

				menu:AddOption("Copy to Clipboard", function()
					SetClipboardText(data.uniqueID)
				end)

				menu:AddOption("Give to Self", function()
					net.Start("MenuItemGive")
						net.WriteString(data.uniqueID)
					net.SendToServer()
				end)

				menu:Open()			
			end
		end

		if (IsValid(container)) then
			container:Add(backGround)
		end

		return backGround
	end)

	spawnmenu.AddCreationTab("Items", function()
		local base = vgui.Create("SpawnmenuContentPanel")
		local tree = base.ContentNavBar.Tree
		local categories = {}

		vgui.Create("ItemSearchBar", base.ContentNavBar)

		for _, v in SortedPairsByMemberValue(ix.item.list, "category") do
			if (!categories[v.category]) then
				categories[v.category] = true

				local node = tree:AddNode(L(v.category), icons[v.category] and ("icon16/" .. icons[v.category] .. ".png") or "icon16/brick.png")

				node.DoPopulate = function(self)
					if (self.Container) then return end

					self.Container = vgui.Create("ContentContainer", base)
					self.Container:SetVisible(false)
					self.Container:SetTriggerSpawnlistChange(false)

					for _, itemTable in SortedPairsByMemberValue(ix.item.list, "name") do
						if (itemTable.category == v.category) then
							spawnmenu.CreateContentIcon("ixItem", self.Container, itemTable)
						end
					end
				end

				node.DoClick = function(self)
					self:DoPopulate()
					base:SwitchPanel(self.Container)
				end
			end
		end

		local FirstNode = tree:Root():GetChildNode(0)

		if (IsValid(FirstNode)) then
			FirstNode:InternalDoClick()
		end

		PLUGIN:PopulateContent(base, tree, nil)

		return base
	end, "icon16/script_key.png")

	timer.Simple(0, function()
		RunConsoleCommand("spawnmenu_reload")
	end)
end