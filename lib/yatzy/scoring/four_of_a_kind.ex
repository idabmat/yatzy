defmodule Yatzy.Scoring.FourOfAKind do
  @moduledoc """
  Four of a Kind: Four dice with the same number. Score: Sum of those four dice.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "Four of a Kind",
    description: "Four dice with the same number.",
    score: "Sum of those four dice."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll, 4)
  end
end
