PLUGIN.name = "Squad"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Creation of your super-duper squad."

ix.squad = ix.squad or {}
ix.squad.list = ix.squad.list or {}

ix.char.RegisterVar("squadID", {
	bNoDisplay = true,
	isLocal = true,
	default = "NULL",
	field = "squad_id",
	fieldType = ix.type.steamid
})

ix.char.RegisterVar("squadOfficer", {
	bNoDisplay = true,
	bNoNetworking = true,
	default = 0,
	field = "squad_officer",
	fieldType = ix.type.bool
})

ix.util.Include("meta/sh_squad.lua", "shared")

function ix.squad.Register(owner, name, data)
	local squad = ix.squad.meta:New(owner, name)
	squad.members = squad.members or {}
	squad.members[owner] = 2

	for k, v in pairs(data or {}) do
		squad[k] = v
	end

	ix.squad.list[owner] = squad
	return squad
end

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	function PLUGIN:PlayerBindPress(_, bind, pressed)
		if (bind:find("gm_showspare2") and pressed) then
			// ...
			return true
		end
	end

	function PLUGIN:LoadFonts()
		surface.CreateFont("squadNameTag", {
			font = "Jura",
			size = math.max(ScreenScale(7), 20),
			extended = true,
			weight = 500
		})
	end

	net.Receive("ixSquadSync", function()
		local data = net.ReadTable()
		if (table.IsEmpty(data)) then return end

		local squad = ix.squad.Register(data.owner, data.name, {
			color = data.color,
			logo = data.logo,
			description = data.description
		})

		for steamid, rank in pairs(data.members or {}) do
			squad.members[steamid] = rank
		end

		if (IsValid(ix.gui.squad)) then
			ix.gui.squad.data = squad
			ix.gui.squad:SetMembers(squad, true)
		end
	end)

	net.Receive("ixSquadKick", function()
		local id = net.ReadString()
		if (!ix.squad.list[id]) then return end

		if (net.ReadBool()) then
			if (IsValid(ix.gui.squad)) then
				ix.gui.squad:Remove()
				ix.gui.squad = nil
			end

			ix.squad.list[id] = nil
			LocalPlayer():Notify("The leader has disbanded the squad!")
		elseif (ix.squad.list[id]) then
			if (ix.squad.list[id].members[LocalPlayer():SteamID64()]) then
				ix.squad.list[id].members[LocalPlayer():SteamID64()] = nil
				LocalPlayer():Notify("You were kicked out of the squad!")
			end

			local panel = ix.gui.squad
			if (IsValid(panel) and panel.data.members[LocalPlayer():SteamID64()]) then
				ix.gui.squad.data = ix.squad.list[id]
				ix.gui.squad:SetMembers(ix.gui.squad.data, true)
			end
		end
	end)
end

ix.command.Add("accept_squad", {
	description = "Accept an invitation to the squad.",
	OnRun = function(self, client)
		if (!istable(client.squad_invite) or client.squad_invite[1] < CurTime()) then return end

		ix.squad.AddMember(client, Player(client.squad_invite[2]))
		return
	end
})