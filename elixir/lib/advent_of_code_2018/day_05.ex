defmodule AdventOfCode2018.Day05 do
  def part1(input) do
    input
    |> String.trim()
    |> to_charlist()
    |> fully_react()
  end

  def fully_react(charlist) do
    {length, _} =
      Enum.reduce(charlist, {0, []}, fn
        letter, {length, [last_seen | rest]} when abs(last_seen - letter) == 32 ->
          {length - 1, rest}

        letter, {length, stack} ->
          {length + 1, [letter | stack]}
      end)

    length
  end

  def part2(input) do
    charlist =
      input
      |> String.trim()
      |> to_charlist()

    # :infinity is not a real thing in Elixir, but with term ordering:
    # number < atom. So this works and is clear.
    Enum.reduce(?a..?z, :infinity, fn letter, acc ->
      charlist
      |> Enum.filter(fn
        l when l == letter or abs(l - letter) == 32 -> false
        _ -> true
      end)
      |> fully_react()
      |> min(acc)
    end)
  end
end
