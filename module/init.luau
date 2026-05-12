--!strict
-- LUAU MATH LIB
-- CORE Module

-- MADE BY Hawakiki(roblox name is OoPlutoO)

local Math = {}

local ln = math.log
local sqrt = math.sqrt

function Math.abs(n: number): number
	return math.abs(n)
end

function Math.acos(n: number): number
	return math.acos(n)
end

function Math.acosh(n: number): number
	return ln(n + sqrt((n ^ 2) - 1))
end

function Math.asin(n: number): number
	return math.asin(n)
end

function Math.asinh(n: number): number
	return ln(n + sqrt((n ^ 2) + 1))
end

function Math.atan(n: number): number
	return math.atan(n)
end

function Math.atan2(y: number, x: number): number
	return math.atan2(y, x)
end

function Math.atanh(n: number): number
	return ((1 / 2) * ln((1 + n) / (1 - n)))
end

function Math.cbrt(n: number): number
	if n < 0 then
		return -math.pow(-n, 1 / 3)
	end
	return math.pow(n, 1 / 3)
end

return Math
