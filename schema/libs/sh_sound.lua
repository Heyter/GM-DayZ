--[[
	Credit to TFA for figuring this mess out.
	Original: https://steamcommunity.com/sharedfiles/filedetails/?id=903541818
]]

if (system.IsLinux()) then
	local cache = {}

	-- Helper Functions
	local function GetSoundPath(path, gamedir)
		if (!gamedir) then
			path = "sound/" .. path
			gamedir = "GAME"
		end

		return path, gamedir
	end

	local function f_IsWAV(f)
		f:Seek(8)

		return f:Read(4) == "WAVE"
	end

	-- WAV functions
	local function f_SampleDepth(f)
		f:Seek(34)
		local bytes = {}

		for i = 1, 2 do
			bytes[i] = f:ReadByte(1)
		end

		local num = bit.lshift(bytes[2], 8) + bit.lshift(bytes[1], 0)

		return num
	end

	local function f_SampleRate(f)
		f:Seek(24)
		local bytes = {}

		for i = 1, 4 do
			bytes[i] = f:ReadByte(1)
		end

		local num = bit.lshift(bytes[4], 24) + bit.lshift(bytes[3], 16) + bit.lshift(bytes[2], 8) + bit.lshift(bytes[1], 0)

		return num
	end

	local function f_Channels(f)
		f:Seek(22)
		local bytes = {}

		for i = 1, 2 do
			bytes[i] = f:ReadByte(1)
		end

		local num = bit.lshift(bytes[2], 8) + bit.lshift(bytes[1], 0)

		return num
	end

	local function f_Duration(f)
		return (f:Size() - 44) / (f_SampleDepth(f) / 8 * f_SampleRate(f) * f_Channels(f))
	end

	ixSoundDuration = ixSoundDuration or SoundDuration -- luacheck: globals ixSoundDuration

	function SoundDuration(str) -- luacheck: globals SoundDuration
		local path, gamedir = GetSoundPath(str)
		local f = file.Open(path, "rb", gamedir)

		if (!f) then return 0 end --Return nil on invalid files

		local ret

		if (cache[str]) then
			ret = cache[str]
		elseif (f_IsWAV(f)) then
			ret = f_Duration(f)
		else
			ret = ixSoundDuration(str)
		end

		f:Close()

		return ret
	end
end