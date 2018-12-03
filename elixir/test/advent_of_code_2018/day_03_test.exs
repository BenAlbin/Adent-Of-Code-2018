defmodule AdventOfCode2018.Day03Test do
  use ExUnit.Case

  import AdventOfCode2018.Day03

  describe "part1" do
    test "solves the example input" do
      input = """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """

      assert part1(input) === 4
    end

    test "parse_claim/1" do
      assert parse_claim("#1 @ 1,3: 4x4") == %{id: 1, x_pos: 1, y_pos: 3, width: 4, height: 4}
    end

    test "parse_claim_named_capture/1" do
      assert parse_claim_named_capture("#1 @ 1,3: 4x4") == %{
               id: 1,
               x_pos: 1,
               y_pos: 3,
               width: 4,
               height: 4
             }
    end
  end

  test "part2" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

    assert part2(input) === 3
  end
end
