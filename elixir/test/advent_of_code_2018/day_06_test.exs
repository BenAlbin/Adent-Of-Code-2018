defmodule AdventOfCode2018.Day06Test do
  use ExUnit.Case

  import AdventOfCode2018.Day06

  test "Day 6 Part 1" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert part1(input) == 17
  end

  @tag :skip
  test "part2" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert part2(input) == 16
  end
end
