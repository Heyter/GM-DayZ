ITEM.name = "Vicasol"
ITEM.model = "models/gmodz/medical/vicasol.mdl"
ITEM.description = ""

-- TODO sound
ITEM.useSound = nil

if (SERVER) then
	function ITEM:OnUse()
		local client = self.player

		timer.Create("StopBleedingOverTime_" .. client:EntIndex(), math.random(1, 12), 1, function()
			if (IsValid(client) and client:Alive()) then
				client:HealBleeding(math.random(1, 5))
			end
		end)
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = "Stops bleeding over time"
		return text
	end
end

if (SERVER) then
	ITEM.rarity = { common = true, weight = 90 }
end