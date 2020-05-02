defmodule Yatzy.Scoring.OnePair do
  @moduledoc """
  One Pair: Two dice showing the same number. Score: Sum of those two dice.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "One Pair",
            description: "Two dice showing the same number.",
            score: "Sum of those two dice."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll.dice, 2)
  end
end
