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

  use TypedStruct

  typedstruct do
    field :counter, integer(), default: 0
    field :dice, [integer()], default: []
  end

  @type options :: [
          random: fun(),
          reroll: [integer()]
        ]

  @doc """
  Rolls the dice
  """
  @spec execute(roll :: t(), opts :: options()) :: t()
  def execute(roll, opts \\ []) do
    counter = roll.counter
    dice = roll.dice
    random = Keyword.get(opts, :random, &:rand.uniform/1)
    reroll = Keyword.get(opts, :reroll, @dice_indexes)

    cond do
      !valid?(reroll) ->
        %__MODULE__{dice: dice, counter: counter}

      limit_reached?(counter) ->
        %__MODULE__{dice: dice, counter: counter}

      true ->
        new_dice = rerolled(dice, reroll, random) |> Enum.sort()
        %__MODULE__{dice: new_dice, counter: counter + 1}
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
