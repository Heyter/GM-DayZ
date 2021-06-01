--[[
   __  ___        __      __                                
  /  |/  /__ ____/ /__   / /  __ __                         
 / /|_/ / _ `/ _  / -_) / _ \/ // /                         
/_/  /_/\_,_/\_,_/\__/ /_.__/\_, /                          
   ___       __             /___/         ___           __  
  / _ \___  / /_ _____ ___ / /____ ____  / _ \__ ______/ /__
 / ___/ _ \/ / // / -_|_-</ __/ -_) __/ / // / // / __/  '_/
/_/   \___/_/\_, /\__/___/\__/\__/_/   /____/\_,_/\__/_/\_\ 
            /___/                                           
https://steamcommunity.com/profiles/76561198057599363
]]
CreateClientConVar("cl_weapon_holsters", "1", true, false, "Enable Weapon Holsters (client side)")
WepHolster = WepHolster or {}
WepHolster.wepInfo = WepHolster.wepInfo or {}

net.Receive("sendWholeWHData", function(len)
	WepHolster.wepInfo = net.ReadTable()
end)

net.Receive("sendWHData", function(len)
	local class = net.ReadString()
	local tbl = net.ReadTable()
	WepHolster.wepInfo[class] = tbl.Model and tbl or nil

	if not tbl.Model then
		for pl, weps in pairs(WepHolster.HolsteredWeps) do
			local ply = Entity(pl)

			for cls, wep in pairs(weps) do
				if cls == class then
					wep:Remove()
					WepHolster.HolsteredWeps[pl][cls] = nil
				end
			end
		end
	end
end)

WepHolster.HolsteredWeps = WepHolster.HolsteredWeps or {}

local function CalcOffset(pos, ang, off)
	return pos + ang:Right() * off.x + ang:Forward() * off.y + ang:Up() * off.z
end

local function cdwh()
	return WepHolster.wepInfo and WepHolster.HolsteredWeps and GetConVar("cl_weapon_holsters"):GetBool() and GetConVar("sv_weapon_holsters"):GetBool()
end

hook.Add("PostPlayerDraw", "WeaponHolster", function(ply)
	if not cdwh() then
		return
	end

	if IsValid(ply) and ply:Alive() then
		if (ply == LocalPlayer() and not ply:ShouldDrawLocalPlayer()) then
			return
		end

		for wepclass, model in pairs(WepHolster.HolsteredWeps[ply:EntIndex()] or {}) do
			if not WepHolster.wepInfo[wepclass] then
				return
			end

			local boneIndex = ply:LookupBone(WepHolster.wepInfo[wepclass].Bone)
			if (not boneIndex or boneIndex < 0) then
				return
			end

			local matrix = ply:GetBoneMatrix(boneIndex)
			if not matrix then
				return
			end

			local pos = matrix:GetTranslation()
			local ang = matrix:GetAngles()
			pos = CalcOffset(pos, ang, WepHolster.wepInfo[wepclass].BoneOffset[1])
			model:SetRenderOrigin(pos)
			ang:RotateAroundAxis(ang:Forward(), WepHolster.wepInfo[wepclass].BoneOffset[2].p)
			ang:RotateAroundAxis(ang:Up(), WepHolster.wepInfo[wepclass].BoneOffset[2].y)
			ang:RotateAroundAxis(ang:Right(), WepHolster.wepInfo[wepclass].BoneOffset[2].r)
			model:SetRenderAngles(ang)
			model:DrawModel()
		end
	end
end)

hook.Add("EntityRemoved", "WeaponHolster", function(entity)
	local holster = (WepHolster.HolsteredWeps or {})[entity:EntIndex()]

	if (holster) then
		for _, v in pairs(holster) do
			v:Remove()
		end

		WepHolster.HolsteredWeps[entity:EntIndex()] = nil
	end
end)

hook.Add("Think", "WeaponHolster", function()
	if not cdwh() then
		return
	end

	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply) and ply:Alive() then
			for k, v in pairs(ply:GetWeapons()) do
				local class = v:GetClass()
				local plyid = ply:EntIndex()
				WepHolster.HolsteredWeps[plyid] = WepHolster.HolsteredWeps[plyid] or {}

				if WepHolster.wepInfo[class] and ply:GetActiveWeapon() ~= v and not WepHolster.HolsteredWeps[plyid][class] then
					WepHolster.HolsteredWeps[plyid][class] = ClientsideModel(WepHolster.wepInfo[class].Model, RENDERGROUP_OPAQUE)

					if not IsValid(WepHolster.HolsteredWeps[plyid][class]) then
						SafeRemoveEntity(WepHolster.HolsteredWeps[plyid][class]) -- just in case.
						WepHolster.HolsteredWeps[plyid][class] = nil

						return
					end

					WepHolster.HolsteredWeps[plyid][class]:SetNoDraw(true)

					if WepHolster.wepInfo[class].isEditing then
						WepHolster.HolsteredWeps[plyid][class]:SetMaterial("models/wireframe")
						--print("wireframe화 think")
						--print(WepHolster.wepInfo[class].isEditing)
					end
				end
			end
		end
	end

	-- 필요없는 CSEnt 찾아서 삭제
	for pl, weps in pairs(WepHolster.HolsteredWeps) do
		local ply = Entity(pl)

		for class, wep in pairs(weps) do
			if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() or (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == class) or not IsValid(ply:GetWeapon(class)) then
				wep:Remove() -- 삭제
				WepHolster.HolsteredWeps[pl][class] = nil

				return
			end
		end
	end
end)