defmodule AdventOfCode2018.Day03 do
  defmodule Claim do
    defstruct [:id, :x_pos, :y_pos, :width, :height]

    @type t :: %__MODULE__{
            id: pos_integer,
            x_pos: pos_integer,
            y_pos: pos_integer,
            width: pos_integer,
            height: pos_integer
          }

    @doc """
    Returns a new Claim struct from an ordered list of arguments, or a map with string
    keys.

    ## Examples

      iex> AdventOfCode2018.Day03.Claim.new(%{
      ...>   "id" => "1",
      ...>   "x_pos" => "2",
      ...>   "y_pos" => "3",
      ...>   "width" => "4",
      ...>   "height" => "5"
      ...> })
      %AdventOfCode2018.Day03.Claim{id: 1, x_pos: 2, y_pos: 3, width: 4, height: 5}

      iex> AdventOfCode2018.Day03.Claim.new([1, 2, 3, 4, 5])
      %AdventOfCode2018.Day03.Claim{id: 1, x_pos: 2, y_pos: 3, width: 4, height: 5}
    """
    @spec new(
            %{optional(String.t()) => String.t() | pos_integer()}
            | [String.t() | pos_integer(), ...]
          ) :: AdventOfCode2018.Day03.Claim.t()
    def new(args) when is_map(args) do
      %__MODULE__{
        id: intify(args["id"]),
        x_pos: intify(args["x_pos"]),
        y_pos: intify(args["y_pos"]),
        width: intify(args["width"]),
        height: intify(args["height"])
      }
    end

    def new(args) when is_list(args) do
      [id, x_pos, y_pos, width, height] = args

      %__MODULE__{
        id: intify(id),
        x_pos: intify(x_pos),
        y_pos: intify(y_pos),
        width: intify(width),
        height: intify(height)
      }
    end

    @spec fetch(term :: Access.t(), Access.key()) :: {:ok, Access.value()} | :error
    def fetch(term, key) do
      Map.fetch(term, key)
    end

    defp intify(x) when is_binary(x), do: String.to_integer(x)
    defp intify(x) when is_integer(x), do: x
    defp intify(_), do: raise("WTF")
  end

  alias __MODULE__.Claim

  @type coordinate :: {pos_integer(), pos_integer()}

  @doc """
  Returns the solution to the Advent of Code Day 3 Part 1 puzzle.

  ## Examples

    iex> part1(\"""
    ...> #1 @ 1,3: 4x4
    ...> #2 @ 3,1: 4x4
    ...> #3 @ 5,5: 2x2
    ...> \""")
    4
  """
  @spec part1(String.t()) :: pos_integer()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_claim_named_capture/1)
    |> Enum.reduce(%{}, &fill_map/2)
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  @doc """
  Returns a list of tuples containing the id and coordinates that the claim wants
  to fill.

  ## Examples

    iex> to_fill(%AdventOfCode2018.Day03.Claim{id: 5, x_pos: 1, y_pos: 1, width: 2, height: 2})
    [{5, {1, 1}}, {5, {1, 2}}, {5, {2, 1}}, {5, {2, 2}}]
  """
  @spec to_fill(Claim.t()) :: [{integer, {integer, integer}}]
  def to_fill(%Claim{id: id, x_pos: x_pos, y_pos: y_pos, width: width, height: height} = _claim) do
    for x <- x_pos..(x_pos + width - 1),
        y <- y_pos..(y_pos + height - 1),
        do: {id, {x, y}}
  end

  @doc """
  Updates the map (accumulator) with the coordinates in the claim. Accumulator has
  coordinates as the key, and this function will update the value to add 1 to the counter
  for those coordinates.

  ## Examples

    iex> fill_map(
    ...> %AdventOfCode2018.Day03.Claim{id: 5, x_pos: 1, y_pos: 1, width: 2, height: 2},
    ...> %{{1, 1} => 1})
    %{{1, 1} => 2, {1, 2} => 1, {2, 1} => 1, {2, 2} => 1}
  """
  @spec fill_map(Claim.t(), %{optional(coordinate) => pos_integer()}) :: %{
          optional(coordinate) => pos_integer()
        }
  def fill_map(claim, accumulator) do
    claim
    |> to_fill()
    |> Enum.reduce(accumulator, fn {_id, coords}, acc -> Map.update(acc, coords, 1, &(&1 + 1)) end)
  end

  @doc """
  Returns a claim struct containing the information provided by the claim string.

  ## Examples

    iex> parse_claim("#1 @ 1,3: 4x4")
    %AdventOfCode2018.Day03.Claim{id: 1, x_pos: 1, y_pos: 3, width: 4, height: 4}
  """
  @deprecated "Use parse_claim_named_capture/1 instead"
  @spec parse_claim(String.t()) :: Claim.t()
  def parse_claim(claim_string) do
    claim_string
    |> String.split(~r/[^0-9]/, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Claim.new()
  end

  @doc """
  Returns a claim struct containing the information provided by the claim string.

  ## Examples

    iex> parse_claim_named_capture("#1 @ 1,3: 4x4")
    %AdventOfCode2018.Day03.Claim{id: 1, x_pos: 1, y_pos: 3, width: 4, height: 4}
  """
  @spec parse_claim_named_capture(String.t()) :: Claim.t()
  def parse_claim_named_capture(claim) do
    parsed =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<x_pos>\d+),(?<y_pos>\d+): (?<width>\d+)x(?<height>\d+)/,
        claim
      )

    Claim.new(parsed)
  end

  @doc """
  Returns the solution to the Advent of Code Day 3 Part 1 puzzle.

  ## Examples
    iex> part2(\"""
    ...> #1 @ 1,3: 4x4
    ...> #2 @ 3,1: 4x4
    ...> #3 @ 5,5: 2x2
    ...> \""")
    3
  """
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

  @doc """
  Updates the map (accumulator) with the coordinates in the claim. Accumulator has
  coordinates as the key, and this function will update the value to add 1 to the counter
  for those coordinates.

  ## Examples

    iex> fill_map_with_id(
    ...> %AdventOfCode2018.Day03.Claim{id: 5, x_pos: 1, y_pos: 1, width: 2, height: 2},
    ...> %{{1, 1} => [4]})
    %{{1, 1} => [5, 4], {1, 2} => [5], {2, 1} => [5], {2, 2} => [5]}
  """
  @spec fill_map_with_id(Claim.t(), %{optional(coordinate) => [pos_integer()]}) :: %{
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
