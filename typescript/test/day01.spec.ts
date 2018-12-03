import { part1, part2 } from "../src/solutions/day01";
import { expect } from "chai";
import "mocha";

describe("Day 1 Part 1", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = ["+1", "+1", "-2"];
    const result: number = part1(input);
    expect(result).to.equal(0);
  });
});

describe("Day 1 Part 2", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = ["-6", "+3", "+8", "+5", "-6"];
    const result: number = part2(input);
    expect(result).to.equal(5);
  });
});
