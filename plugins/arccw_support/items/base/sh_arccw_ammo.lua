ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammo = "pistol" -- type of the ammo
ITEM.ammoAmount = 30 -- amount of the ammo
ITEM.description = "A Box that contains %s of Pistol Ammo"
ITEM.category = "Ammunition"
ITEM.useSound = "items/ammo_pickup.wav"

ITEM.maxRounds = 90 -- макс. патронов помещаемых в одну коробку

function ITEM:GetDescription()
	local rounds = self:GetData("rounds", self.ammoAmount)
	return Format(self.description, rounds)
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local rounds = item:GetData("rounds", item.ammoAmount)
		local color = ix.color.LerpHSV(nil, nil, item.maxRounds, rounds, 0)

		draw.SimpleTextOutlined(rounds, "GmodZ.Numeric", 1, 5, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
	end

	function ITEM:CanTooltip(targetItem)
		return targetItem.isWeapon and targetItem.ammo == self.ammo
	end
end

if (SERVER) then
	function ITEM:CanStack(combineItem)
		local rounds = self:GetData("rounds", self.ammoAmount)

		return combineItem:GetData("rounds", combineItem.ammoAmount) == rounds and rounds >= self.maxRounds
	end
else
	function ITEM:CanStack(combineItem, isVendor)
		local rounds = self:GetData("rounds", self.ammoAmount)
		local isEqual = combineItem:GetData("rounds", combineItem.ammoAmount) == rounds

		if (isVendor) then
			return isEqual
		end

		return isEqual and rounds >= self.maxRounds
	end
end

function ITEM:GetSellPrice(base_price)
	return base_price * (self:GetData("rounds", self.ammoAmount) / self.maxRounds)
end

ITEM.functions.combine = {
	OnRun = function(itemSelf, data)
        local combineItem = ix.item.instances[data[1]]
        if (!combineItem or itemSelf.uniqueID != combineItem.uniqueID) then return false end

		ix.arccw_support.StackAmmo(itemSelf, combineItem)
		return false
	end,

	OnCanRun = function(itemSelf, data)
		if (CLIENT) then
			if (istable(data) and data[1]) then
				local combineItem = ix.item.instances[data[1]]

				if (itemSelf.uniqueID == combineItem.uniqueID) then
					return itemSelf:CanStack(combineItem)
				end
			else
				return false
			end
		end

		return istable(data) and data[1]
	end
}