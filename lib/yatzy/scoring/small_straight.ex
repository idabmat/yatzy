defmodule Yatzy.Scoring.SmallStraight do
  @moduledoc """
  Small Straight: The combination 1-2-3-4-5. Score: 15 points (sum of all the dice).
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Small Straight",
            description: "The combination 1-2-3-4-5.",
            score: "15 points (sum of all the dice)."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}) do
      roll.dice
      |> Enum.sort()
      |> tally()
    end

    defp tally([1, 2, 3, 4, 5]), do: 15
    defp tally(_), do: 0
  end
end
