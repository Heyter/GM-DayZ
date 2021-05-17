if (CLIENT) then
	function ix.util.GetInjuredColor(client)
		local health_color = color_white

		if (!IsValid(client)) then
			return health_color
		end

		local health_color = color_white
		local health, healthMax = client:Health(), client:GetMaxHealth()

		if ((health / healthMax) < .95) then
			health_color = ix.util.LerpColorHSV(nil, nil, healthMax, health, 0)
		end

		return health_color
	end

    function ix.util.ScreenScaleH(n)
        return n * (ScrH() / 480)
    end
	--ScreenScale = Width scale
end