ITEM.name = "CVC Helmet (Black)"
ITEM.desc = ""
ITEM.model = "models/gmodz/equipments/cvc_helmet.mdl"
ITEM.outfitCategory = "hat"

ITEM.defDurability = 100
ITEM.damageReduction = { [HITGROUP_HEAD] = 0.45 }
ITEM.dropHat = true

ITEM.skin = 2

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 2 }

	function ITEM:OnInstanced(index)
		if (index == 0) then
			self:SetData("durability", math.random(0, self.defDurability * math.Rand(0.5, 0.75)), false)
		end
	end
end

ITEM.iconCam = {
	pos = Vector(119.12911987305, 100.74072265625, 78.613121032715),
	ang = Angle(25.168048858643, -139.87422180176, 10.754030227661),
	fov = 6.7973208900601,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(0, -90, -90),
					["UniqueID"] = "4eeab4e570878434914441326f6dea3e835fc2f88b8cebe7f995ca56de477b43",
					["ClassName"] = "model2",
					["Size"] = 1,
					["EditorExpand"] = true,
					["Model"] = "models/gmodz/equipments/cvc_helmet.mdl",
					["Position"] = Vector(1.1599999666214, -0.62000000476837, 0),
					["Skin"] = 2,
					["Name"] = "helmet"
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "77ac07882c81a8933c740be8ab3f91bcbe10e5a9d8415060adcec4cc101b235a",
			["ClassName"] = "group",
			["Name"] = "cvc_helmet"
		},
	},
}