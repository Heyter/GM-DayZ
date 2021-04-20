-- Thanks thelastpenguin

local matTile = ix.util.GetMaterial('gmodz/gui/concrete/tile.png')
local matSelected = ix.util.GetMaterial('gmodz/gui/concrete/borderselected.png')
local inactive_slot = Color(200, 200, 200)
local active_slot = Color(50, 255, 50, 200)

-- Icon slot --
local PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(false)
	
	self.icon = vgui.Create('SpawnIcon', self)
	self.name = Label('', self)
	self.name:SetFont('GmodZ_HB_SlotLabel')

	self.weaponMaterial = nil
end

function PANEL:SetStack(weapon)
	self.weaponName = weapon[3]
	self.weaponModel = weapon[4]

	if (IsValid(weapon[2])) then
		if (IsValid(self.icon)) then
			self.icon:Remove()
		end

		if (self.weaponMaterial) then
			self.icon = self:Add("DImage")
		else
			self.icon = self:Add("SpawnIcon")
		end

		self.icon:SetMouseInputEnabled(false)

		self.name:SetText(self.weaponName)
		self.name:SizeToContents()

		self.name:SetVisible(true)
		self.icon:SetVisible(true)
	else
		self.name:SetVisible(false)
		self.icon:SetVisible(false)
	end

	self:InvalidateLayout(true)
end

function PANEL:PerformLayout()
	local w, h = self:GetSize()

	if (self.weaponModel and #self.weaponModel > 0 or self.weaponMaterial) then
		self.icon:InvalidateLayout(true)
		self.icon:SetSize(w, h)

		if (self.weaponMaterial) then
			self.icon:SetMaterial(self.weaponMaterial)
		elseif (self.weaponModel) then
			self.icon:SetModel(self.weaponModel)
		end

		self.icon:Center()
	end

	self.name:SetPos((w - self.name:GetWide()) * 0.5, h * 0.97 - self.name:GetTall())
end

function PANEL:Paint() end
vgui.Register('gmodz_hotbar_stackicon', PANEL)

-- THE HOTBAR
PANEL = {}
function PANEL:Init()
	self.weapons = ix.hotbar.weaponSlots
	self.slots = {}

	for i = 1, #self.weapons do
		local p = self:Add("gmodz_hotbar_slot")
		p:SetIndex(i)

		self.slots[i] = p
	end

	self:InvalidateLayout(true)
end

function PANEL:PerformLayout()
	self:SetSize(ScrW(), ScrH() * 0.12)
	self:SetPos(ScrW() - self:GetWide(), 0)

	local mh = select(2, self:GetSize())
	local width, padding = 0, 5

	for _, v in pairs(self.slots)do
		v:PerformLayout()
		width = width + v:GetWide() + padding
	end

	local x = (self:GetWide() - width) * 0.5

	for i = 1, #self.weapons do
		local p = self.slots[i]

		if (IsValid(p)) then
			p:SetPos(x, mh - p:GetTall())
			x = x + p:GetWide() + padding
		end
	end
end

function PANEL:Paint(w,h)
	local t = math.Clamp(CurTime() - ix.hotbar.lastSwitch, 0, ix.hotbar.animLength)
	local f = 1 - t / ix.hotbar.animLength

	if (f == 0) then 
		ix.hotbar.panel = nil
		self:Remove() 
		return
	end

	self:SetAlpha(f * 255)
end

vgui.Register('gmodz_hotbar', PANEL)

-- A SLOT ON THE HOTBAR...
PANEL = {}
function PANEL:Init()
end

function PANEL:SetIndex(index)
	self.index = index
	self.label = Label(tonumber(self.index), self)

	self.icon = self:Add("gmodz_hotbar_stackicon")
	self.icon:SetStack(ix.hotbar.weaponSlots[index])
	self:InvalidateLayout(true)
end

function PANEL:PerformLayout()
	local p = self:GetParent()
	local s = self.index == ix.hotbar.activeSlot and p:GetTall() * 0.9 or p:GetTall() * 0.8

	self:SetSize(s, s)
	self.icon:SetSize(self:GetSize())

	if (self.index == ix.hotbar.activeSlot) then
		self.label:SetColor(color_white)
		self.label:SetFont('GmodZ_HB_ActiveSlot')
	else
		self.label:SetColor(inactive_slot)
		self.label:SetFont('GmodZ_HB_InactiveSlot')
	end

	self.label:SizeToContents()
	self.label:SetPos(5,0)
end

function PANEL:Paint(w, h)
	if (self.index == ix.hotbar.activeSlot) then
		surface.SetDrawColor(color_white)
	else
		surface.SetDrawColor(inactive_slot)
	end

	surface.SetMaterial(matTile)
	surface.DrawTexturedRect(0, 0, w, h)

	if (self.index == ix.hotbar.activeSlot) then
		surface.SetDrawColor(active_slot)
		surface.SetMaterial(matSelected)
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

vgui.Register('gmodz_hotbar_slot', PANEL)