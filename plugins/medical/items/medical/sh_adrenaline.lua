ITEM.name = "Adrenaline shot"
ITEM.model = "models/gmodz/medical/adrenaline.mdl"
ITEM.description = "Sterile disposable syringe with a dose of adrenaline - the main hormone of the adrenal medulla. It is used to enhance the physiological response associated with the preparation of all muscles to increase activity temporarily boosts strength endurance. Relieves the sensation of pain."

ITEM.useSound = "gmodz/items/syringe.wav"

ITEM.rarity = { weight = 45 }

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("adrenaline")
	end
else
	function ITEM:ExtendDesc(text)
		local buff = ix.buff.list["adrenaline"]

		if (buff) then
			text[#text+1] = Format("Increases movement speed (%d's)", buff.time)
			text[#text+1] = Format("Increases stamina regeneration %.1f", buff.stamina_offset)
		end

		return text
	end
end