defmodule Yatzy.Scoring.Fives do
  @moduledoc """
  Fives: The sum of all dice showing the number 5.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Fives", description: "The sum of all dice showind the number 5."]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 5)
  end
end
