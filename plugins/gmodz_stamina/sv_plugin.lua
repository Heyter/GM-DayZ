-- luacheck: pop
local velocitySqr = 45 * 45
local function CalcStaminaChange(client)
	if (!client:GetCharacter() or !client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return
	end

	local runSpeed = ix.config.Get("runSpeed")
	local walkSpeed = ix.config.Get("walkSpeed")
	local brth = client:GetNetVar("brth", false)
	local disableSprint = hook.Run("PlayerDisableSprint", client, walkSpeed) or brth

	if (disableSprint) then
		if (isnumber(disableSprint)) then
			runSpeed = math.min(runSpeed, disableSprint)
			disableSprint = nil
		else
			runSpeed = walkSpeed
		end
	end

	if (client:GetRunSpeed() != runSpeed) then
		client:SetRunSpeed(runSpeed)
	end

	local offset

	if (client:KeyDown(IN_SPEED) and !disableSprint and client:GetVelocity():LengthSqr() >= velocitySqr) then
		offset = -ix.config.Get("staminaDrain", 1)
	else
		offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
	end

	offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

	local current = client:GetLocalVar("stm", 0)
	local value = math.Clamp(current + offset, 0, 100)

	if (current != value) then
		client:SetLocalVar("stm", value)

		if (value == 0 and !brth) then
			client:SetNetVar("brth", true)
		elseif (value >= 25 and brth) then
			client:SetNetVar("brth", nil)
		end
	end
end

-- lua_run ix.plugin.Get("gmodz_stamina"):PostPlayerLoadout(Entity(1))
function PLUGIN:PostPlayerLoadout(client)
	local uniqueID = "ixStam" .. client:SteamID()

	timer.Create(uniqueID, 0.25, 0, function()
		if (!IsValid(client)) then
			timer.Remove(uniqueID)
			return
		end

		CalcStaminaChange(client)
	end)
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()

	if (IsValid(client)) then
		character:SetData("stamina", client:GetLocalVar("stm", 0), true)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	timer.Simple(0.25, function()
		client:SetLocalVar("stm", character:GetData("stamina", 100))
	end)
end

function PLUGIN:KeyPress(client, key)
	if (key == IN_JUMP and client:OnGround() and client:GetMoveType() == MOVETYPE_WALK and !client:GetNetVar("brth", false)) then
		local staminaUse = ix.config.Get("jumpStamina", 0)

		if (staminaUse > 0) then
			if (client:GetLocalVar("stm", 0) - staminaUse < 0) then
				client:SetNetVar("brth", true)
				client:SetLocalVar("stm", 0)
			else
				client:ConsumeStamina(staminaUse)
			end
		end
	end
end

-- Здесь, потому что не хочу сто хуков делать.
hook.Add("PlayerDisableSprint", "Stamina.PlayerDisableSprint", function(client, walkSpeed)
	local sprint, enableSprint

	for _, v in pairs(client:GetClothesItem()) do
		if (v.disableSprint) then
			sprint = true
			break
		end
	end

	if (!sprint and client:IsBrokenLeg()) then
		sprint = walkSpeed * 1.5
	end

	return sprint
end)

local playerMeta = FindMetaTable("Player")

function playerMeta:RestoreStamina(amount)
	local current = self:GetLocalVar("stm", 0)
	local value = math.Clamp(current + amount, 0, 100)

	self:SetLocalVar("stm", value)
end

function playerMeta:ConsumeStamina(amount)
	local current = self:GetLocalVar("stm", 0)
	local value = math.Clamp(current - amount, 0, 100)

	self:SetLocalVar("stm", value)
end