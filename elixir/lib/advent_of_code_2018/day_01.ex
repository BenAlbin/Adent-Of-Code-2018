defmodule AdventOfCode2018.Day01 do
  def part1(args) do
    args
    |> Enum.reduce(0, fn val, acc -> acc + String.to_integer(val) end)
  end

  def part2(args) do
    seen = MapSet.new([0])

    args
    |> Stream.cycle()
    |> Enum.reduce_while({0, seen}, &part2_reduce_fn(&1, &2))
  end

  def part2_reduce_fn(value, {frequency, seen} = _accumulator) do
    new_frequency = frequency + String.to_integer(value)

    unless MapSet.member?(seen, new_frequency) do
      {:cont, {new_frequency, MapSet.put(seen, new_frequency)}}
    else
      {:halt, new_frequency}
    end
  end
end