local playerMeta = FindMetaTable("Player")

function playerMeta:AddReputation(amount)
	local max = ix.config.Get("maxReputation", 1500)

	self:SetNetVar("reputation", math.min(max, self:GetReputation() + amount))
end

function playerMeta:TakeReputation(amount)
	local max = ix.config.Get("maxReputation", 1500)

	self:SetNetVar("reputation", math.max(-max, self:GetReputation() - amount))
end

function playerMeta:SafePenalty()
	local time, mul = ix.config.Get("safePenalty", 100), ix.config.Get("safePenaltyMul", 2)

	local rep, repMax = self:GetReputation(), ix.config.Get("maxReputation", 1500)
	local rate = rep/repMax * -0.1
	local penTime = (time + time * rate * mul)

	self:SetLocalVar("penalty", CurTime() + penTime)
end

function playerMeta:ResetPenalty()
	self:SetLocalVar("penalty", nil)
	self:SetLocalVar("PVPTime", nil)
end

function playerMeta:AddPVPTime(amount)
	self:SetLocalVar("PVPTime", CurTime() + amount)
end