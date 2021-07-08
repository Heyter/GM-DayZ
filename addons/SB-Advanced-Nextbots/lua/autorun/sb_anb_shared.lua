if (CLIENT) then
	net.Receive("sb_anb_ragdoll",function()
		local entity = net.ReadEntity()
		if (!IsValid(entity)) then return end

		local doll = ClientsideRagdoll(net.ReadString())
		doll:SetPos(entity:GetPos())
		doll:SetAngles(entity:EyeAngles())
		doll:SetSkin(0)
		doll:SetNoDraw(false)
		doll:DrawShadow(false)
		doll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		local velocity = entity:GetVelocity()

		for i = 0, doll:GetPhysicsObjectCount() - 1 do
			local physObj = doll:GetPhysicsObjectNum(i)

			if (IsValid(physObj)) then
				physObj:SetVelocity(velocity)

				local index = doll:TranslatePhysBoneToBone(i)

				if (index) then
					local position, angles = entity:GetBonePosition(index)

					physObj:SetPos(position)
					physObj:SetAngles(angles)
				end
			end
		end

		SafeRemoveEntityDelayed(doll, 7)
	end)
end