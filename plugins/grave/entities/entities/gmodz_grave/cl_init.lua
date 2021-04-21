include("shared.lua")

ENT.MaxRenderDistance = math.pow(512, 2)

function ENT:Draw()
	self:DrawModel()

	local dist = LocalPlayer():GetPos():DistToSqr(self:GetPos())
	if (dist > self.MaxRenderDistance) then return end
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local alpha = 255 - (math.Clamp((dist / self.MaxRenderDistance) * 255, 0, 255))
	if (alpha < 1) then return end

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	cam.Start3D2D(pos + ang:Up() * 4.8, ang, 0.1)
		self:DoDraw(alpha)
	cam.End3D2D()

	ang:RotateAroundAxis(ang:Right(), 180)
	cam.Start3D2D(pos + ang:Up() * 4.8, ang, 0.1)
		self:DoDraw(alpha)
	cam.End3D2D()
end

function ENT:DoDraw(alpha)
	local to_loot = L"to_loot"
	local here_lies = L"here_lies"

	local steamIcon = ix.steam.GetAvatar(self:GetStoredID())
	local ownerNick = self:GetStoredName()
	local repData = Schema.ranks[self:GetReputation()] or Schema.ranks[0]

	if (ownerNick == "") then
		ownerNick = "Unknown"
	end

	local pos = -150

	local white = ColorAlpha(color_white, alpha)								
	draw.DrawText(here_lies, "GraveTitle", 0, pos - 10, white, TEXT_ALIGN_CENTER)
	draw.DrawText(tostring(ownerNick), "GraveTitleLarge", 0, pos + 30, ColorAlpha(repData[2] or color_white, alpha), TEXT_ALIGN_CENTER) -- reputation

	pos = pos + 85

	if (steamIcon) then
		surface.SetDrawColor(white)
		surface.SetMaterial(steamIcon)
		surface.DrawTexturedRect(pos / 2 - 11, pos, 96, 96)
	end

	local useText = string.upper(Format("[%s]", input.LookupBinding("+use")) or "NA")
	surface.SetFont("GraveTitle")
	local lootTextX = surface.GetTextSize(to_loot)
	local useTextX = surface.GetTextSize(useText)

	draw.DrawText(useText, "GraveTitle", -lootTextX / 2, pos + 95, Color(50, 255, 50, alpha), TEXT_ALIGN_CENTER)
	draw.DrawText(to_loot, "GraveTitle", useTextX / 2 + 10, pos + 95, white, TEXT_ALIGN_CENTER)
end