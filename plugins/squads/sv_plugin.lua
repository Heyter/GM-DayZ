util.AddNetworkString("ixSquadSync")
util.AddNetworkString("ixSquadKick")
util.AddNetworkString("ixSquadSettings")
util.AddNetworkString("ixSquadCreate")

ix.util.Include("sv_hooks.lua", "server")

function ix.squad.Restore(id, steamID64, callback)
	if (id == "NULL") then return end

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

				local squad = ix.squad.Register(result.owner, result.name, {
					color = result.color != "NULL" and string.ToColor(result.color) or nil,
					logo = result.logo != "NULL" and result.logo or nil,
					description = result.description != "NULL" and result.description or nil
				})

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

function ix.squad.AddMember(target, client)
	local cache = ix.squad.list[client:GetCharacter():GetSquadID()]
	if (!cache or cache:IsLeader(client) or !cache.members[client:SteamID64()]) then return end

	if (IsValid(target)) then
		local character = target:GetCharacter()

		if (character) then
			character:SetSquadOfficer(0)
			character:SetSquadID(cache.owner)

			cache.members[target:SteamID64()] = 0

			// notify to target.
			// notify to client. target:Name() succesfully invited to cache.name
		end
	end
end

function ix.squad.RemoveMember(target, client)
	local id = client:GetCharacter():GetSquadID()
	if (id == "NULL") then return end

	local cache = ix.squad.list[id]

	if (cache and cache:GetRank(client)) then
		local steamID64 = target:SteamID64()
		local character = target:GetCharacter()

		if (cache.owner == steamID64) then // овнер распустил клан
			// ...
		elseif (character and cache.members[steamID64]) then // выпнули кого-то
			cache.members[steamID64] = nil

			character:SetSquadID("NULL")
			character:SetSquadOfficer(0)
		end

		cache:Sync()

		net.Start("ixSquadKick")
			net.WriteUInt(id, 10)
		net.Send(target)

		ix.squad.list[id] = cache
	end
end