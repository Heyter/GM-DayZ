util.AddNetworkString("ixSquadSync")
util.AddNetworkString("ixSquadKick")
util.AddNetworkString("ixSquadSettings")
util.AddNetworkString("ixSquadCreate")
util.AddNetworkString("ixSquadInvite")
util.AddNetworkString("ixSquadKickMember")
util.AddNetworkString("ixSquadDisband")
util.AddNetworkString("ixSquadRankChange")
util.AddNetworkString("ixSquadLeave")

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
					pack.color = string.ToColor(result.color)
				end

				if (result.logo and result.logo != "NULL") then
					pack.logo = result.logo
				end

				if (result.description and result.description != "NULL" and #result.description > 0) then
					pack.description = result.description
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

function ix.squad.New(name, steamID64, insert_callback, restore_callback)
	if (!name or !steamID64) then
		if (insert_callback) then insert_callback() end
		return
	end

	local query = mysql:Select("gmodz_squads")
		query:Where("owner", steamID64)
		query:Limit(1)
		query:Callback(function(result)
			if (istable(result) and #result > 0) then
				ix.squad.Restore(result[1].owner, steamID64, restore_callback)
			else
				local queryInsert = mysql:Insert("gmodz_squads")
					queryInsert:Insert("name", name)
					queryInsert:Insert("owner", steamID64)
					queryInsert:Insert("description", "NULL")
					queryInsert:Insert("logo", "NULL")
					queryInsert:Insert("color", "NULL")
					queryInsert:Callback(function()
						local squad = ix.squad.Register(steamID64, name)

						if (insert_callback) then
							insert_callback(squad)
						end
					end)
				queryInsert:Execute()
			end
		end)
	query:Execute()
end

function ix.squad.ChangeRank(target, client)
	if (IsValid(client) and client:GetCharacter()) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]

		if (squad and squad:IsLeader(client) and IsValid(target)) then
			local steamID64 = target:SteamID64()
			local character = target:GetCharacter()

			if (squad.members[steamID64] and character) then
				if (character:GetSquadOfficer() == 0) then
					character:SetSquadOfficer(1)
					squad.members[steamID64] = 1

					target:NotifyLocalized("squad_promoted_rank")
					client:NotifyLocalized("squad_promoted_rank2", target:Name())
				else
					character:SetSquadOfficer(0)
					squad.members[steamID64] = 0

					target:NotifyLocalized("squad_demoted_rank")
					client:NotifyLocalized("squad_demoted_rank2", target:Name())
				end

				squad:Sync()
			end
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
					client:NotifyLocalized("squad_invite_accepted", target:Name())
					target:NotifyLocalized("squad_invite_accepted2", squad.name)
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

	if (ix.squad.list[id]) then
		ix.squad.list[id] = nil
	end
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

-- OFFLINE Methods
function ix.squad.KickMember_Offline(steamID64, client)
	if (IsValid(client) and client:GetCharacter()) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]
		if (!squad) then return end

		local rank = squad:GetRank(client)

		if (rank and rank != 0 and squad.members[steamID64]) then
			if (rank == 1 and squad.members[steamID64] != 0) then
				return
			end

			if (steamID64 == client:SteamID64() and squad.owner == steamID64) then
				return
			else
				squad.members[steamID64] = nil
				squad:Sync()

				local query = mysql:Update("ix_characters")
					query:Update("squad_id", "NULL")
					query:Update("squad_officer", 0)
					query:Where("schema", Schema.folder)
					query:Where("steamid", steamID64)
				query:Execute()
			end
		end
	end
end

function ix.squad.ChangeRank_Offline(steamID64, client)
	if (IsValid(client) and client:GetCharacter()) then
		local squad = ix.squad.list[client:GetCharacter():GetSquadID()]

		if (squad and squad:IsLeader(client) and squad.members[steamID64]) then
			local is_officer = 0

			if (squad.members[steamID64] == 0) then
				squad.members[steamID64] = 1
				client:NotifyLocalized("squad_promoted_rank2", steamID64)
				is_officer = 1
			else
				squad.members[steamID64] = 0
				client:NotifyLocalized("squad_demoted_rank2", steamID64)
			end

			squad:Sync()

			local query = mysql:Update("ix_characters")
				query:Update("squad_officer", is_officer)
				query:Where("schema", Schema.folder)
				query:Where("steamid", steamID64)
			query:Execute()
		end
	end
end