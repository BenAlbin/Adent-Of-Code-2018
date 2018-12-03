defmodule AdventOfCode2018.Day02 do
  @spec part1(String.t()) :: number
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{two: 0, three: 0}, &add_to_count/2)
    |> (fn %{two: two_count, three: three_count} -> two_count * three_count end).()
  end

  defp add_to_count(line, %{two: two_count, three: three_count} = _count) do
    line_list = String.graphemes(line)
    twos_and_threes = line_list -- Enum.uniq(line_list)
    threes_only = twos_and_threes -- Enum.uniq(twos_and_threes)
    threes_raw = length(threes_only)
    twos_raw = length(Enum.uniq(twos_and_threes)) - threes_raw
    %{two: oneify(twos_raw) + two_count, three: oneify(threes_raw) + three_count}
  end

  defp oneify(x) when x > 0, do: 1
  defp oneify(_), do: 0

  @spec part2(String.t()) :: String.t()
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> check_rest()
  end

  defp check_rest([current_line | rest]) do
    rest
    |> Enum.map(&String.myers_difference(&1, current_line))
    |> Enum.find(&correct?/1)
    |> case do
      nil -> check_rest(rest)
      x -> equal_parts(x)
    end
  end

  defp equal_parts(myers_diff) do
    myers_diff
    |> Keyword.get_values(:eq)
    |> List.to_string()
  end

  defp correct?(myers_diff) do
    myers_diff
    |> Keyword.get_values(:del)
    |> List.to_string()
    |> (&(String.length(&1) === 1)).()
  end
end
