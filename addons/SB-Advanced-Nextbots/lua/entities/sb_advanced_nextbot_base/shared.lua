ENT.Base = "base_nextbot"

ENT.PrintName = "SB Advanced NextBot Base"
ENT.Author = "Shadow Bonnie (RUS)"
ENT.Purpose = "Create your own advanced nextbots using this base"

ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false

ENT.SBAdvancedNextBot = true

-- Bot's eye position relative bot position
ENT.ViewOffset = Vector(0,0,64)

-- Bot's eye position relative bot position when crouching
ENT.CrouchViewOffset = Vector(0,0,32)

-- Bot's view punch duration
ENT.ViewPunchLength = 0.5

--[[------------------------------------
	Name: AddNetworkVar
	Desc: (LOCAL) Add Get* and Set* functions. This uses directly SetDT* and GetDT*, this will be faster than ENT:NetworkVar
	Arg1: string | type | Type of var.
	Arg2: number | slot | Slot number in DataTable.
	Arg3: string | name | Name of var. Used as name of Set`name` and Get`name` functions.
	Ret1: 
--]]------------------------------------
local AddNetworkVar = function(type,slot,name)
	ENT["Set"..name] = function(self,value)
		self["SetDT"..type](self,slot,value)
	end
	
	ENT["Get"..name] = function(self)
		return self["GetDT"..type](self,slot)
	end
end

-- Current bot weapon
AddNetworkVar("Entity",0,"ActiveWeapon")

-- Crouch need network for player control
AddNetworkVar("Bool",0,"Crouching")

-- View punch data
AddNetworkVar("Float",0,"ViewPunchTime")
AddNetworkVar("Angle",0,"ViewPunchAngle")

--[[------------------------------------
	Name: NEXTBOT:GetEyeAngles
	Desc: Returns where bot looks.
	Arg1: 
	Ret1: Angle | Eye angles.
--]]------------------------------------
function ENT:GetEyeAngles()
	local pitch = self:GetPoseParameter("aim_pitch")
	
	if CLIENT then
		local pitchid = self:LookupPoseParameter("aim_pitch")
		
		if pitchid!=-1 then
			pitch = math.Remap(pitch,0,1,self:GetPoseParameterRange(pitchid))
		end
	end
	
	local ang = self:GetAngles()
	ang.p = pitch
	
	return ang
end

--[[------------------------------------
	Name: NEXTBOT:GetViewPunchAngles
	Desc: Returns simple calculated view punch angles.
	Arg1: 
	Ret1: Angle | View punch angles.
--]]------------------------------------
function ENT:GetViewPunchAngles()
	local vptime = self:GetViewPunchTime()+self.ViewPunchLength-CurTime()
	if vptime<0 or vptime>self.ViewPunchLength then return Angle() end
	
	local vptime = vptime/self.ViewPunchLength
	
	local vang = self:GetViewPunchAngle()
	local afr
	
	if vptime>=0.6 then
		local fr = (1-vptime)/0.4
		afr = 1-(1-fr)^2
	else
		local fr = vptime/0.6
		afr = 1-(1-fr)^1.5
	end
	
	return vang*afr
end

--[[------------------------------------
	Name: NEXTBOT:HasWeapon
	Desc: Returns has bot any weapon or not.
	Arg1: 
	Ret1: bool | Has weapon or not
--]]------------------------------------
function ENT:HasWeapon()
	return self:GetActiveWeapon():IsValid() and (CLIENT or self:GetActiveLuaWeapon():IsValid())
end

--[[------------------------------------
	Name: NEXTBOT:GetShootPos
	Desc: Returns bot's eye position.
	Arg1: 
	Ret1: Vector | Eye position.
--]]------------------------------------
function ENT:GetShootPos()
	return self:LocalToWorld(self:IsCrouching() and self.CrouchViewOffset or self.ViewOffset)
end

--[[------------------------------------
	Name: NEXTBOT:IsCrouching
	Desc: Returns bot is crouching or standing.
	Arg1: 
	Ret1: bool | Bot is crouching or not
--]]------------------------------------
function ENT:IsCrouching()
	return self:GetCrouching()
end
ENT.Crouching = ENT.IsCrouching

--[[------------------------------------
	NEXTBOT:Think
	Calling think tasks callbacks
--]]------------------------------------
function ENT:Think()
	self:RunTask("Think")
end
