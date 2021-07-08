AddCSLuaFile()

ENT.Base = "sb_advanced_nextbot_base"
DEFINE_BASECLASS(ENT.Base)

if CLIENT then return end

local UseNodeGraph = CreateConVar(
	"sb_an_bandit_usenodegraph",
	"0",
	bit.bor(FCVAR_NEVER_AS_STRING,FCVAR_ARCHIVE),
	"Should bots use nodegraph or navmesh when finding path",
	0,
	1
)

--[[------------------------------------
	CONFIG
--]]------------------------------------

ENT.SpawnHealth = 100
ENT.WeaponPickupDistance = math.pow(50, 2)

-- Maximum pursuit distance before the NPC loses sight of the target.
ENT.MaxPursuitDistance = math.pow(2000, 2)
-- Close pursuit distance. The distance required to start pursuit the target.
ENT.ClosePursuitDistance = math.pow(300, 2)
ENT.ClosePursuitEnemyDistance = math.pow(300, 2)
-- Enable patrol
ENT.EnablePatrol = true

-- Search distance of the weapon
ENT.SearchRangeWeapon = math.pow(3000, 2)

-- Distance to detect an weapon
ENT.SearchDistWeaponLimit = math.pow(500, 2)

ENT.GrenadeMinDistance = math.pow(512, 2)
ENT.GrenadeMaxDistance = math.pow(1024, 2)
ENT.HasGrenadeAttack = true
ENT.GrenadeEntity = "gmodz_grenade_rgd5"

ENT.MeleeAttackRange = 40
ENT.CanMeleeAttack = true

ENT.CanJump = true

ENT.MeleeAttackDamage = 15

ENT.InformRadius = math.pow(128, 2)

-- Time need to forget enemy if bot doesn't see it
ENT.ForgetEnemyTime = 30

-- Distance at which enemy should be to make bot think enemy is very close
ENT.CloseEnemyDistance = math.pow(500, 2)

-- Max distance at which bot can see enemies
ENT.MaxSeeEnemyDistance = math.pow(2000, 2)

-- Default motion path minimum look ahead distance
ENT.PathMinLookAheadDistance = 15

-- Default motion path goal tolerance
ENT.PathGoalTolerance = 20

-- Default motion path goal tolerance on last segment
ENT.PathGoalToleranceFinal = math.pow(25, 2)

-- Default motion path recompute time
ENT.PathRecompute = 5

ENT.DefaultWeapon = "weapon_shotgun"

ENT.LineOfSightMask = MASK_VISIBLE
ENT.RandomWalkDistances = {25, 300}

-- Bot's desired move speed
ENT.MoveSpeed = 160

-- Bot's desired run speed
ENT.RunSpeed = 160

-- Bot's desired walk speed
ENT.WalkSpeed = 100

ENT.AimSpeed = 200

ENT.IsNPCBandit = true

--[[------------------------------------
	CONFIG END
--]]------------------------------------

--[[ SOUNDS ]]

function ENT:ChooseSound(key, delay, force)
	if (!force and self:Health() <= 0) then return end
	self.speech_sounds = self.speech_sounds or {}
	if (!force and self.speech_sounds[key] and self.speech_sounds[key][1] > CurTime()) then return end

	local soundPath

	if (key == "alert") then
		soundPath = "npc/bandit/enemy_" .. math.random(1, 12) .. ".ogg"
	elseif (key == "death") then
		soundPath = "npc/bandit/death_" .. math.random(1, 7) .. ".ogg"
	elseif (key == "pain") then
		soundPath = "npc/bandit/hit_" .. math.random(1, 7) .. ".ogg"
	elseif (key == "walk" or key == "idle") then
		soundPath = "npc/bandit/idle_" .. math.random(1, 35) .. ".ogg"
	elseif (key == "grenade_prep") then
		soundPath = "npc/bandit/grenade_" .. math.random(1, 3) .. ".ogg"
	elseif (key == "grenade_throw") then
		soundPath = "npc/bandit/grenade_ready_" .. math.random(1, 7) .. ".ogg"
	elseif (key == "help") then
		soundPath = "npc/bandit/help_" .. math.random(1, 7) .. ".ogg"
	elseif (key == "ally") then
		soundPath = "npc/bandit/tolls_" .. math.random(1, 5) .. ".ogg"
	elseif (key == "enemy_lost") then
		soundPath = "npc/bandit/search_" .. math.random(1, 18) .. ".ogg"
	elseif (key == "friendly") then
		soundPath = "npc/bandit/search_" .. math.random(1, 5) .. ".ogg"
	elseif (key == "attack") then
		if (math.random(1, 2) == 1) then
			soundPath = "npc/bandit/attack_" .. math.random(1, 9) .. ".ogg"
		else
			soundPath = "npc/bandit/detour_" .. math.random(1, 10) .. ".ogg"
		end
	end

	if (soundPath) then
		if (self.CurSound) then
			self:StopSound(self.CurSound)
		end

		self.CurSound = soundPath
		self:EmitSound(soundPath)

		g_SoundDurations[soundPath] = g_SoundDurations[soundPath] or SoundDuration(soundPath)
		self.speech_sounds[key] = {CurTime() + (delay or 1) + (g_SoundDurations[soundPath] or 0), soundPath}
	end
