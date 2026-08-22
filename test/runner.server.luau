local TestEZ = require(game.ReplicatedStorage.DevPackages.testez)

local results = TestEZ.TestBootstrap:run({ script.Parent }, TestEZ.Reporters.TextReporter)

if results.failureCount > 0 then
	error(`{results.failureCount} TestEZ test(s) failed`)
end
