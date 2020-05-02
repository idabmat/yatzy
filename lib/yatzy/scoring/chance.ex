defmodule Yatzy.Scoring.Chance do
  @moduledoc """
  Chance: Any combination of dice. Score: Sum of all the dice.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Chance",
            description: "Any combination of dice.",
            score: "Sum of all the dice."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Enum.sum(roll.dice)
  end
end
