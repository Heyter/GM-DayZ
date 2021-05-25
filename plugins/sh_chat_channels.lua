PLUGIN.name = "Chat Channels"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

do
	CAMI.RegisterPrivilege({
		Name = "Helix - Bypass TradeChat Timer",
		MinAccess = "admin"
	})

	ix.config.Add("tradeChatDelay", 60, "The delay before a player can use Trade chat again in seconds.", nil, {
		data = {min = 0, max = 10000},
		category = "chat"
	})

	if (CLIENT) then
		function ix.chat.GetPlayerIcon(speaker)
			local icon = ""

			if (speaker:IsSuperAdmin()) then
				icon = "icon16/shield.png"
			elseif (speaker:IsAdmin()) then
				icon = "icon16/star.png"
			elseif (speaker:IsUserGroup("moderator") or speaker:IsUserGroup("operator")) then
				icon = "icon16/wrench.png"
			elseif (speaker:IsUserGroup("vip") or speaker:IsUserGroup("donator") or speaker:IsUserGroup("donor")) then
				icon = "icon16/heart.png"
			end

			return hook.Run("GetPlayerIcon", speaker) or icon
		end
	end
end

local function RemoveChatClasses(key)
	local class = ix.chat.classes[key]

	if (CLIENT and class.prefix) then
		print(type(class.prefix))
		if (istable(class.prefix)) then
			for _, v in ipairs(class.prefix) do
				if (v:utf8sub(1, 1) == "/") then
					ix.command.list[v:utf8sub(2):lower()] = nil
				end
			end
		elseif (isstring(class.prefix)) then
			ix.command.list[class.prefix:utf8sub(2):lower()] = nil
		end
	end

	ix.chat.classes[key] = nil
	class = nil
end

function PLUGIN:InitializedChatClasses()
	local clr_gray = color_white:Darken(100)

	RemoveChatClasses("me")
	RemoveChatClasses("it")
	RemoveChatClasses("roll")
	RemoveChatClasses("looc")

	ix.chat.classes["pm"].deadCanChat = nil

	ix.chat.Register("ic", {
		indicator = "chatTalking",
		OnChatAdd = function(self, speaker, text)
			local name = IsValid(speaker) and speaker:Name() or "Console"
			local name_color = IsValid(speaker) and hook.Run("GetPlayerColorSB", speaker) or color_white
			local icon = IsValid(speaker) and ix.chat.GetPlayerIcon(speaker) or ""

			if (#icon > 0) then
				chat.AddText(Color(0, 150, 255), L"localChatPrefix", ix.util.GetMaterial(icon), clr_gray, name .. ": ", name_color, text)
			else
				chat.AddText(Color(0, 150, 255), L"localChatPrefix", clr_gray, name .. ": ", name_color, text)
			end
		end,
		CanHear = ix.config.Get("chatRange", 280),
		noSpaceAfter = true
	})

	ix.chat.Register("ooc", {
		CanSay = function(self, speaker, text)
			-- contains non latin letters
			if (text:match("[^%c%p%s%w]") != nil) then
				speaker:NotifyLocalized("onlyEnglishLetters")
				return false
			end

			if (!ix.config.Get("allowGlobalOOC")) then
				speaker:NotifyLocalized("Global OOC is disabled on this server.")
				return false
			else
				local delay = ix.config.Get("oocDelay", 10)

				if (delay > 0 and speaker.ixLastOOC) then
					local lastOOC = CurTime() - speaker.ixLastOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:NotifyLocalized("oocDelay", delay - math.ceil(lastOOC))

						return false
					end
				end

				speaker.ixLastOOC = CurTime()
			end
		end,
		OnChatAdd = function(self, speaker, text)
			local name = IsValid(speaker) and speaker:Name() or "Console"
			local name_color = IsValid(speaker) and hook.Run("GetPlayerColorSB", speaker) or color_white
			local icon = IsValid(speaker) and ix.chat.GetPlayerIcon(speaker) or ""

			if (#icon > 0) then
				chat.AddText(Color("green"), L"globalChatPrefix", ix.util.GetMaterial(icon), clr_gray, name .. ": ", name_color, text)
			else
				chat.AddText(Color("green"), L"globalChatPrefix", clr_gray, name .. ": ", name_color, text)
			end
		end,
		prefix = {"//", "/OOC"},
		description = "@cmdOOC",
		noSpaceAfter = true
	})

	ix.chat.Register("trade", {
		CanSay = function(self, speaker, text)
			if (!IsValid(speaker)) then
				return false
			else
				local delay = ix.config.Get("tradeChatDelay", 10)

				if (delay > 0 and speaker.ixLastTradeChat) then
					local lastTrade = CurTime() - speaker.ixLastTradeChat

					if (lastTrade <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass TradeChat Timer", nil)) then
						speaker:NotifyLocalized("tradeChatDelay", delay - math.ceil(lastTrade))

						return false
					end
				end

				speaker.ixLastTradeChat = CurTime()
			end
		end,
		OnChatAdd = function(self, speaker, text)
			local name = IsValid(speaker) and speaker:Name() or "Console"
			local icon = IsValid(speaker) and ix.chat.GetPlayerIcon(speaker) or ""

			if (#icon > 0) then
				chat.AddText(Color(255, 200, 50), L"tradeChatPrefix", ix.util.GetMaterial(icon), clr_gray, name .. ": ", color_white, text)
			else
				chat.AddText(Color(255, 200, 50), L"tradeChatPrefix", clr_gray, name .. ": ", color_white, text)
			end
		end,
		description = "@cmdTradeChat",
		noSpaceAfter = true
	})

	ix.chat.classes["connect"].OnChatAdd = function(self, speaker, text)
		print(speaker, text)
		local icon = ix.util.GetMaterial("icon16/user_add.png")
		local countryIcon = nil

		for _, v in ipairs(player.GetAll()) do
			if (v:SteamName() == text) then
				countryIcon = ix.geoip:GetMaterial(v)
				break
			end
		end

		if (countryIcon) then
			chat.AddText(icon, Color(150, 150, 200), L("playerConnected", text, countryIcon))
		else
			chat.AddText(icon, Color(150, 150, 200), L("playerConnected", text))
		end
	end

	ix.chat.classes["disconnect"].OnChatAdd = function(self, speaker, text)
		local icon = ix.util.GetMaterial("icon16/user_delete.png")
		local countryIcon = nil

		for _, v in ipairs(player.GetAll()) do
			if (v:SteamName() == text) then
				countryIcon = ix.geoip:GetMaterial(v)
				break
			end
		end

		if (countryIcon) then
			chat.AddText(icon, Color(200, 150, 200), L("playerDisconnected", text), countryIcon)
		else
			chat.AddText(icon, Color(200, 150, 200), L("playerDisconnected", text))
		end
	end

	// COMMANDS

	for _, cmd in ipairs({"CharGetUp", "CharFallOver", "BecomeClass", "CharDesc"}) do
		local data = ix.command.list[cmd:lower()]

		if (data) then
			if (data.alias) then
				if (istable(data.alias)) then
					for _, v in ipairs(data.alias) do
						ix.command.list[v:lower()] = nil
					end
				elseif (isstring(data.alias)) then
					ix.command.list[data.alias:lower()] = nil
				end
			end

			ix.command.list[cmd:lower()] = nil
		end

		data = nil
	end
end