end

ENT.TaskList = {
	["shooting_handler"] = {
		OnStart = function(self,data)
			data.PassBlockerTime = CurTime()

			data.PassBlocker = function(blocker)
				local dir = blocker:WorldSpaceCenter()-self:GetPos()
				dir.z = 0

				local _,diff = WorldToLocal(vector_origin,dir:Angle(),vector_origin,self:GetDesiredEyeAngles())
				local side = diff.y>0 and 1 or -1

				self:Approach(self:GetPos()+dir:Angle():Right()*side*10)
			end
		end,
		BehaveUpdate = function(self,data,interval)
			local wep = self:GetActiveWeapon()

			if self.IsSeeEnemy then
				self:SetDesiredEyeAngles((self.LastEnemyEyePos-self:GetShootPos()):Angle())

				if IsValid(wep) and wep:Clip1() % wep:GetMaxClip1() == 0 then
					self:WeaponReload()
				end

				if (self.CanMeleeAttack and self:IsInRange(self:GetEnemy(), self.MeleeAttackRange)) then
					self:OnMeleeAttack()
				end

				if self.LastShootBlocker then
					if self:IsTaskActive("movement_wait") and CurTime()-data.PassBlockerTime>0.5 then
						data.PassBlocker(self.LastShootBlocker)
					end
				else
					data.PassBlockerTime = CurTime()

					if (self:ShouldAttack(self.LastEnemyEyePos) and !self:ThrowGrenade() and IsValid(wep)) then
						self:WeaponPrimaryAttack()
						self:ChooseSound("attack", math.random(5, 15))
					end
				end
			elseif (IsValid(wep) and wep:Clip1() < wep:GetMaxClip1() / 2) then
				self:WeaponReload()
			end
		end
	},
	["enemy_handler"] = {
		OnStart = function(self,data)
			data.UpdateEnemies = CurTime()
			data.HasEnemy = false
			self.IsSeeEnemy = false
			self:SetEnemy(NULL)

			self.UpdateEnemyHandler = function()
				local prevenemy = self:GetEnemy()
				local newenemy = prevenemy

				if !data.UpdateEnemies or CurTime()>data.UpdateEnemies or data.HasEnemy and !IsValid(prevenemy) then
					data.UpdateEnemies = CurTime() + 1

					self:FindEnemies()

					local enemy = self:FindPriorityEnemy()
					if IsValid(enemy) then
						newenemy = enemy
						self.IsSeeEnemy = self:CanSeePosition(enemy)
					end
				end

				if IsValid(newenemy) then
					if (prevenemy != newenemy) then
						self:ChooseSound("alert", math.random(4))
					end

					data.HasEnemy = true

					if self:CanSeePosition(newenemy) then
						//self.LastEnemyShootPos = self:EntShootPos(newenemy)
						self.LastEnemyEyePos = newenemy:EyePos()

						self:UpdateEnemyMemory(newenemy,newenemy:GetPos())
					end
				else
					if data.HasEnemy then
						self:ChooseSound("enemy_lost", math.random(1, 10))
					end

					data.HasEnemy = false
					self.IsSeeEnemy = false
				end

				self:SetEnemy(newenemy)

				if self.IsSeeEnemy and IsValid(newenemy) then
					self.LastEnemyPosition = newenemy:GetPos()
				end
			end
		end,
		BehaveUpdate = function(self,data,interval)
			self.UpdateEnemyHandler()
		end
	},
	["movement_handler"] = {
		OnStart = function(self,data)
			self:TaskComplete("movement_handler")

			local task, data = "movement_wait", {}
			local findwep = !self:HasWeapon() and self:FindWeapon()

			if self.CustomPosition then
				task, data = "movement_custompos", {Position = self.CustomPosition}
				self.CustomPosition = nil
			elseif findwep then
				task, data = "movement_getweapon", {Wep = findwep}
			else
				if self.IsSeeEnemy then
					task = "movement_followenemy"
				elseif self.LastEnemyPosition then
					task, data = "movement_custompos", {Position = self.LastEnemyPosition}
					self.LastEnemyPosition = nil
				elseif IsValid(self:GetEnemy()) then
					task, data = "movement_custompos", {Position = self:GetLastEnemyPosition(self:GetEnemy())}
				else
					task = self.EnablePatrol and "movement_randomwalk" or "movement_wait"
				end
			end

			if (self.ThrowedGrenade) then
				task = "movement_wait"
				data = {Time = 2.5}

				self.ThrowedGrenade = nil
			end

			self:StartTask(task,data)
		end,
	},
	["movement_wait"] = {
		OnStart = function(self,data)
			data.Time = CurTime()+(data.Time or 1)

			if (math.random(1, 2) == 1 and !IsValid(self:GetEnemy())) then
				self:ChooseSound("idle", math.random(5, 30))
			end
		end,
		BehaveUpdate = function(self,data,interval)
			if CurTime()>=data.Time then
				self:TaskComplete("movement_wait")
				self:StartTask("movement_handler")
			end
		end
	},
	["movement_getweapon"] = {
		OnStart = function(self,data)
			self:SetupPath(data.Wep:GetPos())

			if !self:PathIsValid() then
				self:TaskFail("movement_getweapon")
				self:StartTask("movement_wait")
			end
		end,
		BehaveUpdate = function(self,data)
			if !self:CanPickupWeapon(data.Wep) then
				self:TaskFail("movement_getweapon")
				self:StartTask("movement_wait")

				return
			end

			local result = self:ControlPath(true)

			if result then
				self:TaskComplete("movement_getweapon")
				self:StartTask("movement_wait")

				if self:GetRangeSquaredTo(data.Wep) < self.WeaponPickupDistance then
					self:SetupWeapon(data.Wep)
				end
			elseif result==false then
				self:TaskFail("movement_getweapon")
				self:StartTask("movement_wait")
			end
		end
	},
	["movement_followenemy"] = {
		OnStart = function(self,data)
			local pos = self.IsSeeEnemy and self:GetEnemy():GetPos() or self:GetLastEnemyPosition(self:GetEnemy())

			if !self:SetupPath(pos) then
				self:TaskFail("movement_followenemy")
				self:StartTask("movement_wait")
				
				return
			end
		end,
		BehaveUpdate = function(self,data)
			local result = self:ControlPath(!self.IsSeeEnemy)

			if result then
				self:TaskComplete("movement_followenemy")
				self:StartTask("movement_wait")
			elseif result==false then
				self:TaskFail("movement_followenemy")
				self:StartTask("movement_wait")
			end
		end,
		OnDelete = function(self,data)
			self:GetPath():Invalidate()
		end
	},
	["movement_randomwalk"] = {
		OnStart = function(self,data)
			local pos = self:GetRandomWalkPosition()

			if !pos then
				self:TaskFail("movement_randomwalk")
				self:StartTask("movement_wait")

				return
			end

			if !self:SetupPath(pos) then
				self:TaskFail("movement_randomwalk")
				self:StartTask("movement_wait")

				return
			end

			if (!IsValid(self:GetEnemy())) then self:ChooseSound("walk", math.random(5, 20)) end
		end,
		BehaveUpdate = function(self,data)
			local result = self:ControlPath(!self.IsSeeEnemy)

			if result then
				self:TaskComplete("movement_randomwalk")
				self:StartTask("movement_wait", {Time = math.random(1, 10)})
			elseif result == false then
				self:TaskFail("movement_randomwalk")
				self:StartTask("movement_wait")
			end
		end,
		OnDelete = function(self,data)
			self:GetPath():Invalidate()
		end
	},
	["movement_custompos"] = {
		OnStart = function(self,data)
			if !self:SetupPath(data.Position, {tolerance = 50}) then
				self:TaskFail("movement_custompos")
				self:StartTask("movement_wait")
			end
		end,
		BehaveUpdate = function(self,data)
			local result = self:ControlPath(!self.IsSeeEnemy)

			if result then
				self:TaskComplete("movement_custompos")
				self:StartTask("movement_wait")
			elseif result==false then
				self:TaskFail("movement_custompos")
				self:StartTask("movement_wait")
			end
		end
	}
}

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:SetUseNodeGraph(UseNodeGraph:GetBool())

	if (math.random(1, 2) == 2) then
		self.HasGrenadeAttack = nil
	else
		self.ThrowedGrenadeDelay = CurTime() + 30
	end
