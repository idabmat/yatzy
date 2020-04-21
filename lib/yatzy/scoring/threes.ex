defmodule Yatzy.Scoring.Threes do
  @moduledoc """
  Threes: The sum of all dice showing the number 3.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Threes", description: "The sum of all dice showind the number 3."]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 3)
  end
end
