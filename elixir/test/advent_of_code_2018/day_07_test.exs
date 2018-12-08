defmodule AdventOfCode2018.Day07Test do
  use ExUnit.Case

  import AdventOfCode2018.Day07

  test "Day 7 Part 1" do
    input = """
    Step C must be finished before step A can begin.
    Step C must be finished before step F can begin.
    Step A must be finished before step B can begin.
    Step A must be finished before step D can begin.
    Step B must be finished before step E can begin.
    Step D must be finished before step E can begin.
    Step F must be finished before step E can begin.
    """

    assert part1(input) == "CABDFE"
  end

  test "Day 7 Part 2" do
    input = """
    Step C must be finished before step A can begin.
    Step C must be finished before step F can begin.
    Step A must be finished before step B can begin.
    Step A must be finished before step D can begin.
    Step B must be finished before step E can begin.
    Step D must be finished before step E can begin.
    Step F must be finished before step E can begin.
    """

    assert part2(input, 2, 0) == 15
  end
end
