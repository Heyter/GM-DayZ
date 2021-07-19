PLUGIN.name = "Kill Feed"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = ""

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	local PLUGIN = PLUGIN
	PLUGIN.DeathNotify = PLUGIN.DeathNotify or nil
	PLUGIN.WeaponsList = PLUGIN.WeaponsList or {}

	PLUGIN.DeathMsg = {
		["bledout"] = "bled out", -- истек кровью
		["radiation"] = "radiation sickness", -- лучевая болезнь. Можно оставить просто radiation - радиация
		["drowned"] = "drowned"
	}

	for k in pairs(PLUGIN.DeathMsg) do
		local phrase = L2("killfeed.death." .. k)

		if (phrase) then
			PLUGIN.DeathMsg[k] = phrase
		end

		phrase = nil
	end

	function PLUGIN:InitPostEntity()
		self.WeaponsList = list.Get("Weapon")
		self.WeaponsList['rpg_missile'] = 'RPG Missile'
		self.WeaponsList['npc_satchel'] = 'S.L.A.M'
		self.WeaponsList['npc_grenade_frag'] = 'Frag Grenade'

		local panel = vgui.Create("DNotify")
		panel:SetPos(0, 25)
		panel:SetSize(ScrW() - 25, ScrH())
		panel:SetAlignment(9)
		panel:SetLife(6)
		panel:ParentToHUD()

		self.DeathNotify = panel
	end

	function PLUGIN:ScreenResolutionChanged()
		if (IsValid(self.DeathNotify)) then
			self.DeathNotify:Remove()
			self:InitPostEntity()
		end
	end

	local function KilledByWeapon(death_msg, ent_class, attacker, victim, color1, color2, pnl)
		local text = "killed"

		if (PLUGIN.DeathMsg[death_msg]) then
			text = PLUGIN.DeathMsg[death_msg]
		elseif (ent_class) then
			text = weapons.Get(ent_class) or scripted_ents.Get(ent_class) or PLUGIN.WeaponsList[ent_class] or ent_class

			if (istable(text)) then
				if (text.TrueName) then
					text = text.TrueName
				else
					text = text.PrintName
				end
			end
		end

		if (attacker:IsNPC() or attacker:IsNextBot()) then
			local copy_attacker = attacker:GetClass()
			attacker = scripted_ents.Get(copy_attacker) and attacker.PrintName or nil

			if (!attacker) then
				attacker = copy_attacker

				if (list.Get("NPC")[attacker]) then
					attacker = list.Get("NPC")[attacker].Name
				end
			end
		else
			attacker = attacker:GetName()
		end

		pnl:AddText(attacker, color1)
		pnl:AddText("[" .. L(text) .. "]", Color("light_gray"))
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

				if (PLUGIN.DeathMsg[death_msg]) then
					text = PLUGIN.DeathMsg[death_msg]
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
		elseif (attacker:IsNPC() or attacker:IsNextBot()) then -- NPC убил игрока.
			KilledByWeapon(death_msg, ent_class, attacker, victim, clrAtt, clrVic, pnl)
		end

		hook.Run("PostDeathNotice", victim, attacker)

		PLUGIN.DeathNotify:AddItem(pnl)
	end)
end