defmodule AdventOfCode2018.Day05Test do
  use ExUnit.Case

  import AdventOfCode2018.Day05

  test "part1" do
    input = "dabAcCaCBAcCcaDA"

    assert part1(input) == 10
  end

  test "part2" do
    input = "dabAcCaCBAcCcaDA"

    assert part2(input) == 4
  end
end
