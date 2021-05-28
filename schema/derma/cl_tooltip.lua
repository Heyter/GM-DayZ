do
	local PANEL = FindMetaTable("Panel")

	function PANEL:SetHelixTooltip(callback)
		if (IsValid(self)) then
			self:SetMouseInputEnabled(true)
			self.ixTooltip = callback
		end
	end
end