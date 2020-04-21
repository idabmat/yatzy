defmodule Yatzy.Scoring.Twos do
  @moduledoc """
  Twos: The sum of all dice showing the number 2.
  """

  @enforce_keys [:roll]
  defstruct [:roll, name: "Twos", description: "The sum of all dice showind the number 2."]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll, 2)
  end
end
