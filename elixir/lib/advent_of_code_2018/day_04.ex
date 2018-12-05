defmodule AdventOfCode2018.Day04 do
  import AdventOfCode2018.Utils.{EnumHelpers, ParseHelpers}

  def part1(input) do
    {id, minute, _} =
      input
      |> String.split("\n", trim: true)
      |> Enum.sort()
      |> Enum.map(&parse_record_pattern/1)
      |> record_into_map(%{}, nil)
      |> Enum.max_by(fn {_k, v} -> count_ranges(v) end)
      |> most_frequent

    id * minute
  end

  def parse_record_pattern(string) do
    <<
      "[",
      date::binary-size(10),
      " ",
      hour::binary-size(2),
      ":",
      minute::binary-size(2),
      "] ",
      action::binary
    >> = string

    %{
      date: Date.from_iso8601!(date),
      hour: intify(hour),
      minute: intify(minute),
      action: parse_action(action)
    }
  end

  defp parse_action("Guard #" <> string) do
    [id] = Regex.run(~r/\d+/, string)
    {:guard, intify(id)}
  end

  defp parse_action("wakes up") do
    :wake_up
  end

  defp parse_action("falls asleep") do
    :sleep
  end

  def most_frequent({id, ranges}) do
    {minute, count} =
      ranges
      |> Enum.flat_map(& &1)
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
      |> Enum.max_by(fn {_k, v} -> v end, fn -> {nil, 0} end)

    {id, minute, count}
  end

  def record_into_map([], acc, _), do: acc

  def record_into_map([%{action: {:guard, id}} | rest], acc, _) do
    record_into_map(rest, Map.put_new(acc, id, []), id)
  end

  def record_into_map(
        [%{action: :sleep, minute: sleep}, %{action: :wake_up, minute: wake_up} | rest],
        %{} = acc,
        current_id
      ) do
    record_into_map(rest, Map.update!(acc, current_id, &[sleep..(wake_up - 1) | &1]), current_id)
  end

  def part2(input) do
    {id, minute, _count} =
      input
      |> String.split("\n", trim: true)
      |> Enum.sort()
      |> Enum.map(&parse_record_pattern/1)
      |> record_into_map(%{}, nil)
      |> Enum.map(&most_frequent/1)
      |> Enum.max_by(fn {_id, _minute, count} -> count end)

    id * minute
  end
end
