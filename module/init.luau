--!strict
-- LUAU MATH LIB
-- CORE Module

-- MADE BY Hawakiki(roblox name: OoPlutoO)

local Math = {}

local ln = math.log
local sqrt = math.sqrt
local abs = math.abs
local acos = math.acos
local asin = math.asin
local atan = math.atan
local atan2 = math.atan2
local pow = math.pow
local ceil = math.ceil
local band = bit32.band
local lshift = bit32.lshift
local cos = math.cos
local cosh = math.cosh
local exp = math.exp
local inf = math.huge
local floor = math.floor

function Math.abs(n: number): number
	return abs(n)
end

function Math.acos(n: number): number
	return acos(n)
end

function Math.acosh(n: number): number
	return ln(n + sqrt((n ^ 2) - 1))
end

function Math.asin(n: number): number
	return asin(n)
end

function Math.asinh(n: number): number
	return ln(n + sqrt((n ^ 2) + 1))
end

function Math.atan(n: number): number
	return atan(n)
end

function Math.atan2(y: number, x: number): number
	return atan2(y, x)
end

function Math.atanh(n: number): number
	return ((1 / 2) * ln((1 + n) / (1 - n)))
end

function Math.cbrt(n: number): number
	if n < 0 then
		return -pow(-n, 1 / 3)
	end
	return pow(n, 1 / 3)
end

function Math.ceil(n: number): number
	return ceil(n)
end

function Math.clz32(n: number): number
	n = band(n, 0xFFFFFFFF)
	if n == 0 then
		return 32
	end

	local count = 0

	if band(n, 0xFFFF0000) == 0 then
		count += 16
		n = lshift(n, 16)
	end
	if band(n, 0xFF000000) == 0 then
		count += 8
		n = lshift(n, 8)
	end
	if band(n, 0xF0000000) == 0 then
		count += 4
		n = lshift(n, 4)
	end
	if band(n, 0xC0000000) == 0 then
		count += 2
		n = lshift(n, 2)
	end
	if band(n, 0x80000000) == 0 then
		count += 1
	end

	return count
end

function Math.cos(n: number): number
	return cos(n)
end

function Math.cosh(n: number): number
	return cosh(n)
end

function Math.exp(n: number): number
	return exp(n)
end

function Math.expm1(n: number): number
	return (exp(n)) - 1
end

function Math.f16round(n: number): number
	local function f16round(x)
		if x ~= x then
			return x
		end

		if x == inf or x == -inf then
			return x
		end

		local sign = x < 0 and -1 or 1
		x = abs(x)

		if x == 0 then
			return 0
		end

		local exp = floor(ln(x, 2))
		local mant = x / (2 ^ exp)
		if exp > 15 then
			return sign * inf
		end

		if exp < -14 then
			return 0
		end

		local frac = mant - 1
		frac = floor(frac * 1024 + 0.5) / 1024

		return sign * (1 + frac) * (2 ^ exp)
	end

	return f16round(n)
end

function Math.floor(n: number): number
	return floor(n)
end

function Math.fround(n: number): number
	buffer.writef32(buffer.create(4), 0, n)
	return buffer.readf32(buffer.create(4), 0)
end

function Math.hypot(...: number): number
	local max = 0
	local sum = 0

	for index = 1, select("#", ...) do
		local value = abs(select(index, ...))

		if value == inf then
			return inf
		end

		if value ~= value then
			return value
		end

		if value > max then
			if max > 0 then
				local ratio = max / value
				sum = 1 + (sum * ratio * ratio)
			else
				sum = 1
			end

			max = value
		elseif value > 0 then
			local ratio = value / max
			sum += ratio * ratio
		end
	end

	return max * sqrt(sum)
end

return Math
