defmodule Yatzy.Scoring.TwoPairsTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.TwoPairs

  test "with no pairs" do
    roll = [1, 2, 3, 4, 5]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end

  test "with one pair of 1s" do
    roll = [1, 1, 3, 4, 5]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end

  test "with two pairs of 1s and 6s" do
    roll = [1, 1, 3, 6, 6]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 14
  end

  test "with three 2s" do
    roll = [2, 2, 2, 3, 4]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end

  test "with a full house" do
    roll = [1, 1, 2, 2, 2]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 6
  end

  test "with four 2s" do
    roll = [1, 2, 2, 2, 2]
    scoring = %TwoPairs{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end
end
