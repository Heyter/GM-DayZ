if (CLIENT) then
	local function normalize(min, max, val)
		local delta = max - min

		return (val - min) / delta
	end

	local red, green = Color(255, 0, 0), Color(0, 255, 0)
	function LerpColorHSV(start_color, end_color, maxValue, currentValue, minValue)
		start_color = green
		end_color = red
		minValue = minValue or 0

		local hsv_start = ColorToHSV(end_color)
		local hsv_end = ColorToHSV(start_color)

		local linear = Lerp(normalize(minValue, maxValue, currentValue), hsv_start, hsv_end)

		return HSVToColor(linear, 1, 1)
	end

	function util.GetInjuredColor(client)
		local health_color = color_white

		if (!IsValid(client)) then
			return health_color
		end

		local health_color = color_white
		local health, healthMax = client:Health(), client:GetMaxHealth()

		if ((health / healthMax) < .95) then
			health_color = LerpColorHSV(nil, nil, healthMax, health, 0)
		end

		return health_color
	end
end