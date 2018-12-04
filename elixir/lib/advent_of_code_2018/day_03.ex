defmodule AdventOfCode2018.Day03 do
  import AdventOfCode2018.Utils.{ParseHelpers, EnumHelpers}

  @type coordinate :: {pos_integer(), pos_integer()}

  @type claim :: %{
          id: non_neg_integer(),
          x_pos: non_neg_integer(),
          y_pos: non_neg_integer(),
          width: non_neg_integer(),
          height: non_neg_integer()
        }

  @spec part1(String.t()) :: pos_integer()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_claim_named_capture/1)
    |> Enum.reduce(%{}, &fill_map/2)
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  @spec to_fill(claim()) :: [{integer, {integer, integer}}]
  def to_fill(%{id: id, x_pos: x_pos, y_pos: y_pos, width: width, height: height} = _claim) do
    for x <- x_pos..(x_pos + width - 1),
        y <- y_pos..(y_pos + height - 1),
        do: {id, {x, y}}
  end

  @spec fill_map(claim(), %{optional(coordinate) => pos_integer()}) :: %{
          optional(coordinate) => pos_integer()
        }
  def fill_map(claim, accumulator) do
    claim
    |> to_fill()
    |> Enum.reduce(accumulator, fn {_id, coords}, acc -> Map.update(acc, coords, 1, &(&1 + 1)) end)
  end

  @deprecated "Use parse_claim_named_capture/1 instead"
  @spec parse_claim(String.t()) :: claim()
  def parse_claim(claim_string) do
    claim_string
    |> String.split(~r/[^0-9]/, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> to_atom_keys(id: :int, x_pos: :int, y_pos: :int, width: :int, height: :int)
  end

  @spec parse_claim_named_capture(String.t()) :: claim()
  def parse_claim_named_capture(claim) do
    parsed =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<x_pos>\d+),(?<y_pos>\d+): (?<width>\d+)x(?<height>\d+)/,
        claim
      )

    to_atom_keys(parsed, id: :int, x_pos: :int, y_pos: :int, width: :int, height: :int)
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

  @spec fill_map_with_id(claim(), %{optional(coordinate) => [pos_integer()]}) :: %{
          optional(coordinate) => [pos_integer()]
        }
  def fill_map_with_id(claim, map) do
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
