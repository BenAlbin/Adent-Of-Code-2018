defmodule AdventOfCode2018.Day03 do
  @spec part1(String.t()) :: non_neg_integer()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_claim_named_capture/1)
    |> Enum.reduce(%{}, &fill_map/2)
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  defp to_fill(%{id: id, x_pos: x_pos, y_pos: y_pos, width: width, height: height} = _claim) do
    for x <- x_pos..(x_pos + width - 1),
        y <- y_pos..(y_pos + height - 1),
        do: {id, {x, y}}
  end

  defp fill_map(claim, accumulator) do
    claim
    |> to_fill()
    |> Enum.reduce(accumulator, fn {_id, coords}, acc -> Map.update(acc, coords, 1, &(&1 + 1)) end)
  end

  def parse_claim(claim) do
    claim_as_list =
      claim
      |> String.split(~r/[^0-9]/, trim: true)
      |> Enum.map(&String.to_integer/1)

    [id, x_pos, y_pos, width, height] = claim_as_list

    %{
      id: id,
      x_pos: x_pos,
      y_pos: y_pos,
      width: width,
      height: height
    }
  end

  def parse_claim_named_capture(claim) do
    parsed =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<x_pos>\d+),(?<y_pos>\d+): (?<width>\d+)x(?<height>\d+)/,
        claim
      )

    %{
      id: String.to_integer(parsed["id"]),
      x_pos: String.to_integer(parsed["x_pos"]),
      y_pos: String.to_integer(parsed["y_pos"]),
      width: String.to_integer(parsed["width"]),
      height: String.to_integer(parsed["height"])
    }
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    claims =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_claim_named_capture/1)

    all = fn :get, data, next -> Enum.map(data, next) end
    all_ids = get_in(claims, [all, :id])

    seen_ids =
      claims
      |> Enum.reduce(%{}, &fill_map_with_id/2)
      |> Map.values()
      |> Enum.filter(&(length(&1) > 1))
      |> List.flatten()

    hd(all_ids -- seen_ids)
  end

  defp fill_map_with_id(claim, map) do
    claim
    |> to_fill()
    |> Enum.reduce(map, fn {id, coords}, acc ->
      Map.update(
        acc,
        coords,
        [id],
        &[id | &1]
      )
    end)
  end
end
