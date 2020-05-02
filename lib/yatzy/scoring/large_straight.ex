defmodule Yatzy.Scoring.LargeStraight do
  @moduledoc """
  Large Straight: The combination 2-3-4-5-6. Score: 20 points (sum of all the dice).
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Large Straight",
            description: "The combination 2-3-4-5-6.",
            score: "20 points (sum of all the dice)."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}) do
      roll.dice
      |> Enum.sort()
      |> tally()
    end

    defp tally([2, 3, 4, 5, 6]), do: 20
    defp tally(_), do: 0
  end
end
