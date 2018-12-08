defmodule AdventOfCode2018.Day06 do
  @moduledoc """
  Solutions for Advent of Code Day 6. Input size appears to be
  pretty small, so I'm probably going to go for a slow solution.

  Turns out there is a simpler way to find infinite area nodes. Maybe this is
  still incorrect, but it's better at least.
  """

  alias AdventOfCode2018.Utils.Parsers

  def part1(input) do
    all_coords =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Parsers.day6_parse/1)

    {min_x, max_x} = Enum.min_max(Keyword.keys(all_coords))
    {min_y, max_y} = Enum.min_max(Keyword.values(all_coords))

    y_border = for x <- min_x..max_x, do: [{x, min_y}, {x, max_y}]
    x_border = for y <- min_y..max_y, do: [{min_x, y}, {max_x, y}]

    border = List.flatten(x_border ++ y_border)

    closest_to_border =
      Enum.reduce(border, MapSet.new(), fn {x, y}, acc ->
        case closest({x, y}, all_coords) do
          nil -> acc
          closest_coord -> MapSet.put(acc, closest_coord)
        end
      end)

    finite_area_coords =
      Enum.filter(all_coords, fn coord -> !MapSet.member?(closest_to_border, coord) end)

    area_to_check =
      for x <- min_x..max_x,
          y <- min_y..max_y,
          do: {x, y}

    area_to_check
    |> Enum.reduce(%{}, fn coord, acc ->
      closest_coord = closest(coord, all_coords)

      if closest_coord in finite_area_coords do
        Map.update(acc, closest_coord, 1, &(&1 + 1))
      else
        acc
      end
    end)
    |> Enum.max_by(fn {_k, v} -> v end, fn -> {nil, 0} end)
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

  def part2(input, max_dist \\ 10_000) do
    all_coords =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Parsers.day6_parse/1)

    max_x = Enum.max(Keyword.keys(all_coords))
    min_x = Enum.min(Keyword.keys(all_coords))
    max_y = Enum.max(Keyword.values(all_coords))
    min_y = Enum.min(Keyword.values(all_coords))

    area_to_check =
      for x <- min_x..max_x,
          y <- min_y..max_y,
          do: {x, y}

    Enum.reduce(area_to_check, 0, fn coord, acc ->
      dist_to_all = distance_to_all_coords(coord, all_coords)

      if dist_to_all < max_dist do
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
