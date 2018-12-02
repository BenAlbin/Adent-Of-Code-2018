defmodule AdventOfCode2018.Day01Test do
  use ExUnit.Case

  import AdventOfCode2018.Day01

  describe("Day 1 - Part 1") do
    test "with input +1, +1, +1 results in 3" do
      input = """
      +1
      +1
      +1
      """

      assert part1(input) === 3
    end

    test "with input +1, +1, -2 results in 0" do
      input = """
      +1
      +1
      -2
      """

      assert part1(input) === 0
    end

    test "with input -1, -2, -3 results in -6" do
      input = """
      -1
      -2
      -3
      """

      assert part1(input) === -6
    end
  end

  describe "Day 1 - Part 2" do
    test "with input +1, -1 first reaches 0 twice" do
      input = """
      +1
      -1
      """

      assert part2(input) === 0
    end

    test "with input +3, +3, +4, -2, -4 first reaches 10 twice" do
      input = """
      +3
      +3
      +4
      -2
      -4
      """

      assert part2(input) === 10
    end

    test "with input -6, +3, +8, +5, -6 first reaches 5 twice" do
      input = """
      -6
      +3
      +8
      +5
      -6
      """

      assert part2(input) === 5
    end

    test "with input +7, +7, -2, -7, -4 first reaches 14 twice" do
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
end
