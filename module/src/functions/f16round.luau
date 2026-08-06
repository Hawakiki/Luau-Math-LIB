--!strict

local inf = math.huge
local maxHalfFloat = 65504
local minNormal = 2 ^ -14
local minSubnormal = 2 ^ -24

return function(n: number): number
	if n ~= n or n == inf or n == -inf then
		return n
	end

	local sign = if n < 0 then -1 else 1
	local x = math.abs(n)
	if x == 0 then
		return 0
	end

	if x > maxHalfFloat then
		return sign * inf
	end

	if x < minNormal then
		return sign * math.floor((x / minSubnormal) + 0.5) * minSubnormal
	end

	local exponent = math.floor(math.log(x, 2))
	local mantissa = x / (2 ^ exponent)
	local fraction = math.floor((mantissa - 1) * 1024 + 0.5) / 1024
	local rounded = sign * (1 + fraction) * (2 ^ exponent)

	if math.abs(rounded) > maxHalfFloat then
		return sign * inf
	end

	return rounded
end
