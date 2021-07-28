local enabled = false

hook.Add("HUDPaint", "123", function()
	if not enabled then
		return
	end

	surface.SetDrawColor(color_white)
	surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
	surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())
end)

concommand.Add("lox", function()
	enabled = not enabled
end)