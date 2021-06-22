util.AddNetworkString("ixSquadSync")
util.AddNetworkString("ixSquadKick")
util.AddNetworkString("ixSquadSettings")
util.AddNetworkString("ixSquadCreate")
util.AddNetworkString("ixSquadInvite")
util.AddNetworkString("ixSquadKickMember")
util.AddNetworkString("ixSquadDisband")

ix.util.Include("sv_hooks.lua", "server")

function ix.squad.Restore(id, steamID64, callback)
	if (!id or id == "NULL") then return end

	local cache = ix.squad.list[id]
	if (cache and cache["members"][steamID64]) then
		if (callback) then callback(cache) end

		return
	end

	local query = mysql:Select("gmodz_squads")
		query:Where("owner", id)
		query:Callback(function(result)
			if (istable(result) and #result > 0) then
				result = result[1]

				local pack = {}
				if (result.color and result.color != "NULL") then
					pack["color"] = string.ToColor(result.color)
				end

				if (result.logo and result.logo != "NULL") then
					pack["logo"] = result.logo
				end

				if (result.description and result.description != "NULL" and #result.description > 0) then
					pack["description"] = result.description
				end

				local squad = ix.squad.Register(result.owner, result.name, pack)
				local subQ = mysql:Select("ix_characters")
					subQ:Select("steamid")
					subQ:Select("squad_officer")
					subQ:Where("schema", Schema.folder)
					subQ:Where("squad_id", result.owner)
					subQ:Callback(function(result)
						if (istable(result) and #result > 0) then
							for _, v in ipairs(result or {}) do
								if (v.steamid == squad.owner) then
									squad.members[v.steamid] = 2
								else
									squad.members[v.steamid] = v.squad_officer != "NULL" and v.squad_officer or 0
								end
							end
						end

						if (callback) then callback(squad) end
					end)
				subQ:Execute()
			elseif (callback) then
				callback(false)
			end
		end)
	query:Execute()
end

function ix.squad.New(name, steamID64, callback)
	local query = mysql:Insert("gmodz_squads")
		query:Insert("name", name)
		query:Insert("owner", steamID64)
		query:Insert("description", "NULL")
		query:Insert("logo", "NULL")
		query:Insert("color", "NULL")
		query:Callback(function()
			local squad = ix.squad.Register(steamID64, name)

			if (callback) then
				callback(squad)
			end
		end)
	query:Execute()
end

function ix.squad.RaiseMember(target, client)
	local cache = ix.squad.list[client:GetCharacter():GetSquadID()]
	if (!cache or cache:IsLeader(client) or !cache.members[client:SteamID64()]) then return end

	if (IsValid(target)) then
		local character = target:GetCharacter()

		if (character and character:GetSquadOfficer() == 0) then
			character:SetSquadOfficer(1)

			// notify to target. [ You have been a promoted to officer ]
		end
	end
end

function ix.squad.AddMember(target, client, bNotNotify)
	if (IsValid(client) and client:GetCharacter()) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]
		if (!squad) then return end

		local rank = squad:GetRank(client)
		if (!rank or rank == 0) then return end

		if (IsValid(target) and !squad.members[target:SteamID64()]) then
			local character = target:GetCharacter()

			if (character) then
				character:SetSquadOfficer(0)
				character:SetSquadID(squad.owner)

				squad.members[target:SteamID64()] = 0
				squad:Sync()

				if (!bNotNotify) then
					client:NotifyLocalized("%s accepted your invitation to the squad.", target:Name())
					target:NotifyLocalized("You have been added to a squad: %s", squad.name)
				end
			end
		end
	end
end

function ix.squad.Disband(id, receivers)
	if (!id) then return end

	local query = mysql:Delete("gmodz_squads")
		query:Where("owner", id)
	query:Execute()

	if (receivers and #receivers > 0) then
		local char
		for _, v in ipairs(receivers) do
			char = v:GetCharacter()
			if (!char) then continue end

			char:SetSquadID("NULL")
			char:SetSquadOfficer(0)
		end

		net.Start("ixSquadKick")
			net.WriteString(id)
			net.WriteBool(true)
		net.Send(receivers)
	end

	ix.squad.list[id] = nil
end

function ix.squad.KickMember(target, client)
	if (IsValid(client) and client:GetCharacter()) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]
		if (!squad) then return end

		local rank = squad:GetRank(client)
		local steamID64 = target:SteamID64()

		if (rank and rank != 0 and squad.members[steamID64]) then
			if (rank == 1 and squad.members[steamID64] != 0) then
				return
			end

			local character = target:GetCharacter()

			if (steamID64 == client:SteamID64() and squad.owner == steamID64) then
				ix.squad.Disband(squad.owner, squad:GetReceivers())
				squad = nil
			elseif (character) then
				squad.members[steamID64] = nil
				character:SetSquadID("NULL")
				character:SetSquadOfficer(0)
				squad:Sync()

				net.Start("ixSquadKick")
					net.WriteString(squad.owner)
					net.WriteBool(false)
				net.Send(target)
			end
		end
	end
end