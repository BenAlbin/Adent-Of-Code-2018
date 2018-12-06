defmodule AdventOfCode2018.Day05Test do
  use ExUnit.Case

  import AdventOfCode2018.Day05

  test "Day 5 Part 1" do
    input = "dabAcCaCBAcCcaDA"

    assert part1(input) == 10
  end

  test "Day 5 Part 2" do
    input = "dabAcCaCBAcCcaDA"

    assert part2(input) == 4
  end
end
