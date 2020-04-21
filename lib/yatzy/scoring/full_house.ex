defmodule Yatzy.Scoring.FullHouse do
  @moduledoc """
  Full House: Any set of three combined with a different pair. Score: Sum of all the dice.
  """

  @enforce_keys [:roll]
  defstruct [
    :roll,
    name: "Full House",
    description: "Any set of three combined with a different pair.",
    score: "Sum of all the dice."
  ]

  defimpl Yatzy.Score do
    def execute(%{roll: roll}) do
      roll
      |> Enum.sort()
      |> tally()
    end

    defp tally([die, die, die, die, die]), do: 0
    defp tally(roll = [d1, d1, d2, d2, d2]), do: Enum.sum(roll)
    defp tally(roll = [d1, d1, d1, d2, d2]), do: Enum.sum(roll)
    defp tally(_), do: 0
  end
end
