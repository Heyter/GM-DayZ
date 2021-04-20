util.PrecacheSound("physics/flesh/flesh_bloody_impact_hard1.wav")

for i = 1, 4 do
	util.PrecacheSound("physics/flesh/flesh_squishy_impact_hard".. i ..".wav")
end

local function CollideCallbackSmall(particle, hitpos, hitnormal)
	if (particle:GetDieTime() == 0) then return end
	particle:SetDieTime(0)
end

local function CollideCallback(oldparticle, hitpos, hitnormal)
	if (oldparticle:GetDieTime() == 0) then return end
	oldparticle:SetDieTime(0)

	sound.Play("ambient/water/rain_drip" .. math.random(1, 4) .. ".wav", hitpos, math.Rand(40, 75), math.Rand(150, 250), math.Rand(0.2, 0.8))
	util.Decal("Blood", hitpos, hitpos - hitnormal)

	-- bounce blood
	local num = math.random(-4, 4)
	if num < 1 then return end

	local nhitnormal = hitnormal * 90
	local emitter = ParticleEmitter(hitpos)

	for i = 1, num do
		local particle = emitter:Add("effects/blood_core", hitpos)
		particle:SetLighting(true)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(75, 150) + nhitnormal)
		particle:SetDieTime(3)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(1.5, 2.5))
		particle:SetEndSize(1.5)
		particle:SetRoll(math.Rand(-25, 25))
		particle:SetRollDelta(math.Rand(-25, 25))
		particle:SetAirResistance(5)
		particle:SetGravity(Vector(0, 0, -600))
		particle:SetCollide(true)
		particle:SetColor(255, 0, 0)
		particle:SetCollideCallback(CollideCallbackSmall)
	end
	emitter:Finish()
end

function EFFECT:Init(data)
	local pos = data:GetOrigin() + Vector(0, 0, 10)

	local emitter = ParticleEmitter(pos)
	for i = 1, data:GetMagnitude() do
		local particle = emitter:Add("effects/blood_core", pos)
		particle:SetDieTime(math.Rand(3, 6))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(200)
		particle:SetStartSize(math.Rand(1, 3))
		particle:SetEndSize(3)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-20, 20))
		particle:SetAirResistance(5)
		particle:SetGravity(Vector(0, 0, -600))
		particle:SetCollide(true)
		particle:SetLighting(true)
		particle:SetColor(255, 0, 0)
		particle:SetCollideCallback(CollideCallback)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end