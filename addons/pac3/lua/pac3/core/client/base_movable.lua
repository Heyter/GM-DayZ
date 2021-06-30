local pac = pac
local Vector = Vector
local Angle = Angle
local NULL = NULL
local Matrix = Matrix

local BUILDER, PART = pac.PartTemplate("base")

PART.ClassName = "base_movable"

BUILDER
	:StartStorableVars()
		:SetPropertyGroup("orientation")
			:GetSet("Bone", "head")
			:GetSet("Position", Vector(0,0,0))
			:GetSet("Angles", Angle(0,0,0))
			:GetSet("EyeAngles", false)
			:GetSet("PositionOffset", Vector(0,0,0))
			:GetSet("AngleOffset", Angle(0,0,0))
			:GetSetPart("AimPart")
			:GetSet("AimPartName", "", {enums = {
				["local eyes"] = "LOCALEYES",
				["player eyes"] = "PLAYEREYES",
				["local eyes yaw"] = "LOCALEYES_YAW",
				["local eyes pitch"] = "LOCALEYES_PITCH",
			}})
			:GetSetPart("Parent")
	:EndStorableVars()

do -- bones
	function PART:SetBone(val)
		self.Bone = val
		pac.ResetBoneCache(self:GetOwner())
	end

	function PART:GetBonePosition()
		local bone = self.BoneOverride or self.Bone

		local parent = self:GetParent()
		if parent:IsValid() and parent.ClassName == "jiggle" then
			return parent.pos, parent.ang
		end

		local owner = self:GetParentOwner()

		if owner:IsValid() then
			-- if there is no parent, default to owner bones
			return pac.GetBonePosAng(owner, bone)
		end

		return Vector(), Angle()
	end

	do
		local bone_matrix = Matrix()

		function PART:GetBoneMatrix()
			local pos, ang = self:GetBonePosition()

			bone_matrix:Identity()
			bone_matrix:SetTranslation(pos)
			bone_matrix:SetAngles(ang)

			return bone_matrix
		end
	end

	function PART:GetModelBones()
		return pac.GetModelBones(self:GetOwner())
	end

	function PART:GetModelBoneIndex()
		local bones = self:GetModelBones()
		local owner = self:GetOwner()
		if not owner:IsValid() then return end

		local name = self.Bone

		if bones[name] and not bones[name].is_special then
			return owner:LookupBone(bones[name].real)
		end

		return nil
	end
end

do
	local local_matrix = Matrix()

	function PART:BuildWorldMatrix(with_offsets)
		local_matrix:Identity()
		local_matrix:SetTranslation(self.Position)
		local_matrix:SetAngles(self.Angles)

		local m = self:GetBoneMatrix() * local_matrix

		m:SetAngles(self:CalcAngles(m:GetAngles(), m:GetTranslation()))

		if with_offsets then
			m:Translate(self.PositionOffset)
			m:Rotate(self.AngleOffset)
		end

		return m
	end
end

function PART:GetWorldMatrixWithoutOffsets()
	-- this is only used by the editor, no need to cache
	return self:BuildWorldMatrix(false)
end

function PART:GetWorldMatrix()
	if not self.WorldMatrix or pac.FrameNumber ~= self.last_framenumber then
		self.last_framenumber = pac.FrameNumber
		self.WorldMatrix = self:BuildWorldMatrix(true)
	end

	return self.WorldMatrix
end

function PART:GetWorldAngles()
	return self:GetWorldMatrix():GetAngles()
end

function PART:GetWorldPosition()
	return self:GetWorldMatrix():GetTranslation()
end

function PART:GetDrawPosition()
	return self:GetWorldPosition(), self:GetWorldAngles()
end

function PART:CalcAngles(ang, wpos)
	wpos = wpos or self.WorldMatrix and self.WorldMatrix:GetTranslation()
	if not wpos then return ang end

	local owner = self:GetRootPart():GetOwner()

	if pac.StringFind(self.AimPartName, "LOCALEYES_YAW", true, true) then
		ang = (pac.EyePos - wpos):Angle()
		ang.p = 0
		return self.Angles + ang
	end

	if pac.StringFind(self.AimPartName, "LOCALEYES_PITCH", true, true) then
		ang = (pac.EyePos - wpos):Angle()
		ang.y = 0
		return self.Angles + ang
	end

	if pac.StringFind(self.AimPartName, "LOCALEYES", true, true) then
		return self.Angles + (pac.EyePos - wpos):Angle()
	end


	if pac.StringFind(self.AimPartName, "PLAYEREYES", true, true) then
		local ent = owner.pac_traceres and owner.pac_traceres.Entity or NULL

		if ent:IsValid() then
			return self.Angles + (ent:EyePos() - wpos):Angle()
		end

		return self.Angles + (pac.EyePos - wpos):Angle()
	end

	if self.AimPart:IsValid() and self.AimPart.GetWorldPosition then
		return self.Angles + (self.AimPart:GetWorldPosition() - wpos):Angle()
	end

	if self.EyeAngles then
		if owner:IsPlayer() then
			return self.Angles + ((owner.pac_hitpos or owner:GetEyeTraceNoCursor().HitPos) - wpos):Angle()
		elseif owner:IsNPC() then
			return self.Angles + ((owner:EyePos() + owner:GetForward() * 100) - wpos):Angle()
		end
	end

	return ang or Angle(0,0,0)
end

BUILDER:Register()
