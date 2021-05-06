PLUGIN.name = "Kill Feed"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	local PLUGIN = PLUGIN
	PLUGIN.DeathNotify = PLUGIN.DeathNotify or nil

	function PLUGIN:InitPostEntity()
		local panel = vgui.Create("DNotify")
		panel:SetPos(0, 25)
		panel:SetSize(ScrW() - 25, ScrH())
		panel:SetAlignment(9)
		panel:SetLife(6)
		panel:ParentToHUD()

		self.DeathNotify = panel
	end

	local function KilledByWeapon(death_msg, ent_class, attacker, victim, color1, color2, pnl)
		local text = "killed"

		if (death_msg == "bledout") then
			text = "bled out"
		elseif (ent_class) then
			text = weapons.Get(ent_class) or scripted_ents.Get(ent_class) or ent_class

			if (istable(text)) then
				if (text.TrueName) then
					text = text.TrueName
				else
					text = text.PrintName
				end
			end
		end

		if (attacker:IsNPC()) then
			local copy_attacker = attacker:GetClass()
			attacker = scripted_ents.Get(copy_attacker) and attacker.PrintName or nil

			if (!attacker) then
				attacker = copy_attacker

				if (list.Get( "NPC" )[attacker]) then
					attacker = list.Get( "NPC" )[attacker].Name
					text = "killed"
				end
			end
		else
			attacker = attacker:GetName()
		end

		pnl:AddText(attacker, color1)
		pnl:AddText("[" .. text .. "]", Color("light_gray"))
		pnl:AddText(victim:GetName(), color2)
	end

	net.Receive("ixDeathNotice", function()
		if (!IsValid(PLUGIN.DeathNotify)) then
			PLUGIN:InitPostEntity()
		end

		local victim = net.ReadEntity()
		local attacker = net.ReadEntity()
		local ent_class = net.ReadString()
		local death_msg = net.ReadString()

		local pnl = vgui.Create("GameNotice", PLUGIN.DeathNotify)

		local clrAtt = hook.Run("GetKillfeedColor", attacker) or color_white
		local clrVic = hook.Run("GetKillfeedColor", victim) or color_white

		if (attacker:IsPlayer()) then
			if (attacker == victim) then
				pnl:AddText(victim:GetName(), clrVic)

				if (death_msg == "bledout") then
					text = "bled out"
				else -- неизвестная причина
					text = "suicide"
				end

				pnl:AddText(Format("[%s]", text), gray)
			else
				KilledByWeapon(death_msg, ent_class, attacker, victim, clrAtt, clrVic, pnl)
			end
		elseif (attacker:IsWorld()) then
			pnl:AddText(victim:GetName(), clrVic)
			pnl:AddText("[crashed]", gray) -- разбился кароче
		elseif (attacker:IsNPC()) then -- NPC убил игрока.
			-- %Name% был убит Бандитами
			-- TODO: в будущем, когда появятся НПС, подправить.
			KilledByWeapon(death_msg, ent_class, attacker, victim, clrAtt, clrVic, pnl)
		end

		PLUGIN.DeathNotify:AddItem(pnl)
	end)
end