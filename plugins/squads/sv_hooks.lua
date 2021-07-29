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
			if (IsValid(client) and character) then
				if (squad) then
					squad:Sync(client)
				else
					character:SetSquadID("NULL")
					character:SetSquadOfficer(0)
				end
			end
		end)
	end)
end

function PLUGIN:PreCharacterDeleted(client, character)
	local squad = ix.squad.list[character:GetSquadID()]
	local steamID64 = client:SteamID64()

	if (squad and squad.members[steamID64]) then
		if (squad.owner == steamID64) then
			ix.squad.Disband(steamID64, squad:GetReceivers())
			squad = nil
		else
			squad.members[steamID64] = nil
			squad:Sync()

			net.Start("ixSquadKick")
				net.WriteString(squad.owner)
				net.WriteBool(false)
			net.Send(client)
		end
	end
end

function PLUGIN:PostPlayerLoadout(client)
	local character = client:GetCharacter()

	if (character) then
		local squad = ix.squad.list[character:GetSquadID()]
		if (!squad or !squad.color) then return end

		local color = squad.color
		client:SetPlayerColor(Vector(color.r / 255, color.g / 255, color.b / 255))
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
		if (IsValid(client) and squad) then
			character:SetSquadOfficer(0)
			character:SetSquadID(squad.owner)
			squad:Sync(client)

			client:NotifyLocalized("Squad %s was successfully created!", squad.name)
			client.ixSquadCreateTry = nil
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

			if (name:utf8len() < 1 or !name:find("%S")) then
				data.name = nil
			else
				if (name:gsub("%s", ""):utf8len() > 48) then
					name = name:utf8sub(0, 48)
				end

				squad.name = name
			end
		end

		if (data.description) then
			local desc = string.Trim(tostring(data.description))

			if (!desc:find("%S")) then
				squad.description = ""
			else
				if (desc:utf8len() < 1) then
					desc = ""
				elseif (desc:gsub("%s", ""):utf8len() > 2048) then
					desc = desc:utf8sub(0, 2048)
				end

				squad.description = desc
			end
		end

		if (isstring(data.logoID)) then
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

			squad:Sync(nil, data.color)
		end
	end
end)

net.Receive("ixSquadInvite", function(_, client)
	local id = client:GetCharacter() and client:GetCharacter():GetSquadID()
	if (!id or id == "NULL") then return end

	local squad = ix.squad.list[id]
	if (!squad) then return end

	local target = net.ReadEntity()

	if (IsValid(target) and client:GetPos():DistToSqr(target:GetPos()) < 160 * 160) then
		target:NotifyLocalized("%s invites you to his squad %s. Type in chat /saccept", client:Nick(), squad.name)
		target.squad_invite = {CurTime() + 30, client:UserID()}
	end
end)

net.Receive("ixSquadKickMember", function(_, client)
	if ((client.ixSquadKickTry or 0) < CurTime()) then
		client.ixSquadKickTry = CurTime() + 2
	else
		return
	end

	local steamID64 = net.ReadString()
	if (!isstring(steamID64) or #steamID64 == 0) then return end

	local index = player.GetBySteamID64(steamID64)

	if (index) then
		ix.squad.KickMember(index, client)
	else
		ix.squad.KickMember_Offline(steamID64, client)
	end
end)

net.Receive("ixSquadDisband", function(_, client)
	if ((client.ixSquadKickTry or 0) < CurTime()) then
		client.ixSquadKickTry = CurTime() + 2
	else
		return
	end

	ix.squad.KickMember(client, client)
end)

net.Receive("ixSquadRankChange", function(_, client)
	if ((client.ixSquadRankTry or 0) < CurTime()) then
		client.ixSquadRankTry = CurTime() + 2
	else
		return
	end

	local steamID64 = net.ReadString()
	if (!isstring(steamID64) or #steamID64 == 0 or steamID64 == client:SteamID64()) then return end

	local index = player.GetBySteamID64(steamID64)

	if (index) then
		ix.squad.ChangeRank(index, client)
	else
		ix.squad.ChangeRank_Offline(steamID64, client)
	end
end)

net.Receive("ixSquadLeave", function(_, client)
	if (IsValid(client)) then
		local character = client:GetCharacter()
		if (!character) then return end

		local squad = ix.squad.list[character:GetSquadID()]
		if (!squad or squad:IsLeader()) then return end

		if (squad.members[client:SteamID64()]) then
			net.Start("ixSquadLeave")
				net.WriteString(squad.owner)
			net.Send(client)

			squad.members[client:SteamID64()] = nil
			character:SetSquadID("NULL")
			character:SetSquadOfficer(0)
			squad:Sync()
		end
	end
end)