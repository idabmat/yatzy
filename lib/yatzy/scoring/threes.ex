defmodule Yatzy.Scoring.Threes do
  @moduledoc """
  Threes: The sum of all dice showing the number 3.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Threes",
            description: "The sum of all dice showind the number 3."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll.dice, 3)
  end
end