end

function ENT:BehaviourThink()
	if self:PathIsValid() and !self:DisableBehaviour() and self:HasWeapon() then
		local filter = self:GetChildren()
		filter[#filter+1] = self

		local pos = self:GetShootPos()
		local endpos = pos+self:GetAimVector()*100
		local blocker = self:ShootBlocker(pos,endpos,filter)

		self.LastShootBlocker = blocker

		if blocker then
			local class = blocker:GetClass()

			if class=="prop_door_rotating" and blocker:GetInternalVariable("m_eDoorState")!=2 and (!self.OpenDoorTime or CurTime()-self.OpenDoorTime>2) then
				self.OpenDoorTime = CurTime()
				blocker:Fire("Use")
			elseif (class == "func_door_rotating" or class == "func_door") and blocker:GetInternalVariable("m_toggle_state") == 1 and (!self.OpenDoorTime or CurTime()-self.OpenDoorTime>2) then
				self.OpenDoorTime = CurTime()
				blocker:Fire("Use")
			end
		end
	else
		self.LastShootBlocker = false
	end

	//self.OnContactAllowed = true
end

--[[ function ENT:OnContact(ent)
	if self == ent or !self.OnContactAllowed then return end

	local vel = ent:GetVelocity()

	if !vel:IsZero() then
		local pos = self:GetPos()
	
		self.loco:Approach(pos+vel:GetNormalized()+(pos-ent:GetPos()):GetNormalized(),1)
		self.OnContactAllowed = false
	end
end ]]

function ENT:ShouldAttack(pos)
	local dir = pos - self:GetShootPos()
	dir:Normalize()

	if math.deg(math.acos(dir:Dot(self:GetEyeAngles():Forward()))) > 20 then return false end

	if self:ShootBlocker(self:GetShootPos(), pos, function(ent)
		if ent == self:GetEnemy() or ent == self then return false end
		if ent:GetClass() == self:GetClass() or ent.IsBandit then return false end

		return true
	end) then return false end

	return true
end

function ENT:FindWeapon()
	local wep,range,weight

	for _, v in ipairs(ents.GetAll()) do
		local r = self:GetRangeSquaredTo(v)

		if r > self.SearchRangeWeapon or !self:CanPickupWeapon(v) or !self:CanSeePosition(v) then continue end

		local w = v:GetWeight()

		if !wep or w>weight and r-range<self.SearchDistWeaponLimit or w<weight and r-range>self.SearchDistWeaponLimit or w==weight and r<range then
			wep,range,weight = v,r,w
		end
	end
	
	return wep
end

function ENT:OnInjured(dmg)
	BaseClass.OnInjured(self, dmg)

	local att = dmg:GetAttacker()

	if (IsValid(att) and self:Health() - dmg:GetDamage() > 0) then
		if (self:GetClass() != att:GetClass() and !att.IsBandit) then
			if (math.random(1, 2) == 2) then
				self:ChooseSound("help", math.random(4, 8))
			else
				self:ChooseSound("pain", math.random(1, 4))
			end
		else
			self:ChooseSound("friendly", math.random(1, 4))
		end
	end
end

function ENT:ShootBlocker(start,pos,filter)
	local tr = util.TraceLine({
		start = start,
		endpos = pos,
		filter = filter,
		mask = MASK_SHOT,
	})
	
	return tr.Hit and tr.Entity
end

function ENT:GetRandomWalkPosition()
	local pos = self:GetPos()
	local destlen = math.Rand(self.RandomWalkDistances[1], self.RandomWalkDistances[2]) ^ 2

	if self:UsingNodeGraph() then
		local cur = SBAdvancedNextbotNodeGraph.GetNearestNode(pos)
		if !cur then return end

		local opened = {[cur:GetID()] = true}
		local closed = {}
		local costs = {[cur:GetID()] = cur:GetOrigin():DistToSqr(pos)}
		local maxcost,maxcostpos = 0

		while !table.IsEmpty(opened) do
			local _,nodeid = table.Random(opened)
			opened[nodeid] = nil
			closed[nodeid] = true

			local node = SBAdvancedNextbotNodeGraph.GetNodeByID(nodeid)

			if costs[nodeid]>=destlen then
				return node:GetOrigin()
			end

			if costs[nodeid]>maxcost then
				maxcost,maxcostpos = costs[nodeid],node:GetOrigin()
			end

			for k,v in ipairs(node:GetAdjacentNodes()) do
				if !closed[v:GetID()] then
					local cost = costs[nodeid]+v:GetOrigin():DistToSqr(node:GetOrigin())
					costs[v:GetID()] = cost

					opened[v:GetID()] = true
				end
			end
		end

		return maxcostpos
	else
		local cur = navmesh.GetNearestNavArea(pos)
		if !IsValid(cur) then return end

		local opened = {[cur:GetID()] = true}
		local closed = {}
		local costs = {[cur:GetID()] = cur:GetCenter():DistToSqr(pos)}
		local maxcost,maxcostpos = 0

		while !table.IsEmpty(opened) do
			local _,areaid = table.Random(opened)
			opened[areaid] = nil
			closed[areaid] = true

			local area = navmesh.GetNavAreaByID(areaid)

			if costs[areaid]>=destlen then
				return area:GetRandomPoint()
			end

			if costs[areaid]>maxcost then
				maxcost,maxcostpos = costs[areaid],area:GetRandomPoint()
			end

			for k,v in ipairs(area:GetAdjacentAreas()) do
				if !closed[v:GetID()] then
					local cost = costs[areaid]+v:GetCenter():DistToSqr(area:GetCenter())
					costs[v:GetID()] = cost

					opened[v:GetID()] = true
				end
			end
		end

		return maxcostpos
	end
end

function ENT:SetupTaskList(list)
	BaseClass.SetupTaskList(self,list)

	for k,v in pairs(self.TaskList) do
		list[k] = v
	end
end

function ENT:SetupTasks()
	BaseClass.SetupTasks(self)

	self:StartTask("enemy_handler")
	self:StartTask("shooting_handler")
	self:StartTask("movement_handler")
end

function ENT:SetupDefaultCapabilities()
	BaseClass.SetupDefaultCapabilities(self)

	if !self.CanJump then
		self.JumpHeight = 0
		self.MaxJumpToPosHeight = 0
		self.loco:SetJumpHeight(0)
	else
		self:CapabilitiesAdd(CAP_MOVE_JUMP)
	end

	self.MeleeAttack = 0
end

function ENT:OnKilled(dmg)
	local att = dmg:GetAttacker()

	if (IsValid(att) and att:IsPlayer() and att.IsBandit) then
		att.IsBandit = nil
	end

	self:ChooseSound("death", nil, true)

	if self:HasWeapon() then
		self:GetActiveLuaWeapon():Remove()
	end

	hook.Run("OnNPCKilled",self, dmg:GetAttacker(), dmg:GetInflictor())
	self:Remove()

	if (self.RagdollModel) then
		net.Start("sb_anb_ragdoll", true)
			net.WriteEntity(self)
			net.WriteString(self.RagdollModel)
		net.SendPVS(self:GetPos())
	end
end

function ENT:ThrowGrenade()
	if (!self:CanThrowGrenade()) then return false end

	local dist = self:GetRangeSquaredTo(self.LastEnemyEyePos)
	if dist > self.GrenadeMaxDistance or dist < self.GrenadeMinDistance then return false end

	self.ThrowedGrenadeDelay = CurTime() + math.random(60, 360)
	self.ThrowedGrenade = true

	self:DoGesture(ACT_GMOD_GESTURE_ITEM_THROW, 2)
	self.m_WeaponData.Primary.NextShootTime = self.m_WeaponData.Primary.NextShootTime + 1

	timer.Simple(0.3, function()
		if (IsValid(self)) then
			self:ChooseSound("grenade_throw")
			self:StopGesture()

			local nade = ents.Create(self.GrenadeEntity or "npc_grenade_frag")

			if (self.GrenadeModel) then
				nade:SetModel(self.GrenadeModel)
			end

			nade:SetPos(self:GetPos() + Vector(0, 0, 55) - (self:GetRight() * 5))
			nade:SetAngles(self:GetDesiredEyeAngles())
			nade:SetOwner(self)
			nade:Spawn()
			nade:Activate()

			local phys = nade:GetPhysicsObject()

			if (IsValid(phys)) then
				phys:Wake()
				phys:SetVelocity((self.LastEnemyEyePos + self:OBBCenter() - self:GetPos()) * 1.25 )
			end
		end
	end)

	return true
end

function ENT:CanThrowGrenade()
	return self.HasGrenadeAttack and (self.ThrowedGrenadeDelay or 0) < CurTime()
end

function ENT:OnMeleeAttack()
	if (self.MeleeAttack and self.MeleeAttack < CurTime()) then
		self.MeleeAttack = CurTime() + 5

		self:DoGesture(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

		self:Attack({
			damage = math.random(5, self.MeleeAttackDamage or 10),
			type = DMG_SLASH,
			viewpunch = Angle(20, math.random(-10, 10), 0),
			delay = 0.2
		}, function(self, hit)
			if #hit > 0 then
				self:EmitSound("Zombie.AttackHit")
			else
				self:EmitSound("Zombie.AttackMiss")
			end

			self.MeleeAttack = CurTime() + math.random(2, 5)
		end)
	end
end

local INT_MIN = -2147483648
function ENT:GetRelationship(ent)
	if (self:GetClass() == ent:GetClass()) then
		return D_LI, INT_MIN
	end

	if (ent.IsBandit) then
		return D_NU, INT_MIN
	end

	return D_HT, INT_MIN
end

function ENT:ShouldWalk()
	return !self.IsSeeEnemy or self.LastEnemyPosition and false
end


-----------
function ENT:CalcOffset(vec)
    return self:GetForward() * vec.x + self:GetRight() * vec.y + self:GetUp() * vec.z
end

function ENT:Attack(attack, callback)
    attack = attack or {}
    attack.damage = attack.damage or 0
    attack.delay = attack.delay or 0
    attack.type = attack.type or DMG_GENERIC
    attack.force = attack.force or Vector(100, 0, 0)
    attack.viewpunch = attack.viewpunch or Angle(10, 0, 0)
    attack.range = attack.range or self.MeleeAttackRange
    attack.angle = attack.angle or 90

    timer.Simple(attack.delay, function()
        if (not IsValid(self)) then return end
        local hit = {}

        for i, ent in ipairs(self:EntitiesInCone(attack.angle, attack.range)) do
            if ent == self then continue end
            if (not IsValid(ent) or not self:ShouldBeEnemy(ent)) then continue end
            if not self:Visible(ent) then continue end
            local origin = self:WorldSpaceCenter()
            local dmg = DamageInfo()
            dmg:SetAttacker(self)
            dmg:SetInflictor(self)
            dmg:SetDamageType(attack.type)
            dmg:SetDamageForce(self:CalcOffset(attack.force))
            dmg:SetDamage(attack.damage)
            dmg:SetReportedPosition(origin)
            dmg:SetDamagePosition(origin)
            ent:TakeDamageInfo(dmg)

            if attack.viewpunch and ent:IsPlayer() then
                ent:ViewPunch(attack.viewpunch)
            end

            table.insert(hit, ent)
        end

        if isfunction(callback) then
            callback(self, hit)
        end
    end)
end

function ENT:OnOtherKilled(c)
	if (self:GetClass() == c:GetClass() or c.IsBandit) then
		if (self:GetRangeSquaredTo(c) < self.InformRadius) then
			self:ChooseSound("ally", 5)
		end
	end
end

function ENT:IsInCone(ent, angle, distance)
    if isnumber(distance) and not self:IsInRange(ent, distance) then return false end
    local selfpos = self:GetPos()
    local forward = self:GetForward()

    return (selfpos + forward):DrG_Degrees(ent:GetPos(), selfpos) <= angle / 2
end

function ENT:EntitiesInCone(angle, distance)
    local entities = {}
    local selfpos = self:GetPos()
    local forward = self:GetForward()

    --for _, v in ipairs(ents.GetAll()) do
	for _, v in ipairs(player.GetAll()) do
        if self:IsInCone(v, angle, distance) then
            table.insert(entities, v)
        end
    end

    return entities
end

function ENT:IsInRange(pos, range)
    if isentity(pos) and not IsValid(pos) then return false end

    return self:GetHullRangeSquaredTo(pos) <= (range * self:GetModelScale()) ^ 2
end

function ENT:GetHullRangeSquaredTo(pos)
    if isentity(pos) then
        pos = pos:NearestPoint(self:GetPos())
    end

    return self:NearestPoint(pos):DistToSqr(pos)
end