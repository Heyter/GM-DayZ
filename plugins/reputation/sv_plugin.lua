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

		attacker:SafePenalty()
	end

	timer.Simple(0, function()
		if (IsValid(victim)) then
			victim:ResetPenalty()
			victim.ResetPlayerModel = true
		end
	end)
end

function PLUGIN:PlayerTakeDamage(client, damageInfo)
	local attacker = damageInfo:GetAttacker()

	if (attacker:IsPlayer() and attacker != client) then
		local tag = ix.config.Get("tagPVP", 120)

		attacker:AddPVPTime(tag)
		client:AddPVPTime(tag)
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

	if (client:Alive()) then
		local penalty = math.max(0, 0 - (CurTime() - client:GetLocalVar("penalty", 0)))

		if (penalty < 1) then
			penalty = nil
		end

		character:SetData("penalty", penalty, true)
	end

	local reputation = client:GetNetVar("reputation", 0)
	character:SetData("reputation", reputation, true)
end

function PLUGIN:OnCharacterDisconnect(client, character)
	if (client:GetPVPTime() > CurTime()) then
		client.bNotSavePosition = true
		client:Kill()
	end

	if (!client:Alive()) then
		character:SetData("penalty", nil, true)
	end
end

function PLUGIN:PostPlayerLoadout(client)
	if (client.ResetPlayerModel) then
		local rep = client:GetReputation()

		if (rep < 0) then
			client:SetModel(Schema.BanditModels[ math.random( #Schema.BanditModels ) ])
		elseif (rep > 0) then
			client:SetModel(Schema.HeroModels[ math.random( #Schema.HeroModels ) ])
		else
			local model = client:GetCharacter():GetData("permament_model")

			if (!model) then
				local faction = ix.faction.teams[client:Team()]

				if (faction) then
					client:SetModel(faction.models[ math.random( #faction.models ) ])
				end
			elseif (model and model != client:GetModel()) then
				client:SetModel(model)
			end
		end

		client.ResetPlayerModel = nil
	end
end