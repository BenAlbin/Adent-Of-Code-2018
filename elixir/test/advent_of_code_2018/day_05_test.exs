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

  alias AdventOfCode2018.Day05Alt, as: Alt

  test "part1alt" do
    input = "dabAcCaCBAcCcaDA"

    assert Alt.part1(input) == 10
  end

  test "part2alt" do
    input = "dabAcCaCBAcCcaDA"

    assert Alt.part2(input) == 4
  end
end
