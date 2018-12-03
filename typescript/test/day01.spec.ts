import { part1, part2 } from "../src/solutions/day01";
import { expect } from "chai";
import "mocha";

describe("Day 1 Part 1", () => {
  it("should give the correct result for an example input", () => {
    const input = ["+1", "+1", "-2"];
    const result = part1(input);
    expect(result).to.equal(0);
  });
});
