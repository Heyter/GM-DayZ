local BUFF = ix.buff.meta or {}

BUFF.__index = BUFF
BUFF.uniqueID = "undefined"

BUFF.time = 30 -- сколько секунд длится бафф
BUFF.time_max = 60
BUFF.permanently = false -- постоянный ли бафф, пока не будет удален вручную.
BUFF.isOnlyServer = false -- отправлять бафф на клиента
BUFF.isAdditive = true -- Суммировать бафф ( CurTime() + ((PLAYER.buffs[uniqueID] or 0) + buff.time) )

function BUFF:__tostring()
	return "buff["..self.uniqueID.."]"
end

function BUFF:OnRun(client) end -- бафф работает, вызывается каждую секунду.
function BUFF:OnRemove(client) end -- бафф был удален

function BUFF:Timer(client, delay, reps, func)
	local id = "ixBuffTimer_" .. tostring(self) .. client:EntIndex()

	timer.Create(id, delay, reps, func)
	client.timer_buffs = client.timer_buffs or {}
	client.timer_buffs[id] = true
end

function BUFF:TimerRemove(client)
	local id = "ixBuffTimer_" .. tostring(self) .. client:EntIndex()

	timer.Remove(id)

	client.timer_buffs = client.timer_buffs or {}
	client.timer_buffs[id] = nil
end

function BUFF:TimerAdjust(client, delay, reps, func)
	timer.Adjust("ixBuffTimer_" .. tostring(self) .. client:EntIndex(), delay, reps, func)
end

function BUFF:TimerExists(client)
	return timer.Exists("ixBuffTimer_" .. tostring(self) .. client:EntIndex())
end

-- @realm shared
-- BUFF:OnRunOnce(client) // Вызывается 1 раз

ix.buff.meta = BUFF