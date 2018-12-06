defmodule AdventOfCode2018.Day01Test do
  use ExUnit.Case

  import AdventOfCode2018.Day01

  test "Day 1 Part 1" do
    input = """
    +1
    +1
    -2
    """

    assert part1(input) === 0
  end

  test "Day 1 Part 2" do
    input = """
    +7
    +7
    -2
    -7
    -4
    """

    assert part2(input) === 14
  end
end
