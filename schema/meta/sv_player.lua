local playerMeta = FindMetaTable("Player")

function playerMeta:RemoveEquippableItem(item)
	if (item.Unequip) then
		item:Unequip(self)
	elseif (item.RemoveOutfit) then
		item:RemoveOutfit(self)
	elseif (item.RemovePart) then
		item:RemovePart(self)
	end
end

-- A function to return an entity's collision group.
function playerMeta:ReturnCollisionGroup(collisionGroup)
	if (!collisionGroup) then return end

	local physicsObject = self:GetPhysicsObject()

	if (IsValid(physicsObject)) then
		if (!physicsObject:IsPenetrating()) then
			self:SetCollisionGroup(collisionGroup)
		else
			timer.Create("CollisionGroup" .. self:EntIndex(), 1, 1, function()
				self:ReturnCollisionGroup(collisionGroup)
			end)
		end
	end
end

local dist = 80 * 80
function playerMeta:ActivateNoCollision(time, collision_group)
	if (!collision_group) then return end

	local timerID = self:EntIndex() .. "_checkBounds_cycle"
	if (timer.Exists(timerID)) then return end

	timer.Simple(time or 10, function()
		if (IsValid(self) and self:Alive()) then
			timer.Create(timerID, 0.5, 0, function()
				if (!IsValid(self) or !self:Alive()) then
					timer.Remove(timerID)
					return
				end

				local penetrating = (self:GetPhysicsObject() and self:GetPhysicsObject():IsPenetrating()) or self:IsStuck()
				local tooNearPlayer

				for _, v in ipairs(player.GetAll()) do
					if (v != self and self:GetPos():DistToSqr(v:GetPos()) <= dist) then
						tooNearPlayer = true
						break
					end
				end

				if !(penetrating and tooNearPlayer) then
					self:SetCollisionGroup(collision_group)
					timer.Remove(timerID)
				end
			end)
		end
	end)
end