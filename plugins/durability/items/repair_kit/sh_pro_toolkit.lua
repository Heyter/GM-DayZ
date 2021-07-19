ITEM.name = "Universal repair kit"
ITEM.model = "models/lostsignalproject/items/repair/armor_repair_pro.mdl"
ITEM.description = "Includes tools to repair weapons and clothing."

ITEM.maxQuantity = 3
ITEM.raiseDurability = 1
ITEM.price = 1000

ITEM.isWeaponKit = true
ITEM.isClothesKit = true

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 4 }

	function ITEM:useSound(targetItem, client)
		if (targetItem.isWeapon) then
			client:EmitSound("gmodz/durability/repair_weapon.wav")
		else
			client:EmitSound("gmodz/durability/repair_clothes.wav")
		end
	end
end

if (CLIENT) then
	function ITEM:ExtendDesc(text)
		text[1] = Format("Restores %d%% of the durability.", self.raiseDurability)
		return text
	end
end