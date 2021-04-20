Schema.name = "GmodZ"
Schema.author = "Hikka"
Schema.description = ""

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

function Schema:GetPainSound(gender, hit_group)
	if (math.random() <= 0.5) then
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
	
	return "vo/npc/"..gender.."01/pain0"..math.random(1, 9)..".wav"
end

function Schema:PlayerEmitPainSound(client, hit_group)
	local sound_path = self:GetPainSound(client:IsFemale() and "female" or "male", hit_group)

	if (sound_path) then
		timer.Simple(FrameTime(), function()
			if (IsValid(client)) then
				client:EmitSound(sound_path)
			end
		end)
	end
end