PLUGIN.name = "Area fix"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (CLIENT) then
	local nextThink = 0
	function PLUGIN:Think()
		if (nextThink > CurTime()) then return end
		nextThink = CurTime() + 0.33

		local client = LocalPlayer()
		if (!client:Alive() or !client:GetCharacter()) then return end

		local overlappingBoxes = {}
		local position = client:GetPos() + client:OBBCenter()

		for id, info in pairs(ix.area.stored) do
			if (position:WithinAABox(info.startPosition, info.endPosition)) then
				overlappingBoxes[#overlappingBoxes + 1] = id
			end
		end

		if (#overlappingBoxes > 0) then
			local oldID = client:GetArea()
			local id = overlappingBoxes[1]

			if (oldID != id) then
				hook.Run("OnAreaChanged", client.ixArea, id)
				client.ixArea = id
			end

			client.ixInArea = true
		else
			client.ixInArea = false
		end
	end
end