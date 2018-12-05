defmodule AdventOfCode2018.Utils.EnumHelpers do
  @doc """
  Returns the sum from a list of ranges.

  ## Examples

    iex> sum_ranges([1..2, 5..7])
    21
  """
  @spec sum_ranges([Range.t()]) :: number()
  def sum_ranges(list) do
    list
    |> Enum.flat_map(& &1)
    |> Enum.sum()
  end

  @spec count_ranges([Range.t()]) :: number()
  def count_ranges(list) do
    list
    |> Enum.reduce(0, &(Enum.count(&1) + &2))
  end

  @doc """
  Returns the most common (mode) item of a list along with the count of how often that
  item appears.

  Raises Enum.EmptyError when given an empty list.

  ## Examples

    iex> most_common([1, 1, 1, 2, 2, 3])
    {1, 3}
  """
  @spec most_common([term()]) :: {term(), non_neg_integer()}
  def most_common(list) do
    list
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    |> Enum.max_by(fn {_k, v} -> v end, fn -> {nil, 0} end)
  end
end
