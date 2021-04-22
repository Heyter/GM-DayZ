local PLUGIN = PLUGIN

-- HOOKS
function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	
	local savedNeed = math.Clamp(CurTime() - client:GetLocalVar("hunger", 0), 0, ix.config.Get("hungrySeconds", 3500))
	character:SetData("hunger", savedNeed)

	savedNeed = math.Clamp(CurTime() - client:GetLocalVar("thirst", 0), 0, ix.config.Get("thirstySeconds", 2000))
	character:SetData("thirst", savedNeed)
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	-- hunger
	local getHunger = character:GetData("hunger")

	if (getHunger) then
		getHunger = CurTime() - getHunger
	end

	client:SetLocalVar("hunger", getHunger or CurTime())

	-- thirst
	local getThirst = character:GetData("thirst")

	if (getThirst) then
		getThirst = CurTime() - getThirst
	end

	client:SetLocalVar("thirst", getThirst or CurTime())
end

function PLUGIN:PlayerDeath(client)
	client.refillNeeds = true
end

function PLUGIN:PlayerSpawn(client)
	if (client.refillNeeds) then
		client:SetLocalVar("hunger", CurTime())
		client:SetLocalVar("thirst", CurTime())

		client.refillNeeds = nil
	end
end

function PLUGIN:PlayerPostThink(client)
	if (!client:GetCharacter() or !client:Alive()) then return end

	if (!client.needsTime or client.needsTime < CurTime()) then
		local bHunger = (1 - client:GetHungerPercent()) <= 0
		local bThirst = (1 - client:GetThirstPercent()) <= 0

		if (client:Alive() and (bHunger or bThirst)) then
			local health = math.max(0, client:Health() - 1)

			if (health <= 0 or bHunger and bThirst) then
				client:Kill()
			else
				client:SetHealth(health)
			end
		end

		client.needsTime = CurTime() + ix.config.Get("needsTime", 1)
	end

	if (!client.regenTime or client.regenTime < CurTime()) then
		if (hook.Run("CanPlayerRegenHealth", client) != false and client:Health() < client:GetMaxHealth()) then
			local hunger = 1 - client:GetHungerPercent()
			local thirst = 1 - client:GetThirstPercent()

			if (hunger >= 0.9 and thirst >= 0.9) then
				client:SetHealth(math.min(client:GetMaxHealth(), client:Health() + 1))
			end
		end

		client.regenTime = CurTime() + 5
	end
end


-- PLAYER META
do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:AddHunger(amount)
		local curNeed = CurTime() - self:GetLocalVar("hunger", 0)
		local maxSeconds = ix.config.Get("hungrySeconds", 3500)

		self:SetLocalVar("hunger", 
			CurTime() - math.Clamp(math.min(curNeed, maxSeconds) - amount, 0, maxSeconds)
		)
	end

	function playerMeta:AddThirst(amount)
		local curNeed = CurTime() - self:GetLocalVar("thirst", 0)
		local maxSeconds = ix.config.Get("thirstySeconds", 2000)

		self:SetLocalVar("thirst", 
			CurTime() - math.Clamp(math.min(curNeed, maxSeconds) - amount, 0, maxSeconds)
		)
	end
end