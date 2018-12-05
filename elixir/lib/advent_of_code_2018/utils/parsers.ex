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

  start_shift =
    ignore(string("Guard #"))
    |> integer(min: 1)
    |> ignore(string(" begins shift."))

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
end
