defmodule Yatzy.SheetTest do
  use ExUnit.Case, async: true
  alias Yatzy.Roll
  alias Yatzy.Sheet
  doctest Sheet

  test "a new sheet has a total score of zero" do
    assert Sheet.total(%Sheet{}) == 0
  end

  test "record a score" do
    roll = %Roll{dice: [1, 1, 1, 4, 5], counter: 1}

    total =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.total()

    assert total == 3
  end

  test "attempt to overwrite a score" do
    first_roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    second_roll = %Roll{dice: [1, 1, 3, 4, 5], counter: 1}

    total =
      %Sheet{}
      |> Sheet.record(first_roll, :ones)
      |> Sheet.record(second_roll, :ones)
      |> Sheet.total()

    assert total == 1
  end

  test "attempt to record on a non-existent rule" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}

    sheet =
      %Sheet{}
      |> Sheet.record(roll, :foo_bar)

    assert Sheet.total(sheet) == 0
    refute Sheet.completed?(sheet)
  end

  test "completing the upper section" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}

    sheet =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record(roll, :fives)
      |> Sheet.record(roll, :sixes)

    assert Sheet.total(sheet) == 15
    refute Sheet.completed?(sheet)
  end

  test "completing the upper section with 63 points" do
    sheet =
      %Sheet{}
      |> Sheet.record(%Roll{dice: [1, 1, 1, 2, 3], counter: 1}, :ones)
      |> Sheet.record(%Roll{dice: [1, 2, 2, 2, 3], counter: 1}, :twos)
      |> Sheet.record(%Roll{dice: [1, 2, 3, 3, 3], counter: 1}, :threes)
      |> Sheet.record(%Roll{dice: [1, 2, 4, 4, 4], counter: 1}, :fours)
      |> Sheet.record(%Roll{dice: [1, 2, 5, 5, 5], counter: 1}, :fives)
      |> Sheet.record(%Roll{dice: [1, 2, 6, 6, 6], counter: 1}, :sixes)

    assert Sheet.total(sheet) == 113
    refute Sheet.completed?(sheet)
  end

  test "completing the full sheet" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}

    sheet =
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

    assert Sheet.total(sheet) == 45
    assert Sheet.completed?(sheet)
  end

  test "completing the full sheet with bonus" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    fives = %Roll{dice: [5, 5, 5, 5, 5], counter: 1}
    sixes = %Roll{dice: [6, 6, 6, 6, 6], counter: 1}

    sheet =
      %Sheet{}
      |> Sheet.record(roll, :ones)
      |> Sheet.record(roll, :twos)
      |> Sheet.record(roll, :threes)
      |> Sheet.record(roll, :fours)
      |> Sheet.record(fives, :fives)
      |> Sheet.record(sixes, :sixes)
      |> Sheet.record(roll, :one_pair)
      |> Sheet.record(roll, :two_pairs)
      |> Sheet.record(roll, :three_of_a_kind)
      |> Sheet.record(roll, :four_of_a_kind)
      |> Sheet.record(roll, :small_straight)
      |> Sheet.record(roll, :large_straight)
      |> Sheet.record(roll, :full_house)
      |> Sheet.record(roll, :chance)
      |> Sheet.record(roll, :yatzy)

    assert Sheet.total(sheet) == 145
    assert Sheet.completed?(sheet)
  end

  test "completing the full sheet without bonus" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    fives = %Roll{dice: [5, 5, 5, 5, 5], counter: 1}

    sheet =
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
      |> Sheet.record(fives, :yatzy)

    assert Sheet.total(sheet) == 95
    assert Sheet.completed?(sheet)
  end
end
