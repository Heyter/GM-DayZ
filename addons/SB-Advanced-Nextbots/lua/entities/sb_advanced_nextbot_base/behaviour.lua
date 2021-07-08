
--[[------------------------------------
	NEXTBOT:BehaveStart
	Creating behaviour thread using NEXTBOT:BehaviourCoroutine. Also setups task list and default tasks.
--]]------------------------------------
function ENT:BehaveStart()
	self:SetupCollisionBounds()

	self:SetupTaskList(self.m_TaskList)
	self:SetupTasks()

	self.BehaviourThread = coroutine.create(function() self:BehaviourCoroutine() end)
end

--[[------------------------------------
	NEXTBOT:BehaveUpdate
	This is where bot updating
--]]------------------------------------
function ENT:BehaveUpdate(interval)
	self.BehaveInterval = interval

	if self.m_Physguned then
		self.loco:SetVelocity(vector_origin)
	end

	self:StuckCheck()

	local disable = self:DisableBehaviour()

	if !disable then
		local crouch = self:ShouldCrouch()
		if crouch!=self:IsCrouching() and (crouch or self:CanStandUp()) then
			self:SwitchCrouch(crouch)
		end
	end

	self:SetupSpeed()
	self:SetupMotionType()
	self:ProcessFootsteps()
	self.m_FallSpeed = -self.loco:GetVelocity().z

	if !disable then
		self:SetupEyeAngles()
		self:UpdatePhysicsObject()
		self:ForgetOldEnemies()

		if self.BehaviourThread then
			if coroutine.status(self.BehaviourThread)=="dead" then
				self.BehaviourThread = nil
				ErrorNoHalt("NEXTBOT:BehaviourCoroutine() has been finished!\n")
			else
				assert(coroutine.resume(self.BehaviourThread))
			end
		end

		-- Calling behaviour with think type
		self:BehaviourThink()

		-- Calling task callbacks
		self:RunTask("BehaveUpdate",interval)
	end

	self:SetupGesturePosture()
end

--[[------------------------------------
	Name: NEXTBOT:BehaviourCoroutine
	Desc: Override this function to control bot using coroutine type.
	Arg1: 
	Ret1: 
--]]------------------------------------
function ENT:BehaviourCoroutine()
	while true do
		coroutine.yield()
	end
end

--[[------------------------------------
	Name: NEXTBOT:DisableBehaviour
	Desc: Decides should behaviour be disabled.
	Arg1: 
	Ret1: bool | Return true to disable.
--]]------------------------------------
function ENT:DisableBehaviour()
	return self:IsPostureActive() or self:IsGestureActive(true) or GetConVar("ai_disabled"):GetBool() or self:RunTask("DisableBehaviour")
end

--[[------------------------------------
	Name: NEXTBOT:BehaviourThink
	Desc: Override this function to control bot using think type.
	Arg1: 
	Ret1: 
--]]------------------------------------
function ENT:BehaviourThink()

end

--[[------------------------------------
	Name: NEXTBOT:CapabilitiesAdd
	Desc: Adds a capability to the bot.
	Arg1: number | cap | Capabilities to add. See CAP_ Enums
	Ret1: 
--]]------------------------------------
function ENT:CapabilitiesAdd(cap)
	self.m_Capabilities = bit.bor(self.m_Capabilities,cap)
end

--[[------------------------------------
	Name: NEXTBOT:CapabilitiesClear
	Desc: Clears all capabilities of bot.
	Arg1: 
	Ret1: 
--]]------------------------------------
function ENT:CapabilitiesClear()
	self.m_Capabilities = 0
end

--[[------------------------------------
	Name: NEXTBOT:CapabilitiesGet
	Desc: Returns all capabilities including weapon capabilities.
	Arg1: 
	Ret1: number | Capabilities. See CAP_ Enums
--]]------------------------------------
function ENT:CapabilitiesGet()
	return bit.bor(self.m_Capabilities,self:HasWeapon() and self:GetActiveLuaWeapon():GetCapabilities() or 0)
end

--[[------------------------------------
	Name: NEXTBOT:CapabilitiesRemove
	Desc: Removes capability from bot.
	Arg1: number | cap | Capabilities to remove. See CAP_ Enums
	Ret1: 
--]]------------------------------------
function ENT:CapabilitiesRemove(cap)
	self.m_Capabilities = bit.bxor(bit.bor(self.m_Capabilities,cap),cap)
end