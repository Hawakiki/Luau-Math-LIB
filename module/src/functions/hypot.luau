--!strict

return function(...: number): number
	local values = { ... }
	local max = 0

	for _, value in ipairs(values) do
		local magnitude = math.abs(value)
		if magnitude == math.huge then
			return math.huge
		end
		if magnitude ~= magnitude then
			return magnitude
		end
		if magnitude > max then
			max = magnitude
		end
	end

	if max == 0 then
		return 0
	end

	local sum = 0
	for _, value in ipairs(values) do
		local scaled = value / max
		sum += scaled * scaled
	end

	return max * math.sqrt(sum)
end
