-- Runs the TestEZ specs without Studio, so CI can run them on Linux.
-- Loads the place Rojo built and executes its ModuleScripts with a
-- Roblox-style require (script/game/require come from the place tree).
--
--   rojo build dev.project.json --output build/Luau_MathLIB.rbxlx
--   lune run test [place file]

local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")
local roblox = require("@lune/roblox")

local placePath = process.args[1] or "build/Luau_MathLIB.rbxlx"
if not fs.isFile(placePath) then
	print(`place file not found: {placePath} (run rojo build first)`)
	process.exit(1)
end

local game = roblox.deserializePlace(fs.readFile(placePath))

-- Roblox APIs that TestEZ or the library touch but Lune does not provide.
-- TextReporter reports errors through TestService:Error.
roblox.implementMethod("TestService", "Error", function(_, message)
	print(message)
end)

-- math.random backed; enough for tests, not a faithful Random.
local Random = {}
function Random.new(seed: number?)
	if seed ~= nil then
		math.randomseed(seed)
	end
	return {
		NextNumber = function(_, min: number?, max: number?): number
			local low, high = min or 0, max or 1
			return low + math.random() * (high - low)
		end,
		NextInteger = function(_, min: number, max: number): number
			return math.random(min, max)
		end,
	}
end

local loaded = {}
local loading = {}

local function requireModule(module)
	if typeof(module) ~= "Instance" or not module:IsA("ModuleScript") then
		error(`require expects a ModuleScript, got {typeof(module)}`, 2)
	end

	local cached = loaded[module]
	if cached then
		return cached.value
	end

	local name = module:GetFullName()
	if loading[module] then
		error(`Requested module was required recursively: {name}`, 2)
	end

	local chunk = luau.load(module.Source, {
		debugName = name,
		environment = {
			game = game,
			script = module,
			require = requireModule,
			tick = os.clock,
			Random = Random,
		},
	})

	loading[module] = true
	local results = table.pack(pcall(chunk))
	loading[module] = nil

	if not results[1] then
		error(results[2], 0)
	end
	if results.n ~= 2 then
		error(`Module code did not return exactly one value: {name}`, 2)
	end

	loaded[module] = { value = results[2] }
	return results[2]
end

local TestEZ = requireModule(game.ReplicatedStorage.DevPackages.Testez)
local results = TestEZ.TestBootstrap:run({ game.ServerScriptService.TEST }, TestEZ.Reporters.TextReporter)

-- Zero tests means the specs were not found, which must not pass silently.
if results.successCount + results.failureCount == 0 then
	print("no tests ran")
	process.exit(1)
end
if results.failureCount > 0 or #results.errors > 0 then
	process.exit(1)
end
