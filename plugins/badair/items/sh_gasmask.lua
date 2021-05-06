ITEM.name = "Respirator"
ITEM.model = "models/barneyhelmet_faceplate.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.isGasMask = true
ITEM.price = 250
ITEM.category = "Outfit"
ITEM.iconCam = {
	pos = Vector(133.12742614746, 109.28756713867, 78.981819152832),
	ang = Angle(25, 220, 0),
	fov = 4.5012266396634,
	outline = true,
	outlineColor = color_white
}
ITEM.exRender = true
ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(8.4950472228229e-005, -66.922698974609, -89.999969482422),
					["UniqueID"] = "3085914138",
					["ClassName"] = "model",
					["Size"] = 0.95,
					["EditorExpand"] = true,
					["Model"] = "models/barneyhelmet_faceplate.mdl",
					["Position"] = Vector(3.3733520507813, -1.6019897460938, -0.10595703125),
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "GASMASK_MODEL",
			["ClassName"] = "group",
			["Name"] = "my outfit",
			["Description"] = "add parts to me!",
		},
	},
}

function ITEM:OnGetDropModel(entity)
	return "models/props_junk/cardboard_box004a.mdl"
end

function ITEM:GetDescription()
	if (self.entity) then
		return L"gasMaskDescEntity"
	else
		return L("gasMaskDesc")
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end

		local health = math.max(0, math.floor((item:GetHealth() / ix.config.Get("gasmask_health", 100)) * 100))
		local healthColor = Color(2.55 * (100 - health), 2.55 * health, 0, 255)

		draw.SimpleText(health .. "%", "ixMerchant.Num", 1, h - 10, healthColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
	end
end

function ITEM:GetHealth()
	return self:GetData("health", ix.config.Get("gasmask_health", 100))
end

function ITEM:DamageHealth(amount)
	self:SetData("health", math.max(0, self:GetHealth() - amount))
end

function ITEM:GetFilter()
	return self:GetData("filter", ix.config.Get("gasmask_filter", 600))
end

function ITEM:DamageFilter(amount)
	self:SetData("filter", math.max(0, self:GetFilter() - amount))
end

function ITEM:Equip(client, bSound)
	client.ixGasMaskItem = self

	if (client.AddPart) then
		client:AddPart(self.uniqueID)
	end

	net.Start("ixMaskOn")
		net.WriteUInt(self:GetID(), 32)
		net.WriteUInt(self:GetHealth(), 16)
	net.Send(client)

	self:SetData("equip", true)

	if (bSound) then
		client:EmitSound("gasmaskon.wav", 80)
		client:ScreenFade(1, color_black, 1, 0)
	end
end

function ITEM:Unequip(client, bSound)
	client.ixGasMaskItem = nil

	if (client.RemovePart) then
		client:RemovePart(self.uniqueID)
	end

	net.Start("ixMaskOff")
	net.Send(client)

	self:SetData("equip", nil)

	if (bSound) then
		client:EmitSound("gasmaskoff.wav", 80)
		client:ScreenFade(1, color_black, 1, 0)
	end
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item:Unequip(item.player, true)
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)		
		item:Unequip(item.player, true)

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and item:GetData("equip"))
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player

		if (client.ixGasMaskItem) then
			client:NotifyLocalized("maskEquipped")

			return false
		end

		item:Equip(client, true)
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and !item:GetData("equip"))
	end
}

local function ChangeFilter(client, item, targetItem)
	if (item and targetItem and targetItem.isFilter) then
		local filter = targetItem:GetFilterHealth()
		item:SetData("filter", filter)
		
        client:NotifyLocalized("filterChanged")
		return true
	end

	return false
end

-- for external use.
function ITEM:ChangeFilter(client, item, targetItem)
	if (item:CanChangeFilter()) then
		return ChangeFilter(client, item, targetItem)
	else
		client:NotifyLocalized("maskFull")
		
		return false
	end
end

function ITEM:CanChangeFilter()
	return (self:GetHealth() > 0 and self:GetFilter() < ix.config.Get("gasmask_filter", 600))
end

ITEM.functions.Filter = {
	name = "Change Filter",
	tip = "filterTip",
	icon = "icon16/wrench.png",
	isMulti = true,
	multiOptions = function(item, client)
		local items = client:GetItems()
		local result = {}

		if (items) then
			for _, v in pairs(items) do
				if (v.isFilter) then
					result[#result + 1] = {
						name = Format("%s (%s)", v.name, v:GetFilterHealth() or 0),
						data = {v:GetID()}
					}
				end
			end
		end

		return result
	end,
	OnRun = function(item, data)
		local client = item.player
		if (item:CanChangeFilter()) then
			local items = client:GetItems() or {}
			local target

			if (istable(data) and data[1]) then
				target = ix.item.instances[data[1]]
				
				if (!items[target.id]) then
					return false -- stop hacking you dumb fuck
				end
			else
				for k, invItem in pairs(items) do
					if (invItem.isFilter) then
						target = invItem
						
						break
					end
				end
			end

			if (target) then
				if (ChangeFilter(client, item, target)) then
					target:Remove()
				end
			else
				client:NotifyLocalized("noFilter")
			end
		else
			client:NotifyLocalized("maskFull")
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and item:CanChangeFilter())
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end