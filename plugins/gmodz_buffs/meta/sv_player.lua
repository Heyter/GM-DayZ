local playerMeta = FindMetaTable("Player")

function playerMeta:AddBuff(uniqueID)
	local buff = ix.buff.list[uniqueID]

	if (buff) then
		self.buffs = self.buffs or {}
		local value

		if (buff.permanently) then
			value = true
		else
			if (buff.isFold) then
				if (self.buffs[uniqueID]) then
					value = math.Clamp((self.buffs[uniqueID] - CurTime()) + buff.time, 0, buff.time_max)
				end

				value = CurTime() + (value or buff.time)
			else
				value = CurTime() + buff.time
			end
		end

		self.buffs[uniqueID] = value

		if (!buff.isOnlyServer) then
			net.Start("ixBuffAdd")
				net.WriteString(uniqueID)
				net.WriteType(value)
			net.Send(self)
		end

		if (buff.OnRunOnce) then
			buff:OnRunOnce(self)
		end

		-- постоянные баффы, не требуют таймера.
		if (buff.permanently) then return end

		timer.Create("ixBuff_" .. self:EntIndex(), 1, 0, function()
			for id, v in pairs(self.buffs) do
				if (isnumber(v)) then
					if (v < CurTime()) then
						self.buffs[id] = nil
						ix.buff.list[id]:OnRemove(self)
					else
						ix.buff.list[id]:OnRun(self)
					end
				end
			end

			if (table.IsEmpty(self.buffs) or !self:Alive()) then
				self:ClearBuffs()
			end
		end)
	end
end

function playerMeta:RemoveBuff(uniqueID)
	if (self.buffs[uniqueID]) then
		self.buffs[uniqueID] = nil

		if (ix.buff.list[uniqueID] and !ix.buff.list[uniqueID].isOnlyServer) then
			net.Start("ixBuffRemove")
				net.WriteString(uniqueID)
			net.Send(self)
		end

		if (table.IsEmpty(self.buffs)) then
			self:ClearBuffs()
		end
	end
end

function playerMeta:ClearBuffs(bOnlyTimer)
	timer.Remove("ixBuff" .. self:EntIndex())

	if (!bOnlyTimer) then
		self.buffs = {}

		net.Start("ixBuffClears")
		net.Send(self)

		self.timer_buffs = self.timer_buffs or {}

		for timerID in pairs(self.timer_buffs) do
			timer.Remove(timerID)
			self.timer_buffs[timerID] = nil
		end

		self.timer_buffs = {}
	end
end


-- TODO: удалить
concommand.Add("add_buff", function(c)
	c:AddBuff("adrenaline")
end)

concommand.Add("clear_buff", function(c)
	c:ClearBuffs()
end)