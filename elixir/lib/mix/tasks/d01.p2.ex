defmodule Mix.Tasks.D01.P2 do
  use Mix.Task

  import AdventOfCode2018.Day01

  @shortdoc "Day 01 Part 2"
  def run(_) do
    input =
      File.read!("./lib/resources/day_01.txt")
      |> String.split("\r\n")

    input
    |> part2()
    |> IO.inspect(label: "Part 2 Results")
  end
end
