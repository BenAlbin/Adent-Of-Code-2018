defmodule AdventOfCode2018.Day01 do
  @spec part1(String.t()) :: number()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(0, &+/2)
  end

  @spec part2(String.t()) :: number()
  def part2(input) do
    seen = MapSet.new([0])

    input
    |> String.split("\n", trim: true)
    |> Stream.map(&String.to_integer/1)
    |> Stream.cycle()
    |> Enum.reduce_while({0, seen}, &part2_reduce_fn/2)
  end

  defp part2_reduce_fn(value, {frequency, seen} = _accumulator) do
    new_frequency = frequency + value

    if MapSet.member?(seen, new_frequency) do
      {:halt, new_frequency}
    else
      {:cont, {new_frequency, MapSet.put(seen, new_frequency)}}
    end
  end
end
