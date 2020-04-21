defmodule Yatzy.Scoring.OnePair do
  @moduledoc """
  One Pair: Two dice showing the same number. Score: Sum of those two dice.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "One Pair",
    description: "Two dice showing the same number.",
    score: "Sum of those two dice."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll, 2)
  end
end
