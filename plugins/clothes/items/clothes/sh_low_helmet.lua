ITEM.name = "CVC Helmet"
ITEM.desc = "CVC Helmet Desc"
ITEM.model = "models/gmodz/equipments/cvc_helmet.mdl"
ITEM.outfitCategory = "hat"

ITEM.defDurability = 100
ITEM.damageReduction = { [HITGROUP_HEAD] = 0.45 }
ITEM.dropHat = true

if (SERVER) then
	ITEM.rarity = { rare = true, weight = 5 }
	ITEM.rate = 2

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
					["UniqueID"] = "653aa29cb28604326efb3f9876be13dde4f07222437c536e587498dd2ae574b6",
					["ClassName"] = "model2",
					["Size"] = 1,
					["EditorExpand"] = true,
					["Model"] = "models/gmodz/equipments/cvc_helmet.mdl",
					["Position"] = Vector(1.1599999666214, -0.62000000476837, 0),
					["Skin"] = 0
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "a280c9dfd22932d8173286659e74ce6074dab47d5e8f077adffaab1180d2d622",
			["ClassName"] = "group",
			["Name"] = "cvc_helmet"
		},
	},
}