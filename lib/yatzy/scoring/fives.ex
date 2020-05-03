defmodule Yatzy.Scoring.Fives do
  @moduledoc """
  Fives: The sum of all dice showing the number 5.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Fives",
            description: "The sum of all dice showing the number 5."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll.dice, 5)
  end
end
