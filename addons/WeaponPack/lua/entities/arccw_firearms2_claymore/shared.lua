ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "M18A1"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/fas2/world/explosives/m18a1.mdl"
ENT.Ammo = "arccw_firearms2_nade_claymore"
ENT.FuseTime = 120
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.bNoPersist = true

if (CLIENT) then
	ENT.MatLaser = Material("sprites/tp_beam001") -- sprites/physbeama ; sprites/physgbeamb
else
	ENT.ExplodeDamage = 150 -- Урон
	ENT.ExplodeRadius = 320.0 -- Радиус взрыва
end

ENT.BaseHealth = 1
ENT.RangeDistance = 200 -- Дистанция обнаружения

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Armed")
end

if (CLIENT) then
	local red = Color(255, 0, 0)

	function ENT:Initialize()
		local ed = EffectData()
			ed:SetOrigin( self:GetPos() )
			ed:SetEntity( self )
		util.Effect( "propspawn", ed, true, true )
	end

	function ENT:Draw()
		if (LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 1048576) then return end -- 1024 * 1024
		self:DrawModel()

		if (self:GetArmed()) then
			local v1 = self:GetPos() + self:GetForward() + self:GetUp() * 12
			local v2 = self:GetPos() + self:GetRight() * 5 + self:GetForward() * 10 + self:GetUp() * 12
			render.SetMaterial(self.MatLaser)
			render.DrawBeam(v1, v2, 1, 0, 1, red)

			v2 = self:GetPos() + self:GetRight() * -5 + self:GetForward() * 10 + self:GetUp() * 12
			render.SetMaterial(self.MatLaser)
			render.DrawBeam(v1, v2, 1, 0, 1, red)
		end

		--[[ DEBUG CODE ]]
--[[ 		local mins = self:OBBMins()
		local maxs = self:OBBMaxs()
		local startpos = self:GetPos() + self:GetUp() * 15
		local endpos = startpos + self:GetForward() * self.RangeDistance
		local tr = util.TraceHull({
			start = startpos,
			endpos = endpos,
			maxs = maxs,
			mins = mins,
			filter = self
		})

		render.DrawLine( tr.HitPos, endpos, color_white, true )
		render.DrawLine( startpos, tr.HitPos, Color( 0, 0, 255 ), true )
		
		local clr = color_white
		if ( tr.Hit ) then
			clr = Color( 255, 0, 0 )
		end

		render.DrawWireframeBox( startpos, angle_zero, mins, maxs, color_white, true )
		render.DrawWireframeBox( tr.HitPos, angle_zero, mins, maxs, clr, true )

		for _, v in ipairs(ents.FindInCone(startpos, self:GetAngles():Forward(), 200, 0.8)) do
			if (IsValid(v) and (v:IsPlayer() or v:IsNPC() or v:IsNextBot())) then
				tr = util.TraceHull({
					start = startpos,
					endpos = v:GetPos(),
					maxs = maxs,
					mins = mins,
					filter = self
				})
				if (tr.Entity == v) then
					render.DrawLine( startpos, tr.HitPos, color_white, true )
				end
			end
		end ]]
	end
end