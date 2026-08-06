--!strict
-- LUAU MATH LIB
-- CORE Module
-- MADE BY Hawakiki(roblox name: OoPlutoO)

local Types = require(script.src.Types)
local constants = require(script.src.constants)

type MathLibrary = Types.MathLibrary

local Math = table.clone(constants) :: MathLibrary

Math.abs = require(script.src.functions.abs)
Math.acos = require(script.src.functions.acos)
Math.acosh = require(script.src.functions.acosh)
Math.asin = require(script.src.functions.asin)
Math.asinh = require(script.src.functions.asinh)
Math.atan = require(script.src.functions.atan)
Math.atan2 = require(script.src.functions.atan2)
Math.atanh = require(script.src.functions.atanh)
Math.cbrt = require(script.src.functions.cbrt)
Math.ceil = require(script.src.functions.ceil)
Math.clz32 = require(script.src.functions.clz32)
Math.cos = require(script.src.functions.cos)
Math.cosh = require(script.src.functions.cosh)
Math.exp = require(script.src.functions.exp)
Math.expm1 = require(script.src.functions.expm1)
Math.f16round = require(script.src.functions.f16round)
Math.floor = require(script.src.functions.floor)
Math.fround = require(script.src.functions.fround)
Math.hypot = require(script.src.functions.hypot)
Math.imul = require(script.src.functions.imul)
Math.log = require(script.src.functions.log)
Math.log10 = require(script.src.functions.log10)
Math.log1p = require(script.src.functions.log1p)
Math.log2 = require(script.src.functions.log2)
Math.max = require(script.src.functions.max)
Math.min = require(script.src.functions.min)
Math.pow = require(script.src.functions.pow)
Math.random = require(script.src.functions.random)
Math.round = require(script.src.functions.round)
Math.sign = require(script.src.functions.sign)
Math.sin = require(script.src.functions.sin)
Math.sinh = require(script.src.functions.sinh)
Math.sqrt = require(script.src.functions.sqrt)
Math.tan = require(script.src.functions.tan)
Math.tanh = require(script.src.functions.tanh)
Math.trunc = require(script.src.functions.trunc)

return Math
