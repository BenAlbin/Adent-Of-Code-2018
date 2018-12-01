defmodule Mix.Tasks.D01.P1 do
  use Mix.Task

  import AdventOfCode2018.Day01

  @shortdoc "Day 01 Part 1"
  def run(_) do
    input =
      File.read!("./lib/resources/day_01.txt")
      |> String.split(~r/\R/)
      |> Enum.map(&String.to_integer/1)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
