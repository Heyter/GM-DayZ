local playerMeta = FindMetaTable("Player")

function playerMeta:GetTraceEntity(distance, mode)
	distance = distance or 96
	mode = mode or 1

	local data = {}
	data.start = self:GetShootPos()
	data.endpos = data.start + self:GetAimVector() * distance
	data.filter = self

	if (mode == 2) then
		data.mask = MASK_SHOT_HULL

		return util.TraceHull(data).Entity
	end

	return util.TraceLine(data).Entity
end

function playerMeta:GetWeaponAmmo(item)
	local weapon = self.carryWeapons and self.carryWeapons[item.weaponCategory]
	local ammo = 0

	if (!IsValid(weapon)) then
		weapon = self:GetWeapon(item.class)
	end

	if (IsValid(weapon) and weapon:Clip1() > 0) then
		ammo = weapon:Clip1()
	else
		ammo = item:GetData("ammo", 0)
	end

	return ammo
end

do
	--- Returns this player's current name.
	-- @realm shared
	-- @treturn[1] string Name of this player's currently loaded character
	-- @treturn[2] string Steam name of this player if the player has no character loaded
	function playerMeta:GetName()
		return self:SteamName()
	end

	playerMeta.Nick = playerMeta.GetName
	playerMeta.Name = playerMeta.GetName

	function playerMeta:GetItems(onlyMain)
		local char = self:GetCharacter()

		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				return inv:GetItems(onlyMain)
			end
		end
	end
end