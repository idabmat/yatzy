defmodule Yatzy.Sheet do
  alias Yatzy.Scoring.Score

  @moduledoc """
  Operations on a sheets used to keep track of player's
  score
  """

  @upper_section [:ones, :twos, :threes, :fours, :fives, :sixes]
  @lower_section [
    :one_pair,
    :two_pairs,
    :three_of_a_kind,
    :four_of_a_kind,
    :small_straight,
    :large_straight,
    :chance,
    :yatzy
  ]
  @upper_section_bonus_limit 63
  @upper_section_bonus_value 50

  use TypedStruct

  typedstruct do
    field :ones, struct(), default: %Yatzy.Scoring.Ones{roll: []}
    field :twos, struct(), default: %Yatzy.Scoring.Twos{roll: []}
    field :threes, struct(), default: %Yatzy.Scoring.Threes{roll: []}
    field :fours, struct(), default: %Yatzy.Scoring.Fours{roll: []}
    field :fives, struct(), default: %Yatzy.Scoring.Fives{roll: []}
    field :sixes, struct(), default: %Yatzy.Scoring.Sixes{roll: []}
    field :one_pair, struct(), default: %Yatzy.Scoring.OnePair{roll: []}
    field :two_pair, struct(), default: %Yatzy.Scoring.TwoPairs{roll: []}
    field :three_of_a_kind, struct(), default: %Yatzy.Scoring.ThreeOfAKind{roll: []}
    field :four_of_a_kind, struct(), default: %Yatzy.Scoring.FourOfAKind{roll: []}
    field :small_straight, struct(), default: %Yatzy.Scoring.SmallStraight{roll: []}
    field :large_straight, struct(), default: %Yatzy.Scoring.LargeStraight{roll: []}
    field :chance, struct(), default: %Yatzy.Scoring.Chance{roll: []}
    field :yatzy, struct(), default: %Yatzy.Scoring.Yatzy{roll: []}
  end

  @doc """
  Calculate the total score for a given sheet

  ## Examples

      iex> Yatzy.Sheet.total(%Yatzy.Sheet{})
      0

  """
  @spec total(sheet :: t()) :: integer()
  def total(sheet = %__MODULE__{}) do
    upper_section = section_total(sheet, @upper_section)
    upper_bonus = upper_section_bonus(upper_section)
    lower_section = section_total(sheet, @lower_section)

    upper_section + upper_bonus + lower_section
  end

  @doc """
  Update the score sheet with a roll under a rule.


  ## Example

      iex> Yatzy.Sheet.record(%Yatzy.Sheet{}, [1, 1, 1, 1, 1], :ones) |> Yatzy.Sheet.total()
      5

  """
  @spec record(sheet :: t(), roll :: [integer()], rule :: atom()) :: t()
  def record(sheet, roll, rule) do
    if valid_rule(sheet, rule) do
      Map.update!(sheet, rule, fn score -> update_roll(score, roll) end)
    else
      sheet
    end
  end

  defp update_roll(score = %{roll: []}, roll), do: %{score | roll: roll}
  defp update_roll(score, _), do: score

  defp valid_rule(sheet, rule) do
    sheet |> Map.from_struct() |> Map.keys() |> Enum.member?(rule)
  end

  defp section_total(sheet = %__MODULE__{}, fields) do
    sheet
    |> Map.take(fields)
    |> Map.values()
    |> Enum.map(&Score.execute/1)
    |> Enum.sum()
  end

  defp upper_section_bonus(total) when total >= @upper_section_bonus_limit,
    do: @upper_section_bonus_value

  defp upper_section_bonus(_total), do: 0
end
