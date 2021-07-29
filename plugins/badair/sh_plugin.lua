local PLUGIN = PLUGIN
PLUGIN.name = "Bad Air Remastered"
PLUGIN.author = "Black Tea | Ported by STEAM_0:1:29606990"
PLUGIN.description = "Remasted Bad Air Plugin"

ix.config.Add("gasmask_health", 100, "GasMask Health" , nil, {
	data = {min = 1, max = 9999},
	category = PLUGIN.name
})

ix.config.Add("gasmask_filter", 600, "The duration of the filter in seconds." , nil, {
	data = {min = 60, max = 9999},
	category = PLUGIN.name
})

ix.config.Add("gasmask_damage", 1, "How much damage gas mask filter does." , nil, {
	data = {min = 0, max = 100},
	category = PLUGIN.name
})

ix.config.Add("gasDelay", 2, "How long between gas damage.", nil, {
	data = {min = 1, max = 128},
	category = PLUGIN.name
})

ix.config.Add("gasDelayBad", 1.3, "How long between gas damage without filter or gas mask.", nil, {
	data = {min = 0.1, max = 128, decimals = 1},
	category = PLUGIN.name
})

ix.config.Add("gasDamage", 3, "How much damage gas does.", nil, {
	data = {min = 0, max = 100},
	category = PLUGIN.name
})

ALWAYS_RAISED["badair_gasmask_deploy"] = true
ALWAYS_RAISED["badair_gasmask_holster"] = true
ALWAYS_RAISED["badair_gasmask_changefilter"] = true

ix.util.Include("sv_plugin.lua")

do
	function PLUGIN:SetupAreaProperties()
		ix.area.AddType("gas")
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:GetGasMask()
		return self.ixGasMaskItem 
	end
end

if (CLIENT) then
	local gasmaskTexture2 = Material("gmdz/gasmask")
	local gasmaskTexture = Material("gmdz/shtr")
	local w, h, gw, gh, margin, move, healthFactor, ft
	local nextBreath = CurTime()
	local exhale = false

	-- Local function for condition.
	local function canEffect(client)
		return (
			client:GetCharacter() and
			client:GetGasMask() and
			!client:ShouldDrawLocalPlayer() and
			(!ix.gui.characterMenu or !ix.gui.characterMenu:IsVisible())
		)
	end

	shtrPos = {}

	-- Draw the Gas Mask Overlay. But other essiential stuffs must be visible.
	function PLUGIN:HUDPaintBackground()
		if (canEffect(LocalPlayer())) then
			w, h = ScrW(), ScrH()
			-- gw, gh = h/3*4, h
			gw, gh = h/1*2, h -- local gasmaskTexture2 = Material("morganicism/metroredux/gasmask/metromask2")

			surface.SetMaterial(gasmaskTexture)
			for k, v in ipairs(shtrPos) do
				surface.SetDrawColor(255, 255, 255)
				surface.DrawTexturedRectRotated(v[1], v[2], 512*v[3], 512*v[3], v[4])
			end

			render.UpdateScreenEffectTexture()
			surface.SetMaterial(gasmaskTexture2)
			surface.SetDrawColor(255, 255, 255)
			surface.DrawTexturedRect(w/2 - gw/2, h/2 - gh/2, gw, gh)

			surface.SetDrawColor(0, 0, 0)
			surface.DrawRect(0, 0, w/2 - gw/2, h)
			surface.DrawRect(0, 0, w, h/2 - gh/2)
			surface.DrawRect(0, h/2 + gh/2, w, h/2 - gh/2)
			surface.DrawRect(w/2 + gw/2, 0, w/2 - gw/2, h)
		end
	end

	function PLUGIN:Think()
		local client = LocalPlayer()
		local item = client:GetGasMask()

		if (client:GetCharacter() and client:Alive() and item) then
			healthFactor = math.Clamp(client:Health()/client:GetMaxHealth(), 0, 1)

			if (!client.nextBreath or client.nextBreath < CurTime()) then
				client:EmitSound(!exhale and "gmodz/player/gasmask_inhale.wav" or "gmodz/player/gasmask_exhale.wav", 
				(LocalPlayer() == client and client:ShouldDrawLocalPlayer() or item:GetHealth() <= 0) and 20 or 50, math.random(90, 100) + 15*(1 - healthFactor))
				
				local f = healthFactor*.5
				client.nextBreath = CurTime() + 1 + f + (exhale and f or 0)
				exhale = !exhale
			end
		end
	end

	function PLUGIN:PopulateItemTooltip(tooltip, item)
		if (!item.isGasMask) then
			return
		end

		local text, color = Schema:GetConditionStatus(item:GetHealth())

		local filter = tonumber(item:GetFilter()) or 0
		local percentage = math.floor((item:GetHealth() / ix.config.Get("gasmask_health", 100)) * 100)

		local panel = tooltip:AddRowAfter("description", "conditionGasMask")
		panel:SetText(L("conditionDesc", text, percentage))
		panel:SetBackgroundColor(color)
		panel:SizeToContents()

		if (filter <= 0) then
			color = Schema.conditionStatus[5][3]
			text = "txtFail"
		else
			color = Schema.conditionStatus[1][3]
			text = "txtFunc"
		end

		panel = tooltip:AddRowAfter("conditionGasMask", "filterGasMask")
		panel:SetText(L("gasMaskFilterDesc", L(text), filter))
		panel:SetBackgroundColor(color)
		panel:SizeToContents()
	end

	-- Local functions for the Visibility of the crack.
	local function addCrack()
		shtrPos[#shtrPos + 1] = {math.random(0, ScrW()), math.random(0, ScrH()), math.Rand(.9, 2), math.random(0, 360)}
	end

	local function initCracks(crackNums)
		for i = 1, math.max(crackNums, 1) do
			addCrack()
		end
	end

	net.Receive("ixMaskOn", function()
		local id = net.ReadUInt(32)
		local health = net.ReadUInt(16)

		local item = ix.item.instances[id]

		if (item) then
			local crackNums = math.Round((1 - health/ix.config.Get("gasmask_health", 100))*6)

			shtrPos = {}
			if (crackNums > 1) then
				initCracks(crackNums)
			end

			LocalPlayer().ixGasMaskItem = item
		end
	end)

	net.Receive("ixMaskOff", function()
		LocalPlayer().ixGasMaskItem = nil
	end)
	
	net.Receive("ixMskAdd", function()
		LocalPlayer():EmitSound("player/bhit_helmet-1.wav")

		addCrack()
	end)
end

-- This hook is for my other plugin, "Grenade" Plugin.
function PLUGIN:CanPlayerTearGassed(client)
	local item = client:GetGasMask()

	if (!item) then 
		return true
	else
		if (!item.isGasMask) then
			return true
		elseif (item:GetHealth() <= 0) then
			return true
		elseif (item:GetFilter() <= 0) then
			return true
		end
	end

	return false
end

-- If the player is wearing Gas Mask, His some voice should be muffled a bit.
function PLUGIN:EntityEmitSound(sndTable)
	local client = sndTable.Entity
	if (client and IsValid(client) and client:IsPlayer()) then
		local item = client:GetGasMask()

		if (item and item.isGasMask) then
			local sndName = sndTable.SoundName:lower()

			if (sndName:find("male") or sndName:find("voice")) then
				sndTable.DSP = 15
			end
		
			return true
		end
	end
end
