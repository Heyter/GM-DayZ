-- TFA credits

-- CVARS
CreateConVar("sv_arccw_jamming_factor", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Multiply jam factor by this value")
CreateConVar("sv_arccw_jamming_factor_inc", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Multiply jam factor gain by this value")
CreateConVar("sv_arccw_jamming_mult", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Multiply jam chance by this value. You really should modify sv_arccw_jamming_factor_inc rather than this.")

local sv_jamming_mult = GetConVar("sv_arccw_jamming_mult")
local sv_jamming_factor = GetConVar("sv_arccw_jamming_factor")
local sv_jamming_factor_inc = GetConVar("sv_arccw_jamming_factor_inc")
-- CVARS | END

SWEP.JamChance = 0.04
SWEP.JamFactor = 0.06
SWEP.CanJam = true

SWEP.Primary.Sound_Jammed = Sound("Default.ClipEmpty_Rifle") -- jammed click sound

function SWEP:CanBeJammed()
	return self.CanJam and self:GetMaxClip1() > 0
end

function SWEP:UpdateJamFactor()
	if (!self:CanBeJammed()) then return end
	self:SetJamFactor(math.min(100, self:GetJamFactor() + self:GetTable().JamFactor * sv_jamming_factor_inc:GetFloat() * 1))
end

function SWEP:IsJammed()
	if (!self:CanBeJammed()) then return false end
	return self:GetJammed()
end

function SWEP:NotifyJam()
	local ply = self:GetOwner()

	if (IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and ((ply._TFA_LastJamMessage or 0) < RealTime())) then
		ply:PrintMessage(HUD_PRINTCENTER, self.msg_jammed or "Your weapon has jammed! Press the RELOAD key.")
		ply._TFA_LastJamMessage = RealTime() + 4
	end
end

function SWEP:CheckJammed()
	if (!self:IsJammed()) then return false end
	if CLIENT then self:NotifyJam() end
	return true
end

function SWEP:GetJamChance()
	if (!self:CanBeJammed()) then return 0 end
	return self:GetJamFactor() * sv_jamming_factor:GetFloat() * (self:GetTable().JamChance / 100) * 1
end

function SWEP:RollJamChance()
	if (!self:CanBeJammed()) then
		return false
	else
		if (self:Clip1() < 1 and self:GetMaxClip1() < 1) then
			return false
		end
	end

	if (self:IsJammed()) then
		return false
	end

	local chance = self:GetJamChance()
	local roll = util.SharedRandom('arccw_base_jam', math.max(0.002711997795105, math.pow(chance, 1.19)), 1, CurTime())

	if (roll <= chance * sv_jamming_mult:GetFloat()) then
		self:SetJammed(true)

		if (CLIENT and IsFirstTimePredicted()) then
			self:NotifyJam()
		end

		return true
	end

	return false
end