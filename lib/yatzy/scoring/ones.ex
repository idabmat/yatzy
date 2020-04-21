defmodule Yatzy.Scoring.Ones do
  @moduledoc """
  Ones: The sum of all dice showing the number 1.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Ones", description: "The sum of all dice showind the number 1."]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 1)
  end
end
