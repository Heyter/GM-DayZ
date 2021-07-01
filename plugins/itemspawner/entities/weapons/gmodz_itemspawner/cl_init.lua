include("shared.lua")

local PLUGIN = PLUGIN

SWEP.PrintName = "Item Spawner"
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.nearDist = math.pow(256, 2)

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + .05)
    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + .05)
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end

function SWEP:DrawHUD()
	local w, h = ScrW(), ScrH()
	local cury = h/4*3
	local tx, ty = draw.SimpleText(input.LookupBinding("+attack") .. ": Добавить спавн", "ixMediumFont", w/2, cury, color_white, 1, 1)
	cury = cury + ty
	local tx, ty = draw.SimpleText(input.LookupBinding("+attack2") .. ": Удалить спавн", "ixMediumFont", w/2, cury, color_white, 1, 1)
	cury = cury + ty
	draw.SimpleText(string.upper(input.LookupBinding("+reload")) .. ": Вызвать меню", "ixMediumFont", w/2, cury, color_white, 1, 1)

	if (!PLUGIN.spawner) then return false end
	local spawners = PLUGIN.spawner.positions or {}
	if (table.IsEmpty(spawners)) then return false end

	local location = self:GetOwner():GetEyeTrace().HitPos
	location.z = location.z + 10

	for k, v in ipairs(spawners) do
		if (location:DistToSqr(v.position) > 128 * 128) then continue end
		local a = v.position:ToScreen()
		local col = color_white

		for _, v2 in ipairs(ents.FindInSphere(v.position, 16)) do
			if (IsValid(v2) and (v2:IsPlayer() and v2:GetMoveType() != MOVETYPE_NOCLIP or v2:GetClass() == "ix_item")) then
				col = Color("red")
				break
			end
		end

		if (LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP and LocalPlayer():GetPos():DistToSqr(v.position) < self.nearDist) then
			col = Color("red")
		end

		surface.SetDrawColor(Color("sky_blue"))
		surface.DrawRect(a.x, a.y, 8, 8)
		draw.SimpleText(v.title, "ixSmallFont", a.x, a.y - 10, col, 1, 1)
		draw.SimpleText(Format("Rarity: %d%%", (v.rarity * 100)), "ixSmallFont", a.x, a.y - 10 - ty*0.6, color_white, 1, 1)
		draw.SimpleText(Format("Delay: %d min", v.delay), "ixSmallFont", a.x, a.y - 10 - ty - 5, color_white, 1, 1)
	end
end