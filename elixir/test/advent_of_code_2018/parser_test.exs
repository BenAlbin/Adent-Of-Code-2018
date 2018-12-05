defmodule AdventOfCode2018.Utils.ParsersTest do
  use ExUnit.Case

  import AdventOfCode2018.Utils.Parsers

  test "parses claim correctly from day 3" do
    input = "#5 @ 739,983: 28x10"

    assert {:ok, [5, 739, 983, 28, 10], "", %{}, _, _} = claim(input)
  end
end
