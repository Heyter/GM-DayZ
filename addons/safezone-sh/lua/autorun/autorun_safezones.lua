SH_SZ = {}

include("sz_config.lua")
include("safezones/sh_shapes.lua")
include("safezones/sh_main.lua")

if (SERVER) then
	AddCSLuaFile("autorun/autorun_safezones.lua")
	AddCSLuaFile("safezones/sh_shapes.lua")
	AddCSLuaFile("safezones/sh_main.lua")
	AddCSLuaFile("safezones/cl_interface.lua")
	AddCSLuaFile("safezones/cl_main.lua")
	AddCSLuaFile("safezones/cl_editor.lua")
	AddCSLuaFile("sz_config.lua")

	include("safezones/sv_main.lua")
else
	include("safezones/cl_interface.lua")
	include("safezones/cl_main.lua")
	include("safezones/cl_editor.lua")
end