PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.name = "Hide spawn menu tabs"
PLUGIN.description = ""

if (SERVER) then return end

function PLUGIN:SpawnMenuOpen()
	if (LocalPlayer():IsSuperAdmin()) then
		return true
	end

	if (IsValid(g_SpawnMenu.CreateMenu)) then
		-- for _, v in pairs(g_SpawnMenu.CreateMenu.Items) do
			-- if (v.Name != "#spawnmenu.content_tab") then
				-- g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
			-- else
				-- local spawnlists = v.Panel:GetChildren()[1].ContentNavBar.Tree.RootNode.ChildNodes:GetChildren()
				-- for _, v2 in pairs(spawnlists) do
					-- v2:Remove()
				-- end
			-- end
		-- end

		--table.Empty(spawnmenu.GetCreationTabs())
		g_SpawnMenu.CreateMenu:Remove()
	end

	-- Tools
	for _, v in pairs(g_SpawnMenu.ToolMenu.Items) do
		if (v.Name == "#spawnmenu.tools_tab") then
			g_SpawnMenu.ToolMenu:CloseTab(v.Tab, true)
			break
		end
	end
end