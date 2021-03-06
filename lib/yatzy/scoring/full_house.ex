defmodule Yatzy.Scoring.FullHouse do
  @moduledoc """
  Full House: Any set of three combined with a different pair. Score: Sum of all the dice.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Full House",
            description: "Any set of three combined with a different pair.",
            score: "Sum of all the dice."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}) do
      roll.dice
      |> Enum.sort()
      |> tally()
    end

    defp tally([die, die, die, die, die]), do: 0
    defp tally(dice = [d1, d1, d2, d2, d2]), do: Enum.sum(dice)
    defp tally(dice = [d1, d1, d1, d2, d2]), do: Enum.sum(dice)
    defp tally(_), do: 0
  end
end
