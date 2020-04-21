defmodule Yatzy.Scoring.Yatzy do
  @moduledoc """
  Yatzy: All five dice with the same number. Score: 50 points.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "Yatzy",
    description: "All five dice with the same number.",
    score: "50 points."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: tally(roll)

    defp tally([die, die, die, die, die]), do: 50
    defp tally(_), do: 0
  end
end
