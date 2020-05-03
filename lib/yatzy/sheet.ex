defmodule Yatzy.Sheet do
  alias Yatzy.Roll
  alias Yatzy.Scoring
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
    field :ones, struct(), default: %Yatzy.Scoring.Ones{}
    field :twos, struct(), default: %Yatzy.Scoring.Twos{}
    field :threes, struct(), default: %Yatzy.Scoring.Threes{}
    field :fours, struct(), default: %Yatzy.Scoring.Fours{}
    field :fives, struct(), default: %Yatzy.Scoring.Fives{}
    field :sixes, struct(), default: %Yatzy.Scoring.Sixes{}
    field :one_pair, struct(), default: %Yatzy.Scoring.OnePair{}
    field :two_pairs, struct(), default: %Yatzy.Scoring.TwoPairs{}
    field :three_of_a_kind, struct(), default: %Yatzy.Scoring.ThreeOfAKind{}
    field :four_of_a_kind, struct(), default: %Yatzy.Scoring.FourOfAKind{}
    field :small_straight, struct(), default: %Yatzy.Scoring.SmallStraight{}
    field :large_straight, struct(), default: %Yatzy.Scoring.LargeStraight{}
    field :chance, struct(), default: %Yatzy.Scoring.Chance{}
    field :yatzy, struct(), default: %Yatzy.Scoring.Yatzy{}
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

      iex> Yatzy.Sheet.record(%Yatzy.Sheet{}, %Yatzy.Roll{dice: [1, 1, 1, 1, 1]}, :ones) |> Yatzy.Sheet.total()
      5

  """
  @spec record(sheet :: t(), roll :: Roll.t(), rule :: atom()) :: t()
  def record(sheet, roll, rule) do
    if valid_rule(sheet, rule) do
      Map.update!(sheet, rule, fn score -> update_roll(score, roll) end)
    else
      sheet
    end
  end

  @doc """
  Determine if the whole sheet has been filled out

  ## Example

      iex> Yatzy.Sheet.completed?(%Yatzy.Sheet{})
      false

  """
  @spec completed?(sheet :: t()) :: boolean()
  def completed?(sheet = %__MODULE__{}) do
    sheet
    |> Map.from_struct()
    |> Enum.all?(fn {_rule, scoring} ->
      scoring.roll.counter != 0 && scoring.roll.dice != []
    end)
  end

  @spec update_roll(score :: Scoring.t(), roll :: Roll.t()) :: Scoring.t()
  defp update_roll(score = %{roll: %Roll{dice: []}}, roll), do: %{score | roll: roll}
  defp update_roll(score, _), do: score

  @spec valid_rule(sheet :: t(), rule :: atom()) :: boolean()
  defp valid_rule(sheet, rule) do
    sheet |> Map.from_struct() |> Map.keys() |> Enum.member?(rule)
  end

  @spec section_total(sheet :: t(), [atom()]) :: integer()
  defp section_total(sheet = %__MODULE__{}, fields) do
    sheet
    |> Map.take(fields)
    |> Map.values()
    |> Enum.map(&Score.execute/1)
    |> Enum.sum()
  end

  @spec upper_section_bonus(total :: integer()) :: integer()
  defp upper_section_bonus(total) when total >= @upper_section_bonus_limit,
    do: @upper_section_bonus_value

  defp upper_section_bonus(_total), do: 0
end
