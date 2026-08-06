#!/usr/bin/env python3
"""Repository-level checks for the Luau Math LIB project."""

from __future__ import annotations

import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
FUNCTIONS_DIR = ROOT / "module" / "src" / "functions"
INIT_FILE = ROOT / "module" / "init.luau"
TYPES_FILE = ROOT / "module" / "src" / "Types.luau"
TEST_FILE = ROOT / "test" / "init.spec.luau"
TEST_RUNNER_FILE = ROOT / "test" / "runner.server.luau"
PROJECT_FILE = ROOT / "default.project.json"
WALLY_FILE = ROOT / "wally.toml"

EXPECTED_FUNCTIONS = {
    "abs",
    "acos",
    "acosh",
    "asin",
    "asinh",
    "atan",
    "atan2",
    "atanh",
    "cbrt",
    "ceil",
    "clz32",
    "cos",
    "cosh",
    "exp",
    "expm1",
    "f16round",
    "floor",
    "fround",
    "hypot",
    "imul",
    "log",
    "log10",
    "log1p",
    "log2",
    "max",
    "min",
    "pow",
    "random",
    "round",
    "sign",
    "sin",
    "sinh",
    "sqrt",
    "tan",
    "tanh",
    "trunc",
}


def fail(message: str) -> None:
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)


def read(path: Path) -> str:
    if not path.exists():
        fail(f"missing required file: {path.relative_to(ROOT)}")
    return path.read_text()


def check_project_mapping() -> None:
    project = json.loads(read(PROJECT_FILE))
    replicated_storage = project["tree"]["ReplicatedStorage"]
    if replicated_storage["LIB"]["$path"] != "module":
        fail("ReplicatedStorage.LIB must point to module")
    if replicated_storage["Packages"]["$path"] != "Packages":
        fail("ReplicatedStorage.Packages must point to Wally's Packages folder")
    if project["tree"]["ServerScriptService"]["TEST"]["$path"] != "test":
        fail("ServerScriptService.TEST must point to test")


def check_function_modules() -> None:
    init = read(INIT_FILE)
    types = read(TYPES_FILE)
    existing = {path.stem for path in FUNCTIONS_DIR.glob("*.luau")}

    missing_files = EXPECTED_FUNCTIONS - existing
    extra_files = existing - EXPECTED_FUNCTIONS
    if missing_files:
        fail(f"missing function modules: {sorted(missing_files)}")
    if extra_files:
        fail(f"unexpected function modules: {sorted(extra_files)}")

    for name in sorted(EXPECTED_FUNCTIONS):
        module_path = FUNCTIONS_DIR / f"{name}.luau"
        source = read(module_path)
        if not source.startswith("--!strict"):
            fail(f"{module_path.relative_to(ROOT)} must start with --!strict")
        if f"Math.{name} = require(script.src.functions.{name})" not in init:
            fail(f"module/init.luau does not require {name}")
        if f"\t{name}:" not in types:
            fail(f"Types.luau does not expose {name}")


def check_tests_and_dependencies() -> None:
    tests = read(TEST_FILE)
    runner = read(TEST_RUNNER_FILE)
    wally = read(WALLY_FILE)

    if "testez = \"roblox/testez@0.4.1\"" not in wally:
        fail("wally.toml must include the TestEZ dependency")
    if "Packages.testez" not in runner:
        fail("test runner must require Wally's TestEZ package")
    if "TestBootstrap:run" not in runner:
        fail("test runner must execute TestEZ")
    if "failureCount" not in runner:
        fail("test runner must fail when TestEZ reports failures")
    for expected in ("Math.f16round", "Math.hypot", "Math.imul"):
        if expected not in tests:
            fail(f"test suite should cover {expected}")


def main() -> None:
    check_project_mapping()
    check_function_modules()
    check_tests_and_dependencies()
    print("project structure checks passed")


if __name__ == "__main__":
    main()
