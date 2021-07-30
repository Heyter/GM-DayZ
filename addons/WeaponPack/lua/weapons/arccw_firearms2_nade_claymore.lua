SWEP.Base = "arccw_base_nade"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Firearms: Source 2"
SWEP.AdminOnly = false

SWEP.PrintName = "M18A1 Claymore"
SWEP.Trivia_Class = "Anti-Personnel Mine"
SWEP.Trivia_Desc = "The M18A1 Claymore is a directional anti-personnel mine developed for the United States Armed Forces. Its inventor, Norman MacLeod, named the mine after a large medieval Scottish sword."
SWEP.Trivia_Manufacturer = "Mohawk Electrical Systems Inc."
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1960

SWEP.WorldModelOffset = {
	pos		=	Vector(4, 7, 8),
	ang		=	Angle(0, 0, 180),
	bone	=	"ValveBiped.Bip01_R_Hand",
    scale   =   1
}

SWEP.Slot = 4

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/fas2/view/explosives/m18a1.mdl"
SWEP.WorldModel = "models/weapons/fas2/world/explosives/m18a1.mdl"
SWEP.ViewModelFOV = 60

SWEP.Primary.Ammo = "slam"

SWEP.FuseTime = false

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1

SWEP.ShootEntity = "arccw_firearms2_claymore"

SWEP.HoldtypeActive = "slam"

SWEP.CustomizePos = vector_origin
SWEP.CustomizeAng = angle_zero

if (CLIENT) then
	SWEP.MatLaser = Material("sprites/tp_beam001") -- sprites/physbeama ; sprites/physgbeamb
end

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 0.33,
		SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["holster"] = {
        Source = "holster",
        Time = 0.33,
        SoundTable = {{s = "Firearms2.Deploy", t = 0}},
    },
    ["pre_throw"] = {
        Source = "idle",
        Time = 1,
    },
    ["throw"] = {
        Source = "set",
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
    }
}

function SWEP:SecondaryAttack()
	if (game.SinglePlayer()) then self:CallOnClient("SecondaryAttack") end

    self.rotateY = math.NormalizeAngle(self.rotateY + (FrameTime() * 60))
end

local color = {}

function SWEP:Deploy()
	self.rotateY = self.rotateY or 0

	if (CLIENT) then
		self:Holster()

		self.ghost = ClientsideModel(self.WorldModel, RENDERGROUP_BOTH)
		self.ghost:SetMaterial("models/wireframe")
		self.ghost:SetNoDraw(true)
		self.ghost:DrawShadow(false)
		self.ghost.owner = self:GetOwner()

		self.ghost.RenderOverride = function(t)
			if (IsValid(self) and IsValid(t.owner) and t.owner:GetActiveWeapon() == self) then
				t:DrawModel()

				local v1 = t:GetPos() + t:GetForward() + t:GetUp() * 12
				local v2 = t:GetPos() + t:GetRight() * 7 + t:GetForward() * 10 + t:GetUp() * 12
				render.SetMaterial(self.MatLaser)
				render.DrawBeam(v1, v2, 1, 0, 1, color[1])

				v2 = t:GetPos() + t:GetRight() * -7 + t:GetForward() * 10 + t:GetUp() * 12
				render.SetMaterial(self.MatLaser)
				render.DrawBeam(v1, v2, 1, 0, 1, color[1])
			else
				t:Remove()
			end
		end

		self:Think()
	end
end

function SWEP:Reload()
	if (game.SinglePlayer()) then self:CallOnClient("Reload") end
	self.rotateY = 0
end

function SWEP:Hook_ShouldNotFireFirst()
	local owner = self:GetOwner()

	if (IsValid(owner)) then
		local trace = util.TraceLine({
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() + (owner:GetAimVector() * 100),
			filter = {owner, self}
		})

		if (!trace.Hit or trace.HitNormal[3] < .8) then
			return true
		else
			for _, v in ipairs(ents.FindInSphere(trace.HitPos, 16)) do
				if (IsValid(v) and v != owner and (v:IsPlayer() or v:IsNPC() or v:IsNextBot() or v:GetClass() == self.ShootEntity)) then
					return true
				end
			end

			if (trace.HitPos:DistToSqr(owner:GetPos()) <= 16 * 16) then
				return true
			end
		end

		self.claymoreData = {trace, owner:EyeAngles().y, owner}
		return false
	end

	return true
end

