--!strict

return function(left: number, right: number): number
	local leftLow = bit32.band(left, 0xFFFF)
	local leftHigh = bit32.band(bit32.rshift(left, 16), 0xFFFF)
	local rightLow = bit32.band(right, 0xFFFF)
	local rightHigh = bit32.band(bit32.rshift(right, 16), 0xFFFF)
	local high = bit32.band((leftHigh * rightLow) + (leftLow * rightHigh), 0xFFFF)
	local unsigned = bit32.band((leftLow * rightLow) + bit32.lshift(high, 16), 0xFFFFFFFF)

	if unsigned >= 0x80000000 then
		return unsigned - 0x100000000
	end

	return unsigned
end
