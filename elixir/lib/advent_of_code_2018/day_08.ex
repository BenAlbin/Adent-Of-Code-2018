defmodule AdventOfCode2018.Day08 do
  def part1(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> read_node(0, [])
  end

  def read_node([], metadata_sum, _) do
    metadata_sum
  end

  def read_node(
        list,
        metadata_sum,
        [
          {0, metadata_number},
          {next_parent_child_number, next_parent_metadata_number} | rest_of_parents
        ]
      ) do
    {metadata, rest} = Enum.split(list, metadata_number)

    read_node(rest, metadata_sum + Enum.sum(metadata), [
      {next_parent_child_number - 1, next_parent_metadata_number} | rest_of_parents
    ])
  end

  def read_node(
        list,
        metadata_sum,
        [
          {0, metadata_number}
        ]
      ) do
    {metadata, rest} = Enum.split(list, metadata_number)

    read_node(rest, metadata_sum + Enum.sum(metadata), [])
  end

  def read_node(
        [0, number_metadata | rest],
        metadata_sum,
        [
          {parent_child_number, parent_metadata_number} | rest_of_parents
        ]
      ) do
    {metadata, rest} = Enum.split(rest, number_metadata)

    read_node(rest, metadata_sum + Enum.sum(metadata), [
      {parent_child_number - 1, parent_metadata_number} | rest_of_parents
    ])
  end

  def read_node([child_number, metadata_number | rest], metadata_sum, list_of_parents) do
    read_node(rest, metadata_sum, [{child_number, metadata_number} | list_of_parents])
  end

  def part2(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> create_map(0, [])
  end

  def create_map([], total_sum, []) do
    total_sum
  end

  # Do this when the last parent has reached the end of its children
  def create_map(
        metadata_and_rest,
        total_sum,
        [
          {
            0,
            metadata_number,
            children_sums
          }
        ]
      ) do
    {metadata, rest} = Enum.split(metadata_and_rest, metadata_number)

    children_sums = Enum.reverse(children_sums)

    children_metadata_sums =
      metadata
      |> Enum.reduce(0, fn index, acc ->
        acc + Enum.at(children_sums, index - 1, 0)
      end)

    create_map(rest, total_sum + children_metadata_sums, [])
  end

  # Do this when a parent has reached the end of its children
  def create_map(
        metadata_and_rest,
        total_sum,
        [
          {0, finished_parent_metadata_number, finished_parent_children},
          {parent_parent_child_number, parent_parent_metadata_number, parent_parent_children}
          | rest_of_parents
        ]
      ) do
    {metadata, rest} = Enum.split(metadata_and_rest, finished_parent_metadata_number)

    finished_parent_children = Enum.reverse(finished_parent_children)

    children_metadata_sum =
      metadata
      |> Enum.reduce(0, fn index, acc ->
        acc + Enum.at(finished_parent_children, index - 1, 0)
      end)

    create_map(rest, total_sum, [
      {parent_parent_child_number - 1, parent_parent_metadata_number,
       [children_metadata_sum | parent_parent_children]}
      | rest_of_parents
    ])
  end

  ## this is a leaf node
  def create_map(
        [0, metadata_number | metadata_and_rest],
        total_sum,
        [
          {parent_child_number, parent_metadata_number, parent_children} | rest_of_parent_stack
        ]
      ) do
    {metadata, rest} = Enum.split(metadata_and_rest, metadata_number)

    update_parent =
      {parent_child_number - 1, parent_metadata_number, [Enum.sum(metadata) | parent_children]}

    create_map(rest, total_sum, [update_parent | rest_of_parent_stack])
  end

  def create_map([children_number, metadata_number | rest], total_sum, parent_stack) do
    create_map(rest, total_sum, [{children_number, metadata_number, []} | parent_stack])
  end
end
