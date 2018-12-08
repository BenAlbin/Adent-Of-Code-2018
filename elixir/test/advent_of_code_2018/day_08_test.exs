defmodule AdventOfCode2018.Day08Test do
  use ExUnit.Case

  import AdventOfCode2018.Day08

  test "Day 8 Part 1" do
    input = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

    assert part1(input) == 138
  end

  test "Day 8 Part 2" do
    input = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

    assert part2(input) == 66
  end
end
