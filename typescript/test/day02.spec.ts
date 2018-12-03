import { part1, part2 } from "../src/solutions/day02";
import { expect } from "chai";
import "mocha";

describe("Day 2 Part 1", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = [
      "abcdef",
      "bababc",
      "abbcde",
      "abcccd",
      "aabcdd",
      "abcdee",
      "ababab"
    ];
    const result: number = part1(input);
    expect(result).to.equal(12);
  });
});

describe("Day 2 Part 2", () => {
  it("should give the correct result for an example input", () => {
    const input: ReadonlyArray<string> = [
      "abcde",
      "fghij",
      "klmno",
      "pqrst",
      "fguij",
      "axcye",
      "wvxyz"
    ];
    const result: string = part2(input);
    expect(result).to.equal("fgij");
  });
});
