defmodule Yatzy.Roll do
  @moduledoc """
  - Generating new rolls
  - Rerolling all dice
  - Rerolling some dice
  - Enforcing game rules around re-rolls
  """

  @dice_count 5
  @dice_indexes 1..@dice_count
  @die_faces 6
  @max_rolls 3

  @type t :: %{
          counter: integer(),
          dice: [integer()]
        }

  @type args :: [
          counter: integer(),
          dice: [integer()],
          random: fun(),
          reroll: [integer()]
        ]

  @doc """
  Rolls the dice
  """

  @spec roll(opts :: args()) :: t()
  def roll(opts \\ []) do
    counter = Keyword.get(opts, :counter, 0)
    dice = Keyword.get(opts, :dice, [])
    random = Keyword.get(opts, :random, &:rand.uniform/1)
    reroll = Keyword.get(opts, :reroll, @dice_indexes)

    cond do
      !valid?(reroll) ->
        %{dice: dice, counter: counter}

      limit_reached?(counter) ->
        %{dice: dice, counter: counter}

      true ->
        new_dice = rerolled(dice, reroll, random) |> Enum.sort()
        %{dice: new_dice, counter: counter + 1}
    end
  end

  @spec valid?(reroll :: [integer()]) :: boolean()
  defp valid?(reroll), do: Enum.all?(reroll, &Enum.member?(@dice_indexes, &1))

  @spec valid?(counter :: integer()) :: boolean()
  defp limit_reached?(counter), do: counter >= @max_rolls

  @spec rerolled(dice :: [integer()], reroll :: [integer()], random :: fun()) :: [integer()]
  defp rerolled(dice, reroll, random) do
    for pos <- 1..@dice_count do
      rerollable = reroll?(reroll, pos)
      reroll(pos, dice, random, rerollable)
    end
  end

  @spec reroll?(reroll :: [integer()], pos :: integer()) :: boolean()
  defp reroll?(reroll, pos), do: Enum.member?(reroll, pos)

  @spec reroll(pos :: integer(), dice :: [integer()], random :: fun(), rerollable :: boolean()) ::
          integer()
  defp reroll(pos, dice, _random, false), do: Enum.at(dice, pos - 1)
  defp reroll(_pos, _dice, random, _rerollable), do: random.(@die_faces)
end
