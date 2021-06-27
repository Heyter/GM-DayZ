PLUGIN.name = "Durability"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Adds durability to the weapon."

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	Schema.conditionStatus = {
		{math.huge, "txtCond0", Color(39, 174, 96)},
		{75, "txtCond1", Color(80, 174, 80)},
		{50, "txtCond2", Color(182, 174, 60)},
		{25, "txtCond3", Color(222, 100, 50)},
		{0.1, "txtCond4", Color(192, 57, 43)}
	}

	function Schema:GetConditionStatus(cond)
		local fineHealthText = "ERROR"
		local fineHealthColor = self.conditionStatus[1][3]

		for _, b in ipairs(self.conditionStatus) do
			if (b[1] > cond) then
				fineHealthText = L(b[2])
				fineHealthColor = b[3]
			end
		end

		return fineHealthText, fineHealthColor
	end

	function PLUGIN:PopulateItemTooltip(tooltip, item)
		if (!item.isWeapon) then
			return
		end

		local durability = item:GetData("durability", 100)
		local text, color = Schema:GetConditionStatus(durability)

		local panel = tooltip:AddRowAfter("description", "durability")
		panel:SetText(L("conditionDesc", text, math.Round(durability, 1)))
		panel:SetBackgroundColor(color)
		panel:SizeToContents()
	end
end

function PLUGIN:InitializedPlugins()
	do
		if (CLIENT) then
			for _, WEAPON in ipairs(weapons.GetList()) do
				local class = WEAPON.ClassName

				if (weapons.IsBasedOn(class, "arccw_base") and !class:find("base") and ix.item.list[class]) then
					WEAPON.msg_jammed = L("weaponJammed")

					function WEAPON:Hook_PostFireBullets()
						local durability = self:GetOwner():GetLocalVar("WeaponDurability", 100)

						if (durability <= 0) then
							self.NextMalfunction = 999999
						else
							self.MalfunctionMeanCopy = self.MalfunctionMeanCopy or self:MalfunctionMeanCalculate()
							self.MalfunctionMean = math.max(0, self.MalfunctionMeanCopy * (durability / 100))
						end
					end
				end
			end
		end

		for _, v in pairs(ix.item.list) do
			if (!v.isWeapon) then continue end

			v.functions.Repair = {
				name = "Repair",
				tip = "equipTip",
				icon = "icon16/bullet_wrench.png",
				OnRun = function(item)
					local client = item.player
					local itemKit = client:GetCharacter():GetInventory():HasItemOfBase("base_repair_kit")

					if (itemKit and itemKit.isWeaponKit) then
						itemKit:UseRepair(item, client)
						client:SetLocalVar("WeaponDurability", nil)

						itemKit = nil
					else
						client:NotifyLocalized('RepairKitWrong')
					end

					return false
				end,

				OnCanRun = function(item)
					if (item.player and (item.player.nextUseItem or 0) > CurTime() or item:GetData("durability", 100) >= 100) then
						return false
					end

					if (!item.player:GetCharacter():GetInventory():HasItemOfBase("base_repair_kit")) then
						return false
					end

					return true
				end
			}
		end
	end
end