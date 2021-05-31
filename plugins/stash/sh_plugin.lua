PLUGIN.name = "Stash"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "You save your junk in the stash."

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

	characterMeta.GetStashCount = function(self)
		local stash = self:GetStash()

		if (stash[0] and stash[0].max != nil) then
			return stash[0].max
		end

		local i = 0

		for k, v in pairs(stash) do
			if k == 0 then continue end
			i = i + 1
		end

		return i
	end

	characterMeta.GetStashMax = function(self)
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
		else
			ErrorNoHalt("[Helix] Attempt to index unknown item '"..uniqueID.."'\n")
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
		if (character:GetStashCount() >= character:GetStashMax()) then
			LocalPlayer():NotifyLocalized("stash_full")
			return
		end

		local items = character:GetInventory():GetItems(true)
		local id = item:GetID()
		local item = items and items[id]

		if (item) then
			if (item.data) then
				item.data.equip = nil

				if (item.data.ammo and item.data.ammo < 1) then
					item.data.ammo = nil
				end
			end

			local stash = character:GetStash()
			local index = #stash + 1
			stash[index] = {
				uniqueID = item.uniqueID,
				data = item.data or {}
			}

			ix.gui.stash:AddItem(index, stash[index])
			ix.gui.stash.entityItems[index] = stash[index]

			net.Start("ixStashDepositItem")
				net.WriteUInt(id, 32)
			net.SendToServer()

			if (ix.item.inventories[icon.inventoryID]) then
				ix.item.inventories[icon.inventoryID]:Remove(id)

				for _, v in ipairs(icon.slots or {}) do
					if (v.item == icon) then
						v.item = nil
					end
				end

				icon:Remove()
			end
		end
	end

	function PLUGIN:CreateItemInteractionMenu(icon, menu, item)
		local character = LocalPlayer():GetCharacter()

		if (IsValid(ix.gui.stash) and character:GetStashCount() < character:GetStashMax()) then
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

		local panel = vgui.Create("ixStashView")
		panel:SetLocalInventory(character:GetInventory(), character:GetMoney())
		panel:SetStash(character:GetStash())

		for _, v in ipairs(ents.FindInSphere(EyePos(), 256)) do
			if (v and v:GetClass() == "gmodz_stash") then
				v:EmitSound("items/ammocrate_open.wav")
				break
			end
		end
	end)
end