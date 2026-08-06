--!strict

return function(n: number): number
	if n < 0 then
		return math.ceil(n)
	end

	return math.floor(n)
end
