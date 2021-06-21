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

		for steamid, rank in ipairs(data.members or {}) do
			squad.members[steamid] = rank
		end

		if (IsValid(ix.gui.squad)) then
			// TODO: Удалить/добавить участника
		end
	end)

	net.Receive("ixSquadKick", function()
		local squad_id = net.ReadUInt(10)
		if (!ix.squad.list[squad_id]) then return end

		if (ix.squad.list[squad_id].members[LocalPlayer():SteamID64()]) then
			ix.squad.list[squad_id].members[LocalPlayer():SteamID64()] = nil
		end

		// TODO: if IsValid(panel)
	end)
end