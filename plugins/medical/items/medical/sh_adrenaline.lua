ITEM.name = "Adrenaline shot"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "Sterile disposable syringe with a dose of adrenaline - the main hormone of the adrenal medulla. It is used to enhance the physiological response associated with the preparation of all muscles to increase activity temporarily boosts strength endurance. Relieves the sensation of pain."

if (SERVER) then
	function ITEM:OnUse()
		self.player:AddBuff("adrenaline")
	end
else
	function ITEM:ExtendDesc(text)
		text[#text+1] = Format("Increases movement speed (%d's)", ix.buff.list["adrenaline"].time)
		return text
	end
end

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 20 }
	ITEM.rate = 3
end