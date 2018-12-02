defmodule AdventOfCode2018.Day01 do
  @spec part1([number()]) :: number()
  def part1(args) do
    args
    |> Enum.reduce(0, &+/2)
  end

  @spec part2([number()]) :: number()
  def part2(args) do
    seen = MapSet.new([0])

    args
    |> Stream.cycle()
    |> Enum.reduce_while({0, seen}, &part2_reduce_fn/2)
  end

  defp part2_reduce_fn(value, {frequency, seen} = _accumulator) do
    new_frequency = frequency + value

    unless MapSet.member?(seen, new_frequency) do
      {:cont, {new_frequency, MapSet.put(seen, new_frequency)}}
    else
      {:halt, new_frequency}
    end
  end
end
