local GM = GM or GAMEMODE

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

-- PAC3
function Schema:PrePACConfigApply(client)
	if (!client:IsSuperAdmin()) then
		return false, "Permission Denied"
	end
end

function Schema:PrePACEditorOpen(client)
	if (!client:IsSuperAdmin()) then
		return false
	end
end

-- disable ix.menu
do
	ix.menu = {}
	local ixItemENT = scripted_ents.GetStored("ix_item").t

	if (CLIENT) then
		function ix.menu.Open() return false end
		function ix.menu.IsOpen() return true end
		function ix.menu.NetworkChoice() end

		function GM:KeyRelease(client, key)
			if (!IsFirstTimePredicted()) then
				return
			end

			if (key == IN_USE) then
				timer.Remove("ixItemUse")

				client.ixInteractionTarget = nil
				client.ixInteractionStartTime = nil
			end
		end
	else
		net.Receive("ixEntityMenuSelect", function() end)
		net.Receive("ixItemEntityAction", function() end)
	end

	function ixItemENT:GetEntityMenu() return nil end
end