defmodule Yatzy.Scoring.FourOfAKind do
  @moduledoc """
  Four of a Kind: Four dice with the same number. Score: Sum of those four dice.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Four of a Kind",
            description: "Four dice with the same number.",
            score: "Sum of those four dice."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll.dice, 4)
  end
end
