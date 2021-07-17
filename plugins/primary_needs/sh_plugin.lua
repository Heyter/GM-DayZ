PLUGIN.name = "Primary needs"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Adds thirst, hunger."

ix.config.Add("hungrySeconds", 3600, "Через сколько секунд наступит голод", nil, {
	data = {min = 100, max = 10000},
	category = PLUGIN.name
})

ix.config.Add("thirstySeconds", 3000, "Через сколько секунд наступит жажда", nil, {
	data = {min = 100, max = 10000},
	category = PLUGIN.name
})

ix.config.Add("needsTime", 1, "Время, которое вычитается из голода/жажды.", nil, {
	data = {min = 1, max = 600},
	category = PLUGIN.name
})

-- PLAYER META | SHARED
do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:GetHungerPercent()
		return math.Clamp((CurTime() - self:GetLocalVar("hunger", 0)) / ix.config.Get("hungrySeconds", 3500), 0, 1)
	end

	function playerMeta:GetThirstPercent()
		return math.Clamp((CurTime() - self:GetLocalVar("thirst", 0)) / ix.config.Get("thirstySeconds", 2000), 0, 1)
	end
end

ix.util.Include("sv_plugin.lua")

function PLUGIN:CanPlayerRegenHealth(client)
	if (client:GetNetVar("bleeding")) then
		return false
	end
end

function PLUGIN:AdjustStaminaOffset(client, offset)
	if (client:GetLocalVar("energyStamina", 0) > CurTime()) then
		return offset * 1.65
	end
end

if (CLIENT) then
	function PLUGIN:HUDExtraPaint(client, perc, hud, margin)
		if (client:GetLocalVar("energyStamina", 0) > CurTime()) then
			local time = math.max(0, client:GetLocalVar("energyStamina", 0) - CurTime())

			perc.textColor = color_white
			perc.y = perc.y - perc.h - margin
			hud:drawText(perc, L"Endurance":utf8upper() .. " " .. string.ToMinutesSeconds(time))
		end
	end
end