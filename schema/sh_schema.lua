Schema.name = "GmodZ"
Schema.author = "Hikka"
Schema.description = ""

-- ix.util.Include("libs/thirdparty/circles.lua", "client")

math.randomseed(os.time())

function Schema:GetGameDescription()
	return self.name
end

ix.util.Include("sh_configs.lua")

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.IncludeDir("hooks")
ix.util.IncludeDir("meta")

-- Restrict character description
local descVar = ix.char.vars["description"]
descVar.OnValidate = nil
descVar.OnPostSetup = nil
descVar.bNoDisplay = true
descVar.bNoNetworking = true
descVar.bNotModifiable = true
descVar.bSaveLoadInitialOnly = true

-- Restrict character name
ix.char.RegisterVar("name", {
	field = "name",
	fieldType = ix.type.string,
	default = "John Doe",
	index = 1,
	OnValidate = nil,
	OnPostSetup = nil,
	bNoDisplay = true,
	bNoNetworking = true,
	bNotModifiable = true,
	bSaveLoadInitialOnly = true,
	OnGet = function(character, default)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			return client:GetName()
		end

		return "Unknown"
	end
})

if (CLIENT) then
	local GM = GM or GAMEMODE
	GM.PopulateCharacterInfo = nil
	GM.PopulateImportantCharacterInfo = nil
	hook.Remove("CreateMenuButtons", "ixCharInfo")

	function Schema:CanCreateCharacterInfo(suppress)
		suppress.name = true
		suppress.description = true
	end

	function Schema:CreateCharacterInfoCategory(panel)
		local format = (ix.option.Get("24hourTime", false) and "%H:%M" or "%I:%M %p")

		panel.time:SetText(ix.date.GetFormatted(format))
		panel.time.Paint = function(this, w, h)
			surface.SetDrawColor(ColorAlpha(color_black, 100))
			surface.DrawRect(w * 0.5 - this:GetContentSize() * 0.5 - 2, 0, this:GetContentSize() + 6, h + 4)
		end
		panel.time.Think = function(this)
			if ((this.nextTime or 0) < CurTime()) then
				this:SetText(ix.date.GetFormatted(format))
				this.nextTime = CurTime() + 0.5
			end
		end
	end
end

function Schema:GetPainSound(gender, hit_group, bNotRandom, bNotDefaultHit)
	if (bNotRandom or math.random() <= 0.5) then
		if (hit_group == HITGROUP_HEAD) then
			return "vo/npc/"..gender.."01/ow0"..math.random(1, 2)..".wav"
		elseif (hit_group == HITGROUP_CHEST or hit_group == HITGROUP_GENERIC) then
			return "vo/npc/"..gender.."01/hitingut0"..math.random(1, 2)..".wav"
		elseif (hit_group == HITGROUP_LEFTLEG or hit_group == HITGROUP_RIGHTLEG) then
			return "vo/npc/"..gender.."01/myleg0"..math.random(1, 2)..".wav"
		elseif (hit_group == HITGROUP_LEFTARM or hit_group == HITGROUP_RIGHTARM) then
			return "vo/npc/"..gender.."01/myarm0"..math.random(1, 2)..".wav"
		elseif (hit_group == HITGROUP_GEAR) then
			return "vo/npc/"..gender.."01/startle0"..math.random(1, 2)..".wav"
		end
	end

	return !bNotDefaultHit and "vo/npc/"..gender.."01/pain0"..math.random(1, 9)..".wav"
end

function Schema:PlayerEmitPainSound(client, hit_group, bNotRandom, bNotDefaultHit)
	local sound_path = self:GetPainSound(client:IsFemale() and "female" or "male", hit_group, bNotRandom, bNotDefaultHit)

	if (sound_path != false) then
		timer.Simple(FrameTime(), function()
			if (IsValid(client)) then
				client:EmitSound(sound_path)
			end
		end)
	end
end

