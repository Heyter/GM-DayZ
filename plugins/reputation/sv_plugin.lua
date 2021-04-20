local PLUGIN = PLUGIN
local SH_SZ = SH_SZ

-- PlayerExitSafeZone -- realm @server
-- PlayerEnterSafeZone -- realm @server
-- CanPlayerEnterSafeZone -- realm @server

function PLUGIN:PlayerDeath(victim, _, attacker)
	if (IsValid(attacker) and attacker:IsPlayer() and attacker != victim) then
		local reputation, level = victim:GetReputation(), math.abs(victim:GetReputationLevel())
		local bandit = reputation < 0
		local repDiff = ix.config.Get(bandit and "reputationKill" or "reputationSavior", 10)
		local repPerc = math.abs(reputation / ix.config.Get("maxReputation", 1500))

		if (repPerc >= 0.7) then
			repDiff = math.max(ix.config.Get("reputationKill", 45) * 2 * level, repDiff)
		elseif (repPerc >= 0.4) then
			repDiff = math.max(ix.config.Get("reputationKill", 45) * level, repDiff)
		end

		net.Start("ixUpdateRep")
			net.WriteBool(!bandit)
			net.WriteUInt(repDiff, 16)
		net.Send(attacker)

		if (!bandit) then
			attacker:TakeReputation(repDiff)
		else
			attacker:AddReputation(repDiff)
		end

		if (attacker:Alive()) then -- если умереть вместе с целью, то вешается пенальти
			attacker:SafePenalty()
		end
	end

	victim:ResetPenalty()
end

function PLUGIN:EntityTakeDamage(victim, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local amount = dmgInfo:GetDamage()

	if (amount > 0 and victim:IsPlayer() and attacker:IsPlayer()) then
		if (attacker == victim) then return end
		if (victim:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) != SH_SZ.OUTSIDE) then return end
		if (attacker:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) != SH_SZ.OUTSIDE) then return end

		local tag = ix.config.Get("tagPVP", 120)

		attacker:AddPVPTime(tag)
		victim:AddPVPTime(tag)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	local reputation = character:GetData("reputation")
	local penalty = character:GetData("penalty")

	if (penalty) then
		client:SetLocalVar("penalty", CurTime() + penalty)
	else
		client:ResetPenalty()
	end

	if (reputation) then
		local max = ix.config.Get("maxReputation", 1500)
		reputation = math.Clamp(reputation, -max, max)
		client:SetNetVar("reputation", reputation)
	else
		client:SetNetVar("reputation", 0)
	end
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()

	local reputation = client:GetNetVar("reputation", 0)
	local penalty = math.max(0, 0 - (CurTime() - client:GetLocalVar("penalty", 0)))

	if (penalty < 1) then
		penalty = nil
	end

	character:SetData("penalty", penalty)

	if (reputation != 0) then
		character:SetData("reputation", reputation)
	end
end

function PLUGIN:OnCharacterDisconnect(client)
	if (client:GetPVPTime() > CurTime()) then
		client.bNotSavePosition = true
		client:Kill()
	end
end