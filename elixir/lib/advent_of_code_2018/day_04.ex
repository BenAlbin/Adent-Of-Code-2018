defmodule AdventOfCode2018.Day04 do
  def part1(input) do
    {id, minute, _} =
      input
      |> String.split("\n", trim: true)
      |> Enum.sort()
      |> Enum.map(&parse_record_pattern/1)
      |> Enum.reduce({%{}, [], []}, &stack_and_map/2)
      |> elem(0)
      |> Enum.max_by(fn {_k, v} -> sum_ranges(v.asleep) end)
      |> find_most_asleep_minute()

    id * minute
  end

  defp find_most_asleep_minute({id, %{asleep: list_of_ranges}}) do
    {minute, list} =
      list_of_ranges
      |> Enum.flat_map(& &1)
      |> Enum.group_by(& &1)
      |> Enum.max_by(fn {_k, v} -> length(v) end, fn -> {0, []} end)

    {id, minute, length(list)}
  end

  defp sum_ranges(list_of_ranges) do
    list_of_ranges
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  def parse_record_regex(string) do
    string
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

  defp intify(x) when is_binary(x), do: String.to_integer(x)
  defp intify(x) when is_integer(x), do: x
  defp intify(_), do: raise("WTF")

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

  def stack_and_map(%{action: {:guard, id}}, {map, awake_stack, asleep_stack}) do
    {Map.put_new(map, id, %{slept: nil, asleep: []}), [id | awake_stack], asleep_stack}
  end

  def stack_and_map(
        %{action: :sleep, minute: minute} = _record,
        {map, [current_id | awake_stack], asleep_stack}
      ) do
    {put_in(map, [current_id, :slept], minute), awake_stack, [current_id | asleep_stack]}
  end

  def stack_and_map(
        %{action: :wake_up, minute: minute} = _record,
        {map, awake_stack, [current_id | asleep_stack]}
      ) do
    went_to_sleep = get_in(map, [current_id, :slept])

    {update_in(map, [current_id, :asleep], &[went_to_sleep..(minute - 1) | &1]),
     [current_id | awake_stack], asleep_stack}
  end

  def part2(input) do
    {id, minute, _count} =
      input
      |> String.split("\n", trim: true)
      |> Enum.sort()
      |> Enum.map(&parse_record_pattern/1)
      |> Enum.reduce({%{}, [], []}, &stack_and_map/2)
      |> elem(0)
      |> Enum.map(&find_most_asleep_minute/1)
      |> Enum.max_by(fn {_id, _minute, count} -> count end)

    id * minute
  end
end
