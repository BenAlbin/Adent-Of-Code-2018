defmodule AdventOfCode2018.Utils.ParseHelpers do
  def intify(value)

  def intify(value) when is_integer(value), do: value

  def intify(value) when is_binary(value) do
    {int, _} = Integer.parse(value)
    int
  end

  def intify(_value), do: raise("WTF")

  @doc """
  Converts either a list of items or a map into a map with atom keys given by the
  second argument, along with types.
  """
  @spec to_atom_keys(map() | list(), list() | keyword(atom())) :: %{
          optional(atom()) => term()
        }
  def to_atom_keys(items, keys_list) when is_map(items) do
    Enum.into(keys_list, %{}, fn {key, type} ->
      {key, into_type(items[Atom.to_string(key)], type)}
    end)
  end

  def to_atom_keys(items, keys_list) when is_list(items) do
    Enum.zip(items, keys_list)
    |> Enum.into(%{}, fn {item, {key, type}} -> {key, into_type(item, type)} end)
  end

  @doc """
  Converts the given item into the type specified by the atom, defaults to string.

  ## Examples

    iex> into_type("1", :int)
    1
    iex> into_type(1, :string)
    "1"
  """
  def into_type(item, type \\ :none)

  def into_type(item, :none), do: item

  def into_type(item, :int), do: intify(item)

  def into_type(item, :date), do: Date.from_iso8601!(item)

  def into_type(item, :string) when is_binary(item), do: item
  def into_type(item, :string), do: inspect(item)
end
