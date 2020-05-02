defmodule Yatzy.Scoring.Ones do
  @moduledoc """
  Ones: The sum of all dice showing the number 1.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Ones",
            description: "The sum of all dice showind the number 1."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll.dice, 1)
  end
end
