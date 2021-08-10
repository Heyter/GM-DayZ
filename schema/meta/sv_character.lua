local META = ix.meta.inventory

-- Синхронизация инвентаря без OnSendData
function META:HalfSync(receiver)
	local slots = {}

	for x, items in pairs(self.slots) do
		for y, item in pairs(items) do
			if (istable(item) and item.gridX == x and item.gridY == y) then
				slots[#slots + 1] = {x, y, item.uniqueID, item.id, item.data}
			end
		end
	end

	net.Start("ixInventorySync")
		net.WriteTable(slots)
		net.WriteUInt(self:GetID(), 32)
		net.WriteUInt(self.w, 6)
		net.WriteUInt(self.h, 6)
		net.WriteType(self.owner)
		net.WriteTable(self.vars or {})
	net.Send(receiver)
end

ix.meta.inventory = META