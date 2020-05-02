defmodule Yatzy.Scoring.OnePairTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.OnePair
  alias Yatzy.Scoring.Score

  test "with no pairs" do
    roll = [1, 2, 3, 4, 5]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with one pair of 1s" do
    roll = [1, 1, 3, 4, 5]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 2
  end

  test "with one pair of 6s" do
    roll = [1, 2, 3, 6, 6]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 12
  end

  test "with two pairs of 1s and 6s" do
    roll = [1, 1, 3, 6, 6]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 12
  end

  test "with three 2s" do
    roll = [2, 2, 2, 3, 4]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 4
  end

  test "with a full house" do
    roll = [1, 1, 2, 2, 2]
    scoring = %OnePair{roll: roll}

    assert Score.execute(scoring) == 4
  end
end
