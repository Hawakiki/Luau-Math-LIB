return function()
	local Math = require(game.ReplicatedStorage.LIB)

	describe("Math.abs", function()
		it("returns positive value", function()
			expect(Math.abs(-5)).to.equal(5)
			expect(Math.abs(5)).to.equal(5)
		end)
	end)

	describe("Math.acos", function()
		it("matches math.acos", function()
			expect(Math.acos(1)).to.equal(math.acos(1))
		end)
	end)

	describe("Math.acosh", function()
		it("returns valid result for n >= 1", function()
			local n = 2
			local expected = math.log(n + math.sqrt(n ^ 2 - 1))
			expect(Math.acosh(n)).to.be.close(expected, 1e-6)
		end)
	end)

	describe("Math.asin", function()
		it("matches math.asin", function()
			expect(Math.asin(0.5)).to.equal(math.asin(0.5))
		end)
	end)

	describe("Math.asinh", function()
		it("computes correct value", function()
			local n = 2
			local expected = math.log(n + math.sqrt(n ^ 2 + 1))
			expect(Math.asinh(n)).to.be.close(expected, 1e-6)
		end)
	end)

	describe("Math.atan", function()
		it("matches math.atan", function()
			expect(Math.atan(1)).to.equal(math.atan(1))
		end)
	end)

	describe("Math.atan2", function()
		it("matches math.atan2", function()
			expect(Math.atan2(1, 1)).to.equal(math.atan2(1, 1))
		end)
	end)

	describe("Math.atanh", function()
		it("computes correct value", function()
			local n = 0.5
			local expected = 0.5 * math.log((1 + n) / (1 - n))
			expect(Math.atanh(n)).to.be.close(expected, 1e-6)
		end)
	end)

	describe("Math.cbrt", function()
		it("handles positive numbers", function()
			expect(Math.cbrt(27)).to.be.close(3, 1e-6)
		end)

		it("handles negative numbers", function()
			expect(Math.cbrt(-27)).to.be.close(-3, 1e-6)
		end)

		it("matches math.pow behavior", function()
			local n = 8
			expect(Math.cbrt(n)).to.be.close(math.pow(n, 1 / 3), 1e-6)
		end)
	end)
end
