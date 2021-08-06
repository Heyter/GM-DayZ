util.AddNetworkString("ixBuffAdd")
util.AddNetworkString("ixBuffRemove")
util.AddNetworkString("ixBuffClears")
util.AddNetworkString("ixBuffDataSet")

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
	--local buff = client:HasBuff("epinephrine")

	--if (buff and buff.time > CurTime()) then
	if (client:HasBuff("epinephrine")) then
		info:SetDamage(info:GetDamage() * (1 - ix.buff.list["epinephrine"].damageReduction))
	end
end