defmodule Yatzy.Scoring.Sixes do
  @moduledoc """
  Sixes: The sum of all dice showing the number 6.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Sixes", description: "The sum of all dice showind the number 6."]

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 6)
  end
end
