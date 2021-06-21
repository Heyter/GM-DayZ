function PLUGIN:PostLoadData()
	local query = mysql:Create("gmodz_squads")
		query:Create("owner", "VARCHAR(20) NOT NULL") -- steamid64
		query:Create("name", "VARCHAR(64) NOT NULL") -- Max squad name length: 64 characters
		query:Create("description", "TEXT")
		query:Create("logo", "VARCHAR(15) DEFAULT NULL") -- Imgur ID
		query:Create("color", "VARCHAR(20) DEFAULT NULL")
		query:PrimaryKey("owner")
	query:Execute()
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	timer.Simple(0.25, function()
		ix.squad.Restore(character:GetSquadID(), client:SteamID64(), function(squad)
			squad:Sync(client)
		end)
	end)
end

function PLUGIN:PreCharacterDeleted(client, character)
	local id = character:GetSquadID()
	if (id == "NULL") then return end

	local squad = ix.squad.list[id]

	if (squad and squad.members[client:SteamID64()]) then
		squad.members[client:SteamID64()] = nil
		squad:Sync()

		ix.squad.list[id] = squad
	end
end

net.Receive("ixSquadCreate", function(_, client)
	if ((client.ixSquadCreateTry or 0) < CurTime()) then
		client.ixSquadCreateTry = CurTime() + 30
	else
		client:Notify("The squad is in the process of being created, wait.")
		return
	end

	local character = client:GetCharacter()
	if (!character or character:GetSquadID() != "NULL") then return end

	local name = tostring(net.ReadString()):gsub("\r\n", ""):gsub("\n", "")
	name = string.Trim(name)

	if (name:utf8len() < 1 or !name:find("%S") or name:gsub("%s", ""):utf8len() > 49) then
		client.ixSquadCreateTry = nil
		return
	end

	ix.squad.New(name, client:SteamID64(), function(squad)
		if (IsValid(client)) then
			character:SetSquadOfficer(0)
			character:SetSquadID(squad.owner)
			squad:Sync(client)

			client:NotifyLocalized("The squad has been successfully created: %s", squad.name)
		end
	end)
end)

net.Receive("ixSquadSettings", function(_, client)
	local data = net.ReadTable()
	if (table.IsEmpty(data) or !client:GetCharacter()) then return end

	local squad = ix.squad.list[client:GetCharacter():GetSquadID()]

	if (squad and squad:IsLeader(client)) then
		if (data.name) then
			local name = tostring(data.name):gsub("\r\n", ""):gsub("\n", "")
			name = string.Trim(name)

			if (name:utf8len() < 1 or !name:find("%S") or name:gsub("%s", ""):utf8len() > 49) then
				data.name = nil
			else
				squad.name = name
			end
		end

		if (data.description) then
			local desc = string.Trim(tostring(data.description))
			if (!desc:find("%s+") or !desc:find("%S") or desc:gsub("%s", ""):utf8len() > 2049) then
				data.description = nil
			else
				squad.description = desc
			end
		end

		if (data.logoID) then
			squad.logo = data.logoID
		end

		if (data.color) then
			squad.color = data.color
		end

		if (!table.IsEmpty(data)) then
			local query = mysql:Update("gmodz_squads")
				if (data.name) then query:Update("name", squad.name) end
				if (data.description) then query:Update("description", squad.description) end
				if (data.logoID) then query:Update("logo", squad.logo) end
				if (data.color) then query:Update("color", string.FromColor(squad.color)) end 
				query:Where("owner", squad.owner)
			query:Execute()

			squad:Sync()
		end
	end
end)