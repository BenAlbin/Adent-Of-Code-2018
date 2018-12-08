defmodule AdventOfCode2018.Utils.Parsers do
  import NimbleParsec

  claim =
    ignore(string("#"))
    |> integer(min: 1)
    |> ignore(string(" @ "))
    |> integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)
    |> ignore(string(": "))
    |> integer(min: 1)
    |> ignore(string("x"))
    |> integer(min: 1)

  defparsec :claim, claim

  # start_shift =
  #   ignore(string("Guard #"))
  #   |> integer(min: 1)
  #   |> ignore(string(" begins shift."))

  # record =
  #   ignore(string("["))
  #   |> integer(4)
  #   |> ignore(string("-"))
  #   |> integer(2)
  #   |> ignore(string("-"))
  #   |> integer(2)
  #   |> ignore(string(" "))
  #   |> integer(2)
  #   |> ignore(string(":"))
  #   |> integer(2)
  #   |> ignore(string("]"))
  #   |> choice([

  #   ])
  #   |> ignore(string("Guard #"))
  #   |> integer(min: 1)
  #   |> ignore(string(" begins shift."))

  defparsec :coord,
            unwrap_and_tag(integer(min: 1), :x)
            |> ignore(string(", "))
            |> unwrap_and_tag(integer(min: 1), :y)

  def day6_parse(line) do
    {:ok, [x: x, y: y], "", _, _, _} = coord(line)
    {x, y}
  end
end
