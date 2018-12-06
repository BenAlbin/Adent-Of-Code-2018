defmodule AdventOfCode2018.Day02Test do
  use ExUnit.Case

  import AdventOfCode2018.Day02

  test "Day 2  Part 1" do
    input = """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    assert part1(input) === 12
  end

  test "Day 2  Part 2" do
    input = """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """

    assert part2(input) === "fgij"
  end
end
