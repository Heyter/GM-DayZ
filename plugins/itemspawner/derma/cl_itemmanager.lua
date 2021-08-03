
local PLUGIN = PLUGIN
PLUGIN.ISM_Panel = PLUGIN.ISM_Panel or nil

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrH() * 0.8, ScrH() * 0.8)
	self:Center()
	self:SetBackgroundBlur(false)
	self:SetDeleteOnClose(true)
	self:MakePopup()
	self:SetTitle("Item Spawn Manager")

	self.container = vgui.Create("DScrollPanel", self)
	self.container:Dock(FILL)

	self.colors = {
		[1] = derma.GetColor("ButtonRect", self),
		[2] = derma.GetColor("Outline", self),
	}

	PLUGIN.ISM_Panel = self
end

function PANEL:Populate(items)
	self.index = {}

	for index, item in ipairs(items) do
		self.index = self.container:Add("DPanel")
		self.index:Dock(TOP)
		self.index:SetHeight(64)
		self.index:DockMargin(5, 5, 5, 0)
		self.index.Paint = function(t, w, h)
			surface.SetDrawColor(self.colors[1])
			surface.DrawRect(0, 0, w, h)
		end

		self.index.leftPanel = self.index:Add("DPanel")
		self.index.leftPanel:Dock(LEFT)
		self.index.leftPanel:SetSize(300, 0)
		self.index.Paint = function(t, w, h)
			surface.SetDrawColor(self.colors[2])
			surface.DrawRect(0, 0, w, h)
		end

		self.index.title = self.index.leftPanel:Add("DLabel")
		self.index.title:SetText(item.title)
		self.index.title:Dock(TOP)
		self.index.title:DockMargin(10, 5, 0, 0)
		self.index.title:SetFont("ixMediumFont")
		self.index.title:SetColor(ix.config.Get("color", color_white))

		self.index.update = self.index.leftPanel:Add("DLabel")
		self.index.update:SetText("Задержка: " .. item.delay .. " мин.")
		self.index.update:Dock(TOP)
		self.index.update:SetFont("ixToolTipText")
		self.index.update:DockMargin(10, 5, 0, 0)

		local chance = "Обычный"

		if (item.chance_type == 1) then
			chance = "Вещественный"
		elseif (item.chance_type == 2) then
			chance = "Линейный"
		end

		self.index.type = self.index.leftPanel:Add("DLabel")
		self.index.type:SetText("Рандом: " .. chance .. " (" .. (item.scale or 1) .. ")")
		self.index.type:Dock(BOTTOM)
		self.index.type:SetFont("ixToolTipText")
		self.index.type:DockMargin(10, 5, 0, 0)

		self.index.avatar = vgui.Create("AvatarImage", self.index)
		self.index.avatar:SetSize(64, 64)
		self.index.avatar:Dock(RIGHT)
		self.index.avatar:SetSteamID(item.author, 64)

		self.index.delete = vgui.Create("DButton", self.index)
		self.index.delete:Dock(RIGHT)
		self.index.delete:SetText("Удалить")
		self.index.delete.DoClick = function()
			net.Start("ixItemSpawnerSync")
				net.WriteUInt(index, 12)
			net.SendToServer()
		end
		self.index.delete.Paint = function(self, w, h) end

		self.index.edit = vgui.Create("DButton", self.index)
		self.index.edit:Dock(RIGHT)
		self.index.edit:SetText("Изменить")
		self.index.edit.DoClick = function()
			self.editor = vgui.Create("ixItemSpawnerEditor")
			self.editor:Setup(item, index)
		end
		self.index.edit.Paint = function(self, w, h) end

		self.index.teleport = vgui.Create("DButton", self.index)
		self.index.teleport:Dock(RIGHT)
		self.index.teleport:SetText("Телепорт")
		self.index.teleport.DoClick = function()
			net.Start("ixItemSpawnerGoto")
				net.WriteVector(item.position)
			net.SendToServer()
		end
		self.index.teleport.Paint = function(self, w, h) end

		self.index.spawn = vgui.Create("DButton", self.index)
		self.index.spawn:Dock(RIGHT)
		self.index.spawn:SetText("Создать")
		self.index.spawn.DoClick = function()
			net.Start("ixItemSpawnerSpawn")
				net.WriteTable(item)
			net.SendToServer()
		end
		self.index.spawn.Paint = function(self, w, h) end
	end
end

function PANEL:Paint(w, h)
	derma.SkinFunc("PaintFrame2", self, w, h)
end

vgui.Register("ixItemSpawnerManager", PANEL, "DFrame")
