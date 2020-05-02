defmodule Yatzy.Scoring.TwoPairs do
  @moduledoc """
  Two Pairs: Two different pairs of dice. Score: Sum of dice in those two pairs.
  """

  alias Yatzy.Roll

  defstruct roll: %Roll{},
            name: "Two Pairs",
            description: "Two different pairs of dice.",
            score: "Sum of dice in those two pairs."

  defimpl Yatzy.Scoring.Score do
    def execute(%{roll: roll}) do
      roll.dice
      |> Enum.sort()
      |> Stream.chunk_every(2, 1, :discard)
      |> Stream.filter(&is_a_pair/1)
      |> Stream.uniq()
      |> Enum.map(&Enum.sum/1)
      |> tally()
    end

    defp is_a_pair([die, die]), do: true
    defp is_a_pair(_), do: false

    defp tally([one, two]), do: one + two
    defp tally(_pairs), do: 0
  end
end
