-- luacheck: pop
local function CalcStaminaChange(client)
	if (!client:GetCharacter() or !client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return
	end

	local runSpeed = ix.config.Get("runSpeed")
	local walkSpeed = ix.config.Get("walkSpeed")

	if (client.disableSprint) then
		runSpeed = walkSpeed
	elseif (client:WaterLevel() > 1) then
		runSpeed = runSpeed * 0.775
	end

	local offset

	if (client:KeyDown(IN_SPEED) and !client.disableSprint and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed)) then
		offset = -ix.config.Get("staminaDrain", 1)
	else
		offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
	end

	offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

	local current = client:GetLocalVar("stm", 0)
	local value = math.Clamp(current + offset, 0, 100)

	if (current != value) then
		client:SetLocalVar("stm", value)

		if (value == 0 and !client:GetNetVar("brth", false)) then
			client:SetRunSpeed(walkSpeed)
			client:SetNetVar("brth", true)

			-- hook.Run("PlayerStaminaLost", client)
		elseif (value >= 25 and client:GetNetVar("brth", false)) then
			client:SetRunSpeed(runSpeed)
			client:SetJumpPower(ix.config.Get("jumpPower", 200))
			client:SetNetVar("brth", nil)

			-- hook.Run("PlayerStaminaGained", client)
		end
	end
end

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
	if (key == IN_JUMP and client:OnGround() and client:GetMoveType() == MOVETYPE_WALK) then
		local staminaUse = ix.config.Get("jumpStamina", 0)

		if (staminaUse > 0) then
			local value = client:GetLocalVar("stm", 0) - staminaUse

			if (!client:GetNetVar("brth", false)) then
				if (value < 0) then
					client:SetNetVar("brth", true)
					client:SetLocalVar("stm", 0)
				else
					client:ConsumeStamina(staminaUse)
				end
			end
		end
	end
end

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