ITEM.name = "Vicasol"
ITEM.model = "models/gmodz/medical/vicasol.mdl"
ITEM.description = ""
ITEM.useSound = "gmodz/items/medical/pills_use.wav"

ITEM.rarity = { weight = 90 }

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