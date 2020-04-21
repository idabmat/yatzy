defmodule Yatzy.Scoring.Chance do
  @moduledoc """
  Chance: Any combination of dice. Score: Sum of all the dice.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "Chance",
    description: "Any combination of dice.",
    score: "Sum of all the dice."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Enum.sum(roll)
  end
end