function ix.plugin.LoadEntities(path)
	local bLoadedTools
	local files, folders

	local function IncludeFiles(path2, bClientOnly)
		if (SERVER and !bClientOnly) then
			if (file.Exists(path2.."init.lua", "LUA")) then
				ix.util.Include(path2.."init.lua", "server")
			elseif (file.Exists(path2.."shared.lua", "LUA")) then
				ix.util.Include(path2.."shared.lua")
			end

			if (file.Exists(path2.."cl_init.lua", "LUA")) then
				ix.util.Include(path2.."cl_init.lua", "client")
			end
		elseif (file.Exists(path2.."cl_init.lua", "LUA")) then
			ix.util.Include(path2.."cl_init.lua", "client")
		elseif (file.Exists(path2.."shared.lua", "LUA")) then
			ix.util.Include(path2.."shared.lua")
		end
	end

	local function HandleEntityInclusion(folder, variable, register, default, clientOnly, create, complete)
		files, folders = file.Find(path.."/"..folder.."/*", "LUA")
		default = default or {}

		for _, v in ipairs(folders) do
			local path2 = path.."/"..folder.."/"..v.."/"
			v = ix.util.StripRealmPrefix(v)

			_G[variable] = table.Copy(default)

			if (!isfunction(create)) then
				_G[variable].ClassName = v
			else
				create(v)
			end

			IncludeFiles(path2, clientOnly)

			if (clientOnly) then
				if (CLIENT) then
					register(_G[variable], v)
				end
			else
				register(_G[variable], v)
			end

			if (isfunction(complete)) then
				complete(_G[variable])
			end

			_G[variable] = nil
		end

		for _, v in ipairs(files) do
			local niceName = ix.util.StripRealmPrefix(string.StripExtension(v))

			_G[variable] = table.Copy(default)

			if (!isfunction(create)) then
				_G[variable].ClassName = niceName
			else
				create(niceName)
			end

			ix.util.Include(path.."/"..folder.."/"..v, clientOnly and "client" or "shared")

			if (clientOnly) then
				if (CLIENT) then
					register(_G[variable], niceName)
				end
			else
				register(_G[variable], niceName)
			end

			if (isfunction(complete)) then
				complete(_G[variable])
			end

			_G[variable] = nil
		end
	end

	local function RegisterTool(tool, className)
		local gmodTool = weapons.GetStored("gmod_tool")

		if (className:sub(1, 3) == "sh_") then
			className = className:sub(4)
		end

		if (gmodTool) then
			gmodTool.Tool[className] = tool
			gmodTool.Tool[className]:CreateConVars()
		else
			-- this should never happen
			ErrorNoHalt(string.format("attempted to register tool '%s' with invalid gmod_tool weapon", className))
		end

		bLoadedTools = true
	end

	-- Include entities.
	HandleEntityInclusion("entities", "ENT", scripted_ents.Register, {
		Type = "anim",
		Base = "base_gmodentity",
		Spawnable = true
	}, false, nil, function(ent)
		if (SERVER and ent.Holdable == true) then
			ix.allowedHoldableClasses[ent.ClassName] = true
		end
	end)

	-- Include weapons.
	HandleEntityInclusion("weapons", "SWEP", weapons.Register, {
		Primary = {},
		Secondary = {},
		Base = "weapon_base"
	})

	HandleEntityInclusion("tools", "TOOL", RegisterTool, {}, false, function(className)
		if (className:sub(1, 3) == "sh_") then
			className = className:sub(4)
		end

		TOOL = ix.meta.tool:Create()
		TOOL.Mode = className
	end)

	-- Include effects.
	HandleEntityInclusion("effects", "EFFECT", effects and effects.Register, nil, true)

	-- only reload spawn menu if any new tools were registered
	if (CLIENT and bLoadedTools) then
		RunConsoleCommand("spawnmenu_reload")
	end
end

collectgarbage()