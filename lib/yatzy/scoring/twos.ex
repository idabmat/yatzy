defmodule Yatzy.Scoring.Twos do
  @moduledoc """
  Twos: The sum of all dice showing the number 2.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Twos",
            description: "The sum of all dice showind the number 2."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}), do: Yatzy.Scoring.count(roll.dice, 2)
  end
end
