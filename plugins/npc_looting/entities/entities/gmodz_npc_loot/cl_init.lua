include("shared.lua")

ENT.PopulateEntityInfo = true

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnPopulateEntityInfo(container)
	local useText = string.upper(Format("[%s]", input.LookupBinding("+use")) or "NA")

	local name = container:AddRow("name")
	name:SetText(Format("%s %s", useText, L"to_loot"))
	name:SizeToContents()
end