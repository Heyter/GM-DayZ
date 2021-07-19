util.AddNetworkString("ixBuffAdd")
util.AddNetworkString("ixBuffRemove")
util.AddNetworkString("ixBuffClears")

function PLUGIN:OnCharacterDisconnect(client)
	client:ClearBuffs(true)
end

function PLUGIN:PlayerSpawn(client)
	client:ClearBuffs()
end

function PLUGIN:PlayerDeath(client)
	client:ClearBuffs(true)
end

function PLUGIN:PlayerTakeDamageClothes(client, info)
	if ((client:HasBuff("epinephrine") or 0) > CurTime() and ix.buff.list["epinephrine"]) then
		info:SetDamage(info:GetDamage() * (1 - ix.buff.list["epinephrine"].damageReduction))
	end
end