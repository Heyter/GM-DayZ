include("shared.lua")

ENT.MaxRenderDistance = 500000
ENT.MaxAlphaDistance = 100000

function ENT:Draw()
	--self:DrawModel()

	local dist = EyePos():DistToSqr(self:GetPos())
	if (dist > (self.MaxRenderDistance)) then return end

	surface.SetAlphaMultiplier(math.Clamp(5 - (dist / self.MaxAlphaDistance), 0, 1))

		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 90)

		cam.Start3D2D(self:GetPos() + ang:Up() * 4.8, ang, 0.2)
			draw.SimpleTextOutlined(L"stash_title", "Stash3D2DTextLarge", 0, -150 - 10, Color("sky_blue"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			draw.SimpleTextOutlined(L"stash_desc", "Stash3D2DTextSmall", 0, -150 + 65, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		cam.End3D2D()

	surface.SetAlphaMultiplier(1)
end