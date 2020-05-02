defmodule Yatzy.Scoring.ThreeOfAKind do
  @moduledoc """
  Three of a Kind: Three dice showing the same number. Score: Sum of those three dice.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Three of a Kind",
            description: "Three dice showing the same number.",
            score: "Sum of those three dice."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.chunk_by(roll.dice, 3)
  end
end
