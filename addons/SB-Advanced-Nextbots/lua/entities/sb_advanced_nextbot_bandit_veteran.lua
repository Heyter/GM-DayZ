AddCSLuaFile()

ENT.Base = "sb_advanced_nextbot_bandit_base"
DEFINE_BASECLASS(ENT.Base)

ENT.PrintName = "Bandit"

list.Set("NPC","sb_advanced_nextbot_bandit_veteran", {
	Name = ENT.PrintName,
	Class = "sb_advanced_nextbot_bandit_veteran",
	Category = "SB Advanced Nextbots"
})

if CLIENT then
	language.Add("sb_advanced_nextbot_bandit_veteran", ENT.PrintName)
	return
end

ENT.Model = "models/gmodz/npc/bandit_veteran.mdl"
ENT.RagdollModel = "models/gmodz/npc/bandit_veteran.mdl"

ENT.GrenadeMinDistance = math.pow(400, 2)
ENT.GrenadeMaxDistance = math.pow(890, 2)
ENT.DefaultWeapon = "weapon_ak47_sb_anb"
ENT.CanMeleeAttack = false

ENT.InformRadius = math.pow(512, 2)

util.PrecacheModel(ENT.Model)
util.PrecacheModel(ENT.RagdollModel)