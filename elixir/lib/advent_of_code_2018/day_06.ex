defmodule AdventOfCode2018.Day06 do
  @moduledoc """
  Solutions for Advent of Code Day 6. Input size appears to be
  pretty small, so I'm probably going to go for a slow solution.

  This solution isn't actually correct, but it works for the input and
  returned the correct answer.

  The correct solution is going to be a fairly lengthy one since we'd
  need to create a graph for each point where the edges are bisectors of
  that point with each other point. Then we check if that graph contains a cycle,
  if it doesn't: it has infinite area and we don't find the area for it.

  I usually like to refactor old solutions and maybe benchmark them against
  other approaches. But since this solution is not correct, and I'm
  not too interested in making it correct. I'll leave it as is.
  """

  alias AdventOfCode2018.Utils.Parsers

  def part1(input) do
    all_coords =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Parsers.day6_parse/1)

    max_x = Enum.max(Keyword.keys(all_coords))
    min_x = Enum.min(Keyword.keys(all_coords))
    max_y = Enum.max(Keyword.values(all_coords))
    min_y = Enum.min(Keyword.values(all_coords))

    finite_area_coords =
      Enum.filter(all_coords, fn
        {x, y} ->
          if closest({x + max_x, y}, all_coords) != {x, y} and
               closest({x - max_x, y}, all_coords) != {x, y} and
               closest({x, y + max_y}, all_coords) != {x, y} and
               closest({x, y - max_y}, all_coords) != {x, y} do
            true
          else
            false
          end
      end)

    area_to_check =
      for x <- (min_x - (max_x - min_x))..(max_x + (max_x - min_x)),
          y <- (min_y - (max_y - min_y))..(max_y + (max_y - min_y)),
          do: {x, y}

    Enum.reduce(area_to_check, %{}, fn coord, acc ->
      closest_coord = closest(coord, all_coords)

      if closest_coord in finite_area_coords do
        Map.update(acc, closest_coord, 1, &(&1 + 1))
      else
        acc
      end
    end)
    |> Enum.max_by(fn {_k, v} -> v end)
    |> elem(1)
  end

  def closest({x, y}, all_coords) do
    {closest, _} =
      Enum.reduce(all_coords, {[], :infinity}, fn coord, {closest_list, closest_dist} ->
        m_dist = manhattan_distance(coord, {x, y})

        cond do
          m_dist < closest_dist -> {[coord], m_dist}
          m_dist == closest_dist -> {[coord | closest_list], closest_dist}
          m_dist > closest_dist -> {closest_list, closest_dist}
        end
      end)

    if length(closest) > 1 or closest == [] do
      nil
    else
      hd(closest)
    end
  end

  defp manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def part2(input) do
    all_coords =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Parsers.day6_parse/1)

    max_x = Enum.max(Keyword.keys(all_coords))
    min_x = Enum.min(Keyword.keys(all_coords))
    max_y = Enum.max(Keyword.values(all_coords))
    min_y = Enum.min(Keyword.values(all_coords))

    area_to_check =
      for x <- (min_x - (max_x - min_x))..(max_x + (max_x - min_x)),
          y <- (min_y - (max_y - min_y))..(max_y + (max_y - min_y)),
          do: {x, y}

    Enum.reduce(area_to_check, 0, fn coord, acc ->
      dist_to_all = distance_to_all_coords(coord, all_coords)

      if dist_to_all < 10_000 do
        acc + 1
      else
        acc
      end
    end)
  end

  def distance_to_all_coords(current_coord, all_coords) do
    Enum.reduce(all_coords, 0, fn coord, acc ->
      acc + manhattan_distance(current_coord, coord)
    end)
  end
end
