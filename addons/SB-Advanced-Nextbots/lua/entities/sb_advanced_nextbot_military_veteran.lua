AddCSLuaFile()

ENT.Base = "sb_advanced_nextbot_military_base"
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

util.PrecacheModel(ENT.Model)
util.PrecacheModel(ENT.RagdollModel)