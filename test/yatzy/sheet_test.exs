defmodule Yatzy.SheetTest do
  use ExUnit.Case, async: true
  doctest Yatzy.Sheet

  alias Yatzy.Sheet

  test "a new sheet has a total score of zero" do
    assert Sheet.total(%Sheet{}) == 0
  end

  test "record a score" do
    roll = [1, 1, 1, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.total()

    assert total == 3
  end

  test "attempt to overwrite a score" do
    first_roll = [1, 2, 3, 4, 5]
    second_roll = [1, 1, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(first_roll, :ones)
      |> Sheet.record(second_roll, :ones)
      |> Sheet.total()

    assert total == 1
  end

  test "attempt to record on a non-existent rule" do
    roll = [1, 2, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :foo_bar)
      |> Sheet.total()

    assert total == 0
  end

  test "completing the upper section" do
    roll = [1, 2, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record(roll, :fives)
      |> Sheet.record(roll, :sixes)
      |> Sheet.total()

    assert total == 15
  end

  test "completing the upper section with 63 points" do
    total =
      %Sheet{}
      |> Sheet.record([1, 1, 1, 2, 3], :ones)
      |> Sheet.record([1, 2, 2, 2, 3], :twos)
      |> Sheet.record([1, 2, 3, 3, 3], :threes)
      |> Sheet.record([1, 2, 4, 4, 4], :fours)
      |> Sheet.record([1, 2, 5, 5, 5], :fives)
      |> Sheet.record([1, 2, 6, 6, 6], :sixes)
      |> Sheet.total()

    assert total == 113
  end

  test "completing the full sheet" do
    roll = [1, 2, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record(roll, :fives)
      |> Sheet.record(roll, :sixes)
      |> Sheet.record(roll, :one_pair)
      |> Sheet.record(roll, :two_pairs)
      |> Sheet.record(roll, :three_of_a_kind)
      |> Sheet.record(roll, :four_of_a_kind)
      |> Sheet.record(roll, :small_straight)
      |> Sheet.record(roll, :large_straight)
      |> Sheet.record(roll, :full_house)
      |> Sheet.record(roll, :chance)
      |> Sheet.record(roll, :yatzy)
      |> Sheet.total()

    assert total == 45
  end

  test "completing the full sheet with bonus" do
    roll = [1, 2, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record([5, 5, 5, 5, 5], :fives)
      |> Sheet.record([6, 6, 6, 6, 6], :sixes)
      |> Sheet.record(roll, :one_pair)
      |> Sheet.record(roll, :two_pairs)
      |> Sheet.record(roll, :three_of_a_kind)
      |> Sheet.record(roll, :four_of_a_kind)
      |> Sheet.record(roll, :small_straight)
      |> Sheet.record(roll, :large_straight)
      |> Sheet.record(roll, :full_house)
      |> Sheet.record(roll, :chance)
      |> Sheet.record(roll, :yatzy)
      |> Sheet.total()

    assert total == 145
  end

  test "completing the full sheet without bonus" do
    roll = [1, 2, 3, 4, 5]

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record(roll, :fives)
      |> Sheet.record(roll, :sixes)
      |> Sheet.record(roll, :one_pair)
      |> Sheet.record(roll, :two_pairs)
      |> Sheet.record(roll, :three_of_a_kind)
      |> Sheet.record(roll, :four_of_a_kind)
      |> Sheet.record(roll, :small_straight)
      |> Sheet.record(roll, :large_straight)
      |> Sheet.record(roll, :full_house)
      |> Sheet.record(roll, :chance)
      |> Sheet.record([5, 5, 5, 5, 5], :yatzy)
      |> Sheet.total()

    assert total == 95
  end
end
