--!strict

return function(n: number): number
	if n < 0 then
		return -math.pow(-n, 1 / 3)
	end

	return math.pow(n, 1 / 3)
end
