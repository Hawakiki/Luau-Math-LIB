--!strict

return function(n: number): number
	local bytes = buffer.create(4)
	buffer.writef32(bytes, 0, n)
	return buffer.readf32(bytes, 0)
end
