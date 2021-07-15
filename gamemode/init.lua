
AddCSLuaFile("cl_init.lua")
DeriveGamemode("helix")

local GM = GM or GAMEMODE

local vector_min = Vector( -16, -16, 0 )
local vector_max = Vector( 16, 16, 64 )

--[[---------------------------------------------------------
	Name: gamemode:IsSpawnpointSuitable( player )
	Desc: Find out if the spawnpoint is suitable or not
-----------------------------------------------------------]]
function GM:IsSpawnpointSuitable( pl, spawnpointent, bMakeSuitable )
	local Pos = spawnpointent:GetPos()

	-- Note that we're searching the default hull size here for a player in the way of our spawning.
	-- This seems pretty rough, seeing as our player's hull could be different.. but it should do the job
	-- (HL2DM kills everything within a 128 unit radius)
	local Ents = ents.FindInBox( Pos + vector_min, Pos + vector_max )

	if ( pl:Team() == TEAM_SPECTATOR ) then return true end

	for _, v in ipairs( Ents ) do
		if ( IsValid( v ) and v != pl and v:IsPlayer() and v:Alive() ) then
			if ( bMakeSuitable ) then
				v:Kill()
			else
				return false
			end
		end
	end

	return true
end