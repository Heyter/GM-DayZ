local PLUGIN = PLUGIN

PLUGIN.name = "Radiation"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

PLUGIN.maxRads = 1000
PLUGIN.radLevel = 4
PLUGIN.radsScale = PLUGIN.maxRads / PLUGIN.radLevel

PLUGIN.rad_damage = {}

for i = 2, PLUGIN.radLevel do
	PLUGIN.rad_damage[i] = { math.ceil(math.exp(0.7 * i)), 2.5 - i * 0.5 } -- [1] = урон, [2] = время
end

ix.util.Include("sv_plugin.lua")

-- playerMeta | SHARED
do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:GetRadiation()
		return self:GetLocalVar("radiation", CurTime())
	end

	function playerMeta:GetRadiationTotal()
		return math.max(0, self:GetRadiation() - CurTime())
	end

	function playerMeta:GetRadiationLevel()
		return math.floor(self:GetRadiationTotal() / PLUGIN.radsScale)
	end

	function playerMeta:GetRadiationPercent()
		return math.Clamp(self:GetRadiationTotal() / PLUGIN.maxRads, 0, 1)
	end
end

function PLUGIN:AdjustStaminaOffset(client, offset)
	if (offset > 0) then -- когда бежит
		local rad_level = client:GetRadiationLevel()

		if (client:GetHungerPercent() > 0.9 or client:GetThirstPercent() > 0.85) then
			return rad_level <= 0 and offset / 3 or offset / rad_level
		elseif (rad_level >= 1) then
			return offset / rad_level
		end
	end
end

function PLUGIN:CanPlayerRegenHealth(client)
	if (client:GetRadiationPercent() >= 0.5) then
		return false
	end
end

if (CLIENT) then
	--- https://github.com/ZehMatt/Lambda/blob/develop/gamemode/cl_postprocess.lua
	PLUGIN.GRAIN_RT = PLUGIN.GRAIN_RT or GetRenderTarget("LambdaFilmGrain", ScrW(), ScrH(), true)
	PLUGIN.GRAIN_MAT = PLUGIN.GRAIN_MAT or CreateMaterial("LambdaFilmGrain" .. CurTime(), "UnlitGeneric",
	{
		["$alpha"] = 1,
		["$translucent"] = 1,
		["$basetexture"] = "models/debug/debugwhite",
		Proxies =
		{
			TextureScroll =
			{
				texturescrollvar = "$basetexturetransform",
				texturescrollrate = 10,
				texturescrollangle = 40,
			},
		}
	})

	PLUGIN.GRAIN_SETUP = PLUGIN.GRAIN_SETUP or nil

	-- FIXME: Use a static texture instead.
	local function GenerateFilmGrain()
		if (PLUGIN.GRAIN_SETUP) then return end
		PLUGIN.GRAIN_SETUP = true

		render.PushRenderTarget(PLUGIN.GRAIN_RT)
			render.Clear(0, 0, 0, 1, true, true)

			surface.SetDrawColor(0, 50, 0, 150)

			cam.Start2D()
				for y = 0, ScrH() do
					for x = 0, ScrW() do
						if (math.random(0, 5) == 0) then
							surface.DrawLine(x, y, x + 2, y + 2)
						end
					end
				end
			cam.End2D()

			render.BlurRenderTarget(PLUGIN.GRAIN_RT, 0.01, 0.01, 1)
		render.PopRenderTarget()

		PLUGIN.GRAIN_MAT:SetTexture("$basetexture", PLUGIN.GRAIN_RT)
	end

	local LAST_GEIGER_RANGE = PLUGIN.maxRads
	local RADIATION_COLOR_MOD = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	function PLUGIN:RenderScreenspaceEffects()
		if (!self.GRAIN_SETUP) then GenerateFilmGrain() end

		local client = LocalPlayer()
		if (!client:Alive() or !client:GetCharacter()) then return end

		local curGeigerRange = math.Clamp(self.maxRads - client:GetRadiationTotal(), 0, self.maxRads)
		if (curGeigerRange >= self.maxRads) then return end

		if (client.ixInArea) then
			local area = ix.area.stored[client:GetArea()]

			if (area and area["type"] == "gas") then
				curGeigerRange = curGeigerRange * .7
			end
		end

		LAST_GEIGER_RANGE = Lerp(FrameTime(), LAST_GEIGER_RANGE, curGeigerRange) -- geigerRange

		local iv = 1 - (LAST_GEIGER_RANGE / self.maxRads)
		self.GRAIN_MAT:SetFloat("$alpha", iv)

		render.SetMaterial(self.GRAIN_MAT)
		render.DrawScreenQuad()

		RADIATION_COLOR_MOD["$pp_colour_mulg"] = iv * 3
		DrawColorModify(RADIATION_COLOR_MOD)
	end

	local sounds_geiger = {}
	for k = 1, PLUGIN.radLevel do
		sounds_geiger[k] = Sound(Format("gmodz/radiation/radiation%d.ogg", k))
	end

	local nextGeiger = 0
	local client
	function PLUGIN:Think()
		client = LocalPlayer()

		if (!client:Alive() or !client:GetCharacter() or CurTime() < nextGeiger) then return end
		nextGeiger = CurTime() + 0.06

		local radiation = client:GetRadiationTotal()
		if (radiation <= 0) then return end

		local percent = client:GetRadiationPercent()
		local pct = (radiation < self.radsScale and 0 or 127)

		if (pct > 0) then
			pct = pct * (percent / 22)
		end

		if (math.random(0, 127) < pct) then
			local vol = 0.2 + (percent >= 0.6 and percent * 2 or percent)
			vol = (vol * (math.random(0, 127) / 255)) + 0.5

			client:EmitSound(sounds_geiger[math.random(#sounds_geiger)], 75, 100, vol, CHAN_BODY)
		end
	end
end