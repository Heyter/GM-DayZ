PLUGIN.name = "First Person Effects"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "This plugin adds more effects on First Person Perspective."

local status = true
if (status) then return end

if (CLIENT) then
	ix.option.Add("toggleEffects", ix.type.bool, true, {
		category = "appearance"
	})

	local ft
	local waterMaterial, waterFraction = "effects/water_warp01", 0
	local healthFactor, ppTab
	local clmp = math.Clamp
	local client
	function PLUGIN:HUDPaint()
		client = LocalPlayer()
		ft = FrameTime()

		if (client:CanAddEffects()) then
			if (client:WaterLevel() <= 2) then
				waterFraction = clmp(waterFraction - ft*.2, 0, .2)
			else
				waterFraction = clmp(waterFraction + ft, 0, .2)
			end

			if (waterFraction > 0) then
				DrawMaterialOverlay(waterMaterial, waterFraction)
			end
		end
	end

	local playerMeta = FindMetaTable("Player")
	function playerMeta:CanAddEffects()
		local entity = Entity(self:GetLocalVar("ragdoll", 0))
		local ragdoll = self:GetRagdollEntity()

		if (
			ix.option.Get("toggleEffects", false) and
			!self:ShouldDrawLocalPlayer() and
			IsValid(self) and
			self:GetCharacter() and
			!self:GetNetVar("actEnterAngle") and
			!IsValid(entity) and
			LocalPlayer():Alive()
			) then
			return true
		end
	end

	local vel
	local sin = math.sin
	local cos = math.cos
	local curStep, rest, bobFactor = 0, 0, 0
	local newAng = Angle()
	local view = {}
	function PLUGIN:CalcView(client, origin, angles, fov)
		if (client:CanAddEffects() and !LocalPlayer():GetLocalVar("bIsHoldingObject", true)) then
			ft = FrameTime()

			if (client:OnGround()) then
				bobFactor = clmp(bobFactor + ft*4, 0, 1)
			else
				bobFactor = clmp(bobFactor - ft*2, 0, 1)
			end

			vel = clmp(client:GetVelocity():Length2D()/client:GetWalkSpeed(), 0, 1.5)
			rest = 1 - clmp(client:GetVelocity():Length2D()/40, 0, 1)
			curStep = curStep + (vel/math.pi)*(ft*2)
			
			newAng.p = angles.p + sin(curStep*15) * vel *.6* bobFactor + sin(RealTime()) * rest * bobFactor
			newAng.y = angles.y + cos(curStep*7.5) * vel *.8* bobFactor + cos(RealTime()*.5) * rest * .5 * bobFactor
			newAng.r = angles.r

	 		view = {}
			view.origin = origin
			view.angles = newAng
			return view
		end
	end
end