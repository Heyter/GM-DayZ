PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Adds a stamina system to limit running."

-- luacheck: push ignore 631
ix.config.Add("staminaDrain", 1, "How much stamina to drain per tick (every quarter second). This is calculated before attribute reduction.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaRegeneration", 1.75, "How much stamina to regain per tick (every quarter second).", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaCrouchRegeneration", 2, "How much stamina to regain per tick (every quarter second) while crouching.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("punchStamina", 10, "How much stamina punches use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})

ix.config.Add("jumpStamina", 10, "How much stamina jumpes use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})

-- luacheck: pop
local function CalcStaminaChange(client)
	local character = client:GetCharacter()

	if (!character or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return 0
	end

	local runSpeed

	if (SERVER) then
		runSpeed = ix.config.Get("runSpeed")

		if (client:WaterLevel() > 1) then
			runSpeed = runSpeed * 0.775
		end
	end

	local walkSpeed = ix.config.Get("walkSpeed")
	local offset

	if (client:KeyDown(IN_SPEED) and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed)) then
		offset = -ix.config.Get("staminaDrain", 1)
	else
		offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
	end

	offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

	if (CLIENT) then
		return offset -- for the client we need to return the estimated stamina change
	else
		local current = client:GetLocalVar("stm", 0)
		local value = math.Clamp(current + offset, 0, 100)

		if (current != value) then
			client:SetLocalVar("stm", value)

			if (value == 0 and !client:GetNetVar("brth", false)) then
				client:SetRunSpeed(walkSpeed)
				client:SetNetVar("brth", true)

				hook.Run("PlayerStaminaLost", client)
			elseif (value >= 25 and client:GetNetVar("brth", false)) then
				client:SetRunSpeed(runSpeed)
				client:SetJumpPower(ix.config.Get("jumpPower", 200))
				client:SetNetVar("brth", nil)

				hook.Run("PlayerStaminaGained", client)
			end
		end
	end
end

if (SERVER) then
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
			local staminaUse = ix.config.Get("jumpStamina")

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
end

function PLUGIN:PlayerStaminaJumpPower(client, jumpPower, brth)
	if (brth) then
		return 1
	end
end
