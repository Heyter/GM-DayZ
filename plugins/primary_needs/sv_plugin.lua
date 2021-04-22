local PLUGIN = PLUGIN

-- HOOKS
function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	
	local savedNeed = math.Clamp(CurTime() - client:GetLocalVar("hunger", 0), 0, ix.config.Get("hungrySeconds", 3000))
	character:SetData("hunger", savedNeed)

	savedNeed = math.Clamp(CurTime() - client:GetLocalVar("thirst", 0), 0, ix.config.Get("thirstySeconds", 3000))
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

local thinkTime = CurTime()
function PLUGIN:PlayerPostThink(client)
	if (thinkTime < CurTime()) then
		local hunger = (1 - client:GetHungerPercent()) <= 0
		local thirst = (1 - client:GetThirstPercent()) <= 0

		if (client:Alive() and (hunger or thirst)) then
			local health = math.max(0, client:Health() - 1)

			if (health <= 0 or hunger and thirst) then
				client:Kill()
			else
				client:SetHealth(health)
			end
		end

		thinkTime = CurTime() + ix.config.Get("needsTime", 1)
	end
end


-- PLAYER META
do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:AddHunger(amount)
		local curNeed = CurTime() - self:GetLocalVar("hunger", 0)
		local maxSeconds = ix.config.Get("hungrySeconds", 3000)

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