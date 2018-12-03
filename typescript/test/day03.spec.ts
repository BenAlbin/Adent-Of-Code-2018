import { part1, part2 } from "../src/solutions/day03";
import { expect } from "chai";
import "mocha";

describe("Day 1 Part 1", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ];
    const result: number = part1(input);
    expect(result).to.equal(4);
  });
});

describe("Day 1 Part 2", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ];
    const result: number = part2(input);
    expect(result).to.equal(3);
  });
});
