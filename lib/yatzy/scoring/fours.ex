defmodule Yatzy.Scoring.Fours do
  @moduledoc """
  Fours: The sum of all dice showing the number 4.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Fours", description: "The sum of all dice showind the number 4."]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 4)
  end
end
