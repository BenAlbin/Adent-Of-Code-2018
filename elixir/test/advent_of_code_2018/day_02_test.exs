defmodule AdventOfCode2018.Day02Test do
  use ExUnit.Case

  import AdventOfCode2018.Day02

  describe("Day 2 - Part 1") do
    test "with provided input results in 12" do
      input = [
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ]

      assert part1(input) === 12
    end
  end

  describe("Day 2 - Part 2") do
    test "with provided input results in fgij" do
      input = [
        "abcde",
        "fghij",
        "klmno",
        "pqrst",
        "fguij",
        "axcye",
        "wvxyz"
      ]

      assert part2(input) === "fgij"
    end
  end
end
