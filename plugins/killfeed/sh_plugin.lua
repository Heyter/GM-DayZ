local PLUGIN = PLUGIN

PLUGIN.name = "Kill Feed"
PLUGIN.author = "Rorkh"
PLUGIN.description = "Kill feed."

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