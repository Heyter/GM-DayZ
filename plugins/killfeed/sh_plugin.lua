local PLUGIN = PLUGIN

PLUGIN.name = "Kill Feed"
PLUGIN.author = "Rorkh"
PLUGIN.description = "Kill feed."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

-- LANGUAGE
if (CLIENT) then
	do
		ix.lang.AddTable("russian", {
			bled_out = "истек кровью"
		})

		ix.lang.AddTable("english", {
			bled_out = "bled out"
		})
	end
end