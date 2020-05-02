defmodule Yatzy.Scoring.FourOfAKindTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.FourOfAKind
  alias Yatzy.Scoring.Score

  test "with 4 3s" do
    roll = %Roll{dice: [1, 3, 3, 3, 3]}
    scoring = %FourOfAKind{roll: roll}

    assert Score.execute(scoring) == 12
  end

  test "with 4 2s" do
    roll = %Roll{dice: [2, 2, 2, 2, 3]}
    scoring = %FourOfAKind{roll: roll}

    assert Score.execute(scoring) == 8
  end

  test "with 5 2s" do
    roll = %Roll{dice: [2, 2, 2, 2, 2]}
    scoring = %FourOfAKind{roll: roll}

    assert Score.execute(scoring) == 8
  end

  test "with anything else" do
    roll = %Roll{dice: [2, 3, 4, 4, 5]}
    scoring = %FourOfAKind{roll: roll}

    assert Score.execute(scoring) == 0
  end
end
