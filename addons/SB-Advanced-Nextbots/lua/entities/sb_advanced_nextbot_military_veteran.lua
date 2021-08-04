AddCSLuaFile()

ENT.Base = "sb_advanced_nextbot_bandit_base"
DEFINE_BASECLASS(ENT.Base)

ENT.PrintName = "Military"

list.Set("NPC","sb_advanced_nextbot_military_veteran", {
	Name = ENT.PrintName,
	Class = "sb_advanced_nextbot_military_veteran",
	Category = "SB Advanced Nextbots"
})

if CLIENT then
	language.Add("sb_advanced_nextbot_military_veteran", ENT.PrintName)
	return
end

ENT.Model = "models/gmodz/npc/military_master.mdl"
ENT.RagdollModel = "models/gmodz/npc/military_master.mdl"

ENT.GrenadeMinDistance = math.pow(400, 2)
ENT.GrenadeMaxDistance = math.pow(890, 2)
ENT.DefaultWeapon = "weapon_minimi_sb_anb"
ENT.CanMeleeAttack = false

ENT.InformRadius = math.pow(512, 2)

if (SERVER) then
	function ENT:ChooseSound(key, delay, force)
		if (!force and self:Health() <= 0) then return end
		self.speech_sounds = self.speech_sounds or {}
		if (!force and self.speech_sounds[key] and self.speech_sounds[key][1] > CurTime()) then return end
	
		local soundPath
	
		if (key == "alert") then
			soundPath = "gmodz/npc/military/enemy_" .. math.random(1, 5) .. ".ogg"
		elseif (key == "death") then
			soundPath = "gmodz/npc/military/death_" .. math.random(1, 5) .. ".ogg"
		elseif (key == "pain") then
			soundPath = "gmodz/npc/military/hit_" .. math.random(1, 6) .. ".ogg"
		elseif (key == "walk" or key == "idle") then
			soundPath = "gmodz/npc/military/idle_" .. math.random(1, 28) .. ".ogg"
		elseif (key == "gmodz/grenade_prep") then
			soundPath = "npc/military/grenade_" .. math.random(1, 3) .. ".ogg"
		elseif (key == "gmodz/grenade_throw") then
			soundPath = "gmodz/npc/military/grenade_ready_" .. math.random(1, 7) .. ".ogg"
		elseif (key == "help") then
			soundPath = "gmodz/npc/military/help_" .. math.random(1, 6) .. ".ogg"
		elseif (key == "ally") then
			soundPath = "gmodz/npc/military/tolls_" .. math.random(1, 4) .. ".ogg"
		elseif (key == "enemy_lost") then
			soundPath = "gmodz/npc/military/search_" .. math.random(1, 5) .. ".ogg"
		elseif (key == "friendly") then
			soundPath = "gmodz/npc/military/friendly_fire_" .. math.random(1, 5) .. ".ogg"
		elseif (key == "attack") then
			if (math.random(1, 2) == 1) then
				soundPath = "gmodz/npc/military/attack_" .. math.random(1, 14) .. ".ogg"
			else
				soundPath = "gmodz/npc/military/detour_" .. math.random(1, 17) .. ".ogg"
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
end



util.PrecacheModel(ENT.Model)
util.PrecacheModel(ENT.RagdollModel)