local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- The name is the alias key in wally.toml [dev-dependencies], not the package name.
local TestEZ = require(ReplicatedStorage.DevPackages.Testez)

local results = TestEZ.TestBootstrap:run({ script.Parent }, TestEZ.Reporters.TextReporter)

if results.failureCount > 0 or #results.errors > 0 then
	error(`TestEZ: {results.failureCount} failure(s), {#results.errors} error(s)`)
end
