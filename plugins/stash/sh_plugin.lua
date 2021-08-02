PLUGIN.name = "Stash"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "You save your junk in the stash."

ix.stash = ix.stash or {}

ix.config.Add("maxStash", 100, "Макс. размер хранилища по умолчанию.", nil, {
	data = {min = 1, max = 1000},
	category = PLUGIN.name
})

ix.char.RegisterVar("stash", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "stash",
	fieldType = ix.type.text
})

do
	local characterMeta = ix.meta.character

	characterMeta.GetStashWeight = function(self)
		local stash = self:GetStash()

		if (istable(stash[0])) then
			return stash[0].weight or 0
		end

		return ix.stash.CalculateWeight(stash)
	end

	characterMeta.GetStashWeightMax = function(self)
		return ix.config.Get("maxStash", 100)
	end

	characterMeta.GetStashMoney = function(self)
		return self:GetStash()[0] and self:GetStash()[0].money or 0
	end
end

ix.util.Include("sv_plugin.lua", "server")

if (CLIENT) then
	local PLUGIN = PLUGIN
	PLUGIN.virtual_items = PLUGIN.virtual_items or {}

	function PLUGIN:MakeVirtualItem(uniqueID, id)
		if (self.virtual_items[id] and self.virtual_items[id].uniqueID == uniqueID) then
			return self.virtual_items[id]
		end

		local stockItem = ix.item.list[uniqueID]

		if (stockItem) then
			local item = setmetatable({id = id, data = {}}, {
				__index = stockItem,
				__eq = stockItem.__eq,
				__tostring = stockItem.__tostring
			})

			self.virtual_items[id] = item

			return item
		end
	end

	function PLUGIN:Think()
		if (IsValid(ix.gui.stash)) then
			if (IsValid(ix.gui.menu) or !LocalPlayer():Alive() or !LocalPlayer():GetCharacter()) then
				ix.gui.stash:Remove()
			end
		end
	end

	function PLUGIN:DepositItem(character, icon, item)
		if ((LocalPlayer().next_stash_click or 0) < CurTime()) then
			LocalPlayer().next_stash_click = CurTime() + 1.25
		else
			return
		end

		local totalWeight, maxWeight = character:GetStashWeight(), character:GetStashWeightMax()
		if (totalWeight >= maxWeight) then
			LocalPlayer():NotifyLocalized("stash_full")
			return
		end

		local items = character:GetInventory():GetItems(true)
		local id = item:GetID()
		local item = items and items[id]

		if (item) then
			local allStack = input.IsShiftDown()
			local result, newQuantity = item:UseStackItem(allStack, function(new, old)
				local diff = totalWeight + (old - new)
				local remainder = new - (maxWeight - diff)

				if (diff > maxWeight) then
					return remainder, (old - new) - remainder
				end

				return new, old
			end)

			if (item.data) then
				item.data.equip = nil

				if (item.data.ammo and item.data.ammo < 1) then
					item.data.ammo = nil
				end
			end

			local stash = character:GetStash()
			local stashItem
			local copyData = table.Copy(item.data or {})

			if (!item.isStackable) then -- оружием там и прочее
				copyData.quantity = 1

				for i = 1, newQuantity do
					local index = #stash + 1

					stash[#stash + 1] = {
						uniqueID = item.uniqueID,
						data = copyData
					}

					ix.gui.stash:AddItem(index, stash[index])
				end
			else
				copyData.quantity = nil

				local index = #stash + 1
				for i, v in pairs(stash) do
					if (v.uniqueID == item.uniqueID) then
						index = i
						break
					end
				end

				stashItem = stash[index] or {data = {}}
				stashItem.uniqueID = item.uniqueID
				stashItem.data.quantity = (stashItem.data.quantity or 0) + newQuantity

				for k, v in pairs(copyData) do
					stashItem.data[k] = stashItem.data[k] or v
				end

				stash[index] = stashItem
				ix.gui.stash:AddItem(index, stash[index])
			end

			stash[0] = stash[0] or {}
			stash[0].weight = ix.stash.CalculateWeight(stash)

			copyData = nil

			net.Start("ixStashDepositItem")
				net.WriteUInt(id, 32)
				net.WriteBool(allStack)
			net.SendToServer()
		end
	end

	-- Left mouse button + SHIFT
	function PLUGIN:ItemPressedLeftShift(icon, item)
		if (IsValid(ix.gui.stash)) then
			PLUGIN:DepositItem(LocalPlayer():GetCharacter(), icon, item)
		end
	end

	function PLUGIN:CreateItemInteractionMenu(icon, menu, item)
		local character = LocalPlayer():GetCharacter()

		if (IsValid(ix.gui.stash)) then
			local inventory = character:GetInventory()

			if (inventory and inventory.slots) then
				menu:AddOption(L"deposit", function()
					PLUGIN:DepositItem(character, icon, item)
				end):SetImage("icon16/package_add.png")

				menu:AddSpacer()
			end
		end
	end

	function PLUGIN:LoadFonts()
		surface.CreateFont("Stash3D2DTextSmall",
		{
			font = "Jura",
			size = 32,
			weight = 100,
			extended = true,
		})

		surface.CreateFont("Stash3D2DTextLarge",
		{
			font = "Jura",
			size = 72,
			weight = 500,
			extended = true,
		})
	end

	net.Receive("ixStashSync", function()
		local character = LocalPlayer():GetCharacter()
		local data = net.ReadTable()
		character.vars["stash"] = data

		local panel = vgui.Create("ixStashView")
		panel:SetLocalInventory(character:GetInventory(), character:GetMoney())
		panel:SetStash(data)

		for _, v in ipairs(ents.FindInSphere(EyePos(), 256)) do
			if (v and v:GetClass() == "gmodz_stash") then
				v:EmitSound("items/ammocrate_open.wav")
				break
			end
		end
	end)
end

function ix.stash.CalculateWeight(data)
	if (!istable(data)) then return 0 end

	local weight = 0

	for k, v in pairs(data) do
		if (k == 0) then continue end

		if (v.data and !v.data.noWeight) then
			weight = weight + v.data.quantity
		end
	end

	return weight
end