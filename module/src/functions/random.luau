--!strict

local generator = Random.new()

return function(): number
	return generator:NextNumber()
end
