include("shared.lua")

ENT.PopulateEntityInfo = true

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText(L'merchant_title')
	name:SizeToContents()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
		end
	end)
end