function SWEP:Throw()
    if self:GetNextPrimaryFire() > CurTime() then return end
    self:SetGrenadePrimed(false)
	if !istable(self.claymoreData) then return end

	self:PlayAnimation("throw", 1, false, 0, true)
	self:SetTimer(0.5, function()
		local owner = self.claymoreData[3]

		if (IsValid(owner) and owner:Alive()) then
			local item = SERVER and self.ixItem
			local trace = self.claymoreData[1]
			local ang = trace.HitNormal:Angle()
			ang.pitch = ang.pitch + 90
			ang.yaw = self.claymoreData[2] - self.rotateY

			local entity = ents.Create(self.ShootEntity)
			if (!IsValid(entity)) then return end

			entity:SetPos(trace.HitPos - trace.HitNormal * entity:OBBMins().z + Vector(0, 0, -0.5))
			entity:SetAngles(ang)
			entity:SetOwner(owner)
			entity:Spawn()
			entity:Activate()

			if (item and item.Unequip) then
				item:Unequip(owner, false, true)
				entity.isIxItem = true
			else
				self:TakePrimaryAmmo(1)

				if self:Clip1() == 0 and self:Ammo1() >= 1 and !self.Singleton then
					self:SetClip1(1)
					owner:SetAmmo(self:Ammo1() - 1, self.Primary.Ammo)
				else
					owner:StripWeapon(self:GetClass())
				end
			end

			if (SH_SZ) then
				local armed = true

				if (owner:GetLocalVar("SH_SZ.Safe", SH_SZ.OUTSIDE) != SH_SZ.OUTSIDE) then
					armed = nil
				end

				if (armed) then
					for _, sz in ipairs(SH_SZ.SafeZones or {}) do
						if (IsValid(sz.zone) and owner:GetPos():DistToSqr(sz.points[1]) <= (sz.size * sz.size) * 2) then
							armed = nil
							break
						end
					end
				end

				entity:SetArmed(armed)

				-- Отключить ENT:Think()
				if (!armed) then
					entity:AddEFlags(EFL_NO_THINK_FUNCTION)
				end
			else
				entity:SetArmed(true)
			end
		end
	end)
	self:SetTimer(self:GetAnimKeyTime("throw"), function()
		if !self:IsValid() then return end
		self:PlayAnimation("draw")
	end)

    self:SetNextPrimaryFire(CurTime() + 1)
    self.GrenadePrimeAlt = nil
end

if (CLIENT) then
	color = {
		[1] = Color(255,0,0),
		[2] = Color(0, 255, 0)
	}

	function SWEP:Holster()
		if (IsValid(self.ghost)) then
			self.ghost:SetNoDraw(true)
			self.ghost:Remove()
			self.ghost = nil
		end

		return true
	end

	function SWEP:OnRemove()
		self:Holster()
	end

	function SWEP:Think()
		local owner = self:GetOwner()

		if (IsValid(self.ghost) and IsValid(owner)) then
			local trace = util.TraceLine({
				start = owner:GetShootPos(),
				endpos = owner:GetShootPos() + (owner:GetAimVector() * 100),
				filter = {owner, self}
			})

			local ang = trace.HitNormal:Angle()
			ang.pitch = ang.pitch + 90

			if (!trace.Hit or trace.HitNormal[3] < .8) then
				self.ghost:SetColor(color[1])

				if (!trace.Hit) then
					ang.pitch = 0
					ang.yaw = owner:EyeAngles().y - self.rotateY
				end
			else
				local valid
				for _, v in ipairs(ents.FindInSphere(trace.HitPos, 16)) do
					if (IsValid(v) and v != owner and (v:IsPlayer() or v:IsNPC() or v:IsNextBot() or v:GetClass() == self.ShootEntity)) then
						valid = true
						break
					end
				end

				if (valid or trace.HitPos:DistToSqr(owner:GetPos()) <= 16 * 16) then
					self.ghost:SetColor(color[1])
				else
					self.ghost:SetColor(color[2])
				end

				ang.yaw = owner:EyeAngles().y - self.rotateY
			end

			self.ghost:SetPos(trace.HitPos - trace.HitNormal * self.ghost:OBBMins().z)
			self.ghost:SetAngles(ang)
			self.ghost:SetNoDraw(false)
		else
			self:Holster()
		end
	end

	function SWEP:DrawHUD()
		local mouse = string.upper(input.LookupBinding("+attack2") or "RMB")
		local reload = string.upper(input.LookupBinding("+reload") or "Reload")
		local x, y = ScrW() / 2.0, ScrH() / 2.0

		draw.SimpleTextOutlined(mouse .. ": Rotate", "Trebuchet24", x, y + 70, color_white, 1, 1, 1, color_black)
		draw.SimpleTextOutlined(reload .. ": Reset angle", "Trebuchet24", x, y + 95, color_white, 1, 1, 1, color_black)
	end

	function SWEP:OwnerChanged()
		if LocalPlayer() != self:GetOwner() then
			self:Holster()
		else
			self:Deploy()
		end
	end
end