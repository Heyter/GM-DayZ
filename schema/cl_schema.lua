local textureInt = 0

--local ringMat = Material("effects/select_ring")
-- local redlaser_mat = Material( "cable/redlaser" )
--local blue_mat = Material( "cable/blue_elec" )
-- local hydr_mat = Material( "cable/hydra" )
-- local beam1_mat = Material( "cable/crystal_beam1" )

local Vector, render = Vector, render

function render.DrawBoundingBox( pos1, pos2, color, mat, thick )
	--mat = mat or blue_mat
	thick = thick or 1
	color = color or color_white

	local a1 = Vector( pos1.x, pos2.y, pos1.z )
	local a2 = Vector(pos2.x, pos1.y, pos1.z)
	local a3 = Vector(pos1.x, pos1.y, pos2.z)

	local b1 = Vector( pos2.x, pos2.y, pos1.z )
	local b2 = Vector( pos2.x, pos1.y, pos2.z )
	local b3 = Vector( pos1.x, pos2.y, pos2.z )

	if (mat) then
		render.SetMaterial( mat )
	else
		render.SetColorMaterial()
	end

	render.DrawBeam( pos1, a1, thick, textureInt, textureInt, color )
	render.DrawBeam( pos1, a2, thick, textureInt, textureInt, color )
	render.DrawBeam( pos1, a3, thick, textureInt, textureInt, color )
	render.DrawBeam( pos2, b1, thick, textureInt, textureInt, color )
	render.DrawBeam( pos2, b2, thick, textureInt, textureInt, color )
	render.DrawBeam( pos2, b3, thick, textureInt, textureInt, color )
	render.DrawBeam( a3, b3, thick, textureInt, textureInt, color )
	render.DrawBeam( a3, b2, thick, textureInt, textureInt, color )
	render.DrawBeam( b2, a2, thick, textureInt, textureInt, color )
	render.DrawBeam( b3, a1, thick, textureInt, textureInt, color )
	render.DrawBeam( b1, a1, thick, textureInt, textureInt, color )
	render.DrawBeam( b1, a2, thick, textureInt, textureInt, color )
end

-- render.SetMaterial(ringMat)
-- render.DrawQuadEasy(center, vector_up, sizeRing, sizeRing, Color(50, 200, 50))