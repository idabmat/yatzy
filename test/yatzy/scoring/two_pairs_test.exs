defmodule Yatzy.Scoring.TwoPairsTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Score
  alias Yatzy.Scoring.TwoPairs

  test "with no pairs" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with one pair of 1s" do
    roll = %Roll{dice: [1, 1, 3, 4, 5]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with two pairs of 1s and 6s" do
    roll = %Roll{dice: [1, 1, 3, 6, 6]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 14
  end

  test "with three 2s" do
    roll = %Roll{dice: [2, 2, 2, 3, 4]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with a full house" do
    roll = %Roll{dice: [1, 1, 2, 2, 2]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 6
  end

  test "with four 2s" do
    roll = %Roll{dice: [1, 2, 2, 2, 2]}
    scoring = %TwoPairs{roll: roll}

    assert Score.execute(scoring) == 0
  end
end
