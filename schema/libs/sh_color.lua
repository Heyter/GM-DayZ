local colorMeta = FindMetaTable('Color')

do
	function colorMeta:Pulsate(c) -- used for flashing colors
		return (math.abs(math.sin(CurTime() * c)))
	end

	function colorMeta:Fluctuate(c) -- used for flashing colors
		return (math.cos(CurTime() * c) + 1) / 2
	end

	function colorMeta:Darken(amt)
		return Color(
			math.Clamp(self.r - amt, 0, 255),
			math.Clamp(self.g - amt, 0, 255),
			math.Clamp(self.b - amt, 0, 255),
			self.a
		)
	end
end

function Color(r, g, b, a)
	return setmetatable({
		r = tonumber(r) or 255,
		g = tonumber(g) or 255,
		b = tonumber(b) or 255,
		a = tonumber(a) or 255
	}, colorMeta)
end

do
	local colors = {
		blue = Color(0, 0, 255),
		red = Color(255, 0, 0),
		orange = Color(252, 177, 3),
		lime = Color(0, 255, 0),
		dark_lime = Color(50, 255, 50),
		light_lime = Color(50, 200, 50),
		yellow = Color(255, 255, 0),
		light_gray = Color(197, 197, 197),
		green = Color(0, 255, 0),
		light_green = Color(100, 255, 100),
	}

	local old_color = _OLD_COLOR_FN_ or Color
	_OLD_COLOR_FN_ = old_color

	function Color(r, g, b, a)
		if (isstring(r)) then
			if (colors[r:lower()]) then
				return ColorAlpha(colors[r:lower()], g or 255)
			elseif (isstring(g) and isstring(b)) then
				return old_color(r, g, b, a or 255)
			else
				return color_white
			end
		else
			return old_color(r, g, b, a)
		end
	end
end

function colorMeta:Copy()
	return Color(self.r, self.g, self.b, self.a)
end

function colorMeta:Unpack()
	return self.r, self.g, self.b, self.a
end

do
	local function normalize(min, max, val)
		local delta = max - min

		return (val - min) / delta
	end

	function ix.util.LerpColorHSV(start_color, end_color, maxValue, currentValue, minValue)
		start_color = Color("green")
		end_color = Color("red")

		minValue = minValue or 0

		local hsv_start = ColorToHSV(end_color)
		local hsv_end = ColorToHSV(start_color)

		local linear = Lerp(normalize(minValue, maxValue, currentValue), hsv_start, hsv_end)
		return HSVToColor(linear, 1, 1)
	end
end