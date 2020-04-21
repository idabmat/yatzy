defmodule Yatzy.Scoring.ThreeOfAKind do
  @moduledoc """
  Three of a Kind: Three dice showing the same number. Score: Sum of those three dice.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "Three of a Kind",
    description: "Three dice showing the same number.",
    score: "Sum of those three dice."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll, 3)
  end
end