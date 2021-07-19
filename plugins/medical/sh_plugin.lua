PLUGIN.name = "Medical Supplies"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

if (SERVER) then
	function PLUGIN:PlayerDeath(client)
		local id = "StopBleedingOverTime_" .. client:EntIndex()

		if (timer.Exists(id)) then
			timer.Remove(id)
		end

		id = nil
	end
end