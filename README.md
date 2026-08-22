# Luau Math LIB

Luau Math LIB is a Roblox/Luau utility package that mirrors JavaScript-style `Math` APIs while staying easy to consume from Roblox Studio projects. The library exposes constants, wrappers around Luau's native `math` functions, and helper functions such as `cbrt`, `clz32`, `fround`, `hypot`, `imul`, `sign`, and `trunc`.

## Features

- Modular source layout: every function lives in its own ModuleScript under `module/src/functions`.
- Shared type surface in `module/src/Types.luau` for strict Luau projects.
- JavaScript-inspired constants: `E`, `LN2`, `LN10`, `LOG2E`, `LOG10E`, `PI`, `SQRT1_2`, and `SQRT2`.
- Works with Rojo projects and Wally package workflows.

## Installation

### Option 1: Install with Wally

Add the package to your `wally.toml` dependencies:

```toml
[dependencies]
LuauMathLib = "hawakiki/luau-mathlib@0.1.0"
```

Then install packages:

```bash
wally install
```

Require the package from the generated `Packages` folder in your Roblox code.

### Option 2: Use this repository with Rojo

Install the project tools listed in `rokit.toml` if you use Rokit:

```bash
rokit install
```

Build the Roblox place file:

```bash
rojo build -o "Luau_MathLIB.rbxlx"
```

Or start a live Rojo server:

```bash
rojo serve
```

Open the project in Roblox Studio and connect Rojo. The library is mounted at `ReplicatedStorage.LIB` by `dev.project.json`.

## Usage Tutorial

### 1. Require the library

From a Script, LocalScript, or ModuleScript that can access `ReplicatedStorage`:

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Math = require(ReplicatedStorage.LIB)
```

### 2. Use constants

```luau
print(Math.PI) -- 3.14159...
print(Math.SQRT2) -- square root of 2
```

### 3. Use direct math wrappers

```luau
local angle = Math.atan2(10, 5)
local root = Math.sqrt(144)
local power = Math.pow(2, 8)

print(angle, root, power)
```

### 4. Use helper functions missing from Luau's base `math` table

```luau
local distance = Math.hypot(3, 4, 12) -- 13
local cubeRoot = Math.cbrt(-27) -- -3
local direction = Math.sign(-100) -- -1
local whole = Math.trunc(-12.75) -- -12

print(distance, cubeRoot, direction, whole)
```

### 5. Use strict Luau types

```luau
local Math = require(game.ReplicatedStorage.LIB)

type MathLibrary = typeof(Math)

local function calculate(lib: MathLibrary, value: number): number
	return lib.round(lib.sqrt(value))
end

print(calculate(Math, 10))
```

## API Reference

### Constants

- `Math.E`
- `Math.LN2`
- `Math.LN10`
- `Math.LOG2E`
- `Math.LOG10E`
- `Math.PI`
- `Math.SQRT1_2`
- `Math.SQRT2`

### Functions

- `Math.abs(n)`
- `Math.acos(n)`
- `Math.acosh(n)`
- `Math.asin(n)`
- `Math.asinh(n)`
- `Math.atan(n)`
- `Math.atan2(y, x)`
- `Math.atanh(n)`
- `Math.cbrt(n)`
- `Math.ceil(n)`
- `Math.clz32(n)`
- `Math.cos(n)`
- `Math.cosh(n)`
- `Math.exp(n)`
- `Math.expm1(n)`
- `Math.f16round(n)`
- `Math.floor(n)`
- `Math.fround(n)`
- `Math.hypot(...numbers)`
- `Math.imul(left, right)`
- `Math.log(n)`
- `Math.log10(n)`
- `Math.log1p(n)`
- `Math.log2(n)`
- `Math.max(...numbers)`
- `Math.min(...numbers)`
- `Math.pow(base, exponent)`
- `Math.random()`
- `Math.round(n)`
- `Math.sign(n)`
- `Math.sin(n)`
- `Math.sinh(n)`
- `Math.sqrt(n)`
- `Math.tan(n)`
- `Math.tanh(n)`
- `Math.trunc(n)`

## Running Tests

This project includes TestEZ specs in `test/init.spec.luau`. Run them from Roblox Studio or your preferred Roblox test runner after syncing the project with Rojo.

## Project Layout

```text
module/
  init.luau              # public API aggregator
  src/
    Types.luau           # exported strict Luau type surface
    constants.luau       # math constants
    functions/           # one ModuleScript per function
test/
  init.spec.luau         # TestEZ coverage
```

## License

This project is available under the license in `LICENSE`.
