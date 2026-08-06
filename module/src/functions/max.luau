--!strict

return function(...: number): number
	local values = { ... }
	if #values == 0 then
		return -math.huge
	end

	local result = -math.huge
	for _, value in ipairs(values) do
		if value ~= value then
			return value
		end
		result = math.max(result, value)
	end

	return result
end
