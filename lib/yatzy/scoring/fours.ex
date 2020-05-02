defmodule Yatzy.Scoring.Fours do
  @moduledoc """
  Fours: The sum of all dice showing the number 4.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Fours",
            description: "The sum of all dice showind the number 4."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll.dice, 4)
  end
end
