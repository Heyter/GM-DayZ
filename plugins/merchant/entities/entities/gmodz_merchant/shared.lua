ENT.Type = "anim"
ENT.PrintName = "Merchant"
ENT.Category = "GmodZ"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isMerchant = true
ENT.bNoPersist = true

function ENT:SetAnim()
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v != "idlenoise") then
			return self:ResetSequence(k)
		end
	end

	if (self:GetSequenceCount() > 1) then
		self:ResetSequence(4)
	end
end