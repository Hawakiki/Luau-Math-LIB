--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local process = require("@lune/process")
local fs = require("@lune/fs")
local roblox = require("@lune/roblox")

print("Start Test")

-- TestEZ 로드
local TestEZ = require(game:GetService("ReplicatedStorage").LIB.Packages.testez)

-- 테스트 실행
local results = TestEZ.TestBootstrap:run({
    TestEZ,
    ServerScriptService.TEST
})

print(string.format("%d passed, %d failed", 
    results.passed, results.failed))

if results.failed > 0 then
    process.exit(1)
end