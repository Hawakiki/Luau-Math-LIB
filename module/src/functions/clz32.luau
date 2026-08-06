--!strict

local band = bit32.band
local lshift = bit32.lshift

return function(n: number): number
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
