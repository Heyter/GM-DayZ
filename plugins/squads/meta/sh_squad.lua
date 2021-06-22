local META = ix.squad.meta or ix.middleclass("ix_squad")
META.__index = META

META.name = META.name or "ERROR"
META.members = META.members or {}

function META:__tostring()
	return "squad["..self.owner.."]["..self.name.."]"
end

function META:Initialize(owner, name)
	self.owner = owner
	self.name = name

	self.members = {}
end

function META:GetReceivers()
	local receivers = {}

	for _, v in ipairs(player.GetHumans()) do
		if (IsValid(v) and self.members[v:SteamID64()]) then
			receivers[#receivers + 1] = v
		end
	end

	return receivers
end

function META:GetRank(client)
	return self.members[client:SteamID64()]
end

function META:IsLeader(client)
	return self.owner == client:SteamID64()
end

if (SERVER) then
	function META:CollectData()
		return {
			owner = self.owner,
			name = self.name,
			members = self.members,
			color = self.color,
			logo = self.logo,
			description = self.description
		}
	end

	function META:Sync(client)
		local receivers = self:GetReceivers()

		if (IsValid(client) or #receivers > 0) then
			net.Start("ixSquadSync")
				net.WriteTable(self:CollectData())
			net.Send(client or receivers)
		end
	end
end

ix.squad.meta = META