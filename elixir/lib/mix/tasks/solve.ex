defmodule Mix.Tasks.Solve do
  use Mix.Task

  @shortdoc "Solve advent of code puzzles"

  def run([day, part]) do
    part_func =
      case part do
        "1" -> :part1
        "2" -> :part2
      end

    {module, input} =
      if String.to_integer(day) < 10 do
        {String.to_existing_atom("Elixir.AdventOfCode2018.Day0#{day}"),
         File.read!("./lib/resources/day_0#{day}.txt")}
      else
        {String.to_existing_atom("Elixir.AdventOfCode2018.Day#{day}"),
         File.read!("./lib/resources/day_#{day}.txt")}
      end

    result =
      apply(
        module,
        part_func,
        [input]
      )

    IO.puts("Day #{day} Part #{part} Results: #{result}")
  end
end
