-- Disable entity driving.
function Schema:CanDrive(client, entity)
	return false
end

-- Sandbox stuff
function Schema:PhysgunPickup(client, entity)
	return client:IsSuperAdmin()
end

function Schema:PhysgunFreeze(weapon, phys, entity, client)
	return client:IsSuperAdmin()
end

function Schema:CanTool(client, trace, tool, ENT)
	return client:IsSuperAdmin()
end

-- Credits by Bilwin
-- Anti-Bhop
function Schema:OnPlayerHitGround(client)
    local velocity = client:GetVelocity()

    client:SetVelocity(Vector(-(velocity.x * 0.45), -(velocity.y * 0.45), 0))
end

function Schema:GetMaxPlayerCharacter()
	return 1
end

-- Restrict Business.
function Schema:CanPlayerUseBusiness(client, id)
	return false
end

function Schema:KeyPress(client, key)
	if (key == IN_JUMP and client:OnGround() and client:GetMoveType() == MOVETYPE_WALK) then
		local staminaUse = ix.config.Get("jumpStamina")

		if (staminaUse > 0) then
			local value = client:GetLocalVar("stm", 0) - staminaUse

			if (value < 0) then
				client:SetVelocity(Vector(0, 0, -client:GetJumpPower()))
			elseif (SERVER) then
				client:ConsumeStamina(staminaUse)
			end
		end
	end
end