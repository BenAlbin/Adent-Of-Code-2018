defmodule AdventOfCode2018.Day05 do
  def part1(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> fully_react()
  end

  def fully_react(string_graphemes) do
    {length, _} =
      Enum.reduce(string_graphemes, {0, []}, fn
        letter, {length, [last_seen | rest]} ->
          cond do
            String.downcase(letter) == String.downcase(last_seen) and letter != last_seen ->
              {length - 1, rest}

            true ->
              {length + 1, [letter | [last_seen | rest]]}
          end

        letter, {length, []} ->
          {length + 1, [letter]}
      end)

    length
  end

  def part2(input) do
    input = String.trim(input)
    input_graphemes = String.graphemes(input)
    to_check = for l <- ?a..?z, do: <<l::utf8>>

    # :infinity is not a real thing in Elixir, but with term ordering:
    # number < atom. So this works and is clear.
    Enum.reduce(to_check, :infinity, fn letter, acc ->
      input_graphemes
      |> Enum.filter(fn l -> String.downcase(l) != letter end)
      |> fully_react()
      |> min(acc)
    end)
  end
